# Submit Jobs Directly to the cuOpt API

## Introduction

The cuOpt exposes routes the front-end uses through the backend.
Every ingress route needs a bearer JWT from the pack auth service.
The auth service enforces fine-grained scopes such as `cuopt.solve` and `cuopt.view`.

In this lab you write a small Python client.
The client signs in to the auth service.
It submits a routing payload and polls for the answer.
It prints the routes.
This is the same shape any production caller uses, such as a scheduler, a notebook, or another service.

Estimated Time: 15 minutes.

### Objectives

In this lab, you will:

- Call `/auth/login` and capture an access token.
- POST a routing payload to `/cuopt/request` with a bearer token.
- Poll `/cuopt/solution/{req_id}` until the answer arrives.
- Print the routes and total miles.

### Prerequisites

- Completed [Lab 4 - Submit an Optimization Job from the UI](?lab=change-dataset).
  - You must use your username and password from when you registered to the cuOpt frontend in this lab.
- Python 3.10 or newer on cloud shell.
- The script uses only `requests`.
- The `starter_pack_url` value from the stack outputs.
- The admin email and password.

## Task 1: Install Python Dependencies

1. Create a clean virtual env and install `requests`.

    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    pip install requests
    ```

## Task 2: Write the Client

1. Save the script below as `solve.py`.

    ```python
    # Submit a small VRP to the cuOpt pack.
    import json
    import math
    import os
    import sys
    import time
    import requests

    # Base URL of the pack.
    FRONTEND_URL=os.environ.get("FRONTEND_URL", "https://<frontend>")
    BASE_URL = os.environ.get("CUOPT_BASE_URL", "https://<starter_pack_host>")
    # Admin email.
    EMAIL = os.environ.get("CUOPT_EMAIL", "admin@example.com")
    # Admin password.
    PASSWORD = os.environ.get("CUOPT_PASSWORD", "ChangeMe1!")

    # cuOpt routes by INDEX into a cost matrix - it does not derive distances
    # from raw coordinates. Index 0 is the depot; indices 1..5 are the stops.
    # These (x, y) points are illustrative; swap in real coordinates as needed.
    LOCATIONS = [
        (0.0, 0.0),  # 0 depot
        (2.0, 1.0),  # 1
        (4.0, 2.0),  # 2
        (1.0, 5.0),  # 3
        (5.0, 4.0),  # 4
        (3.0, 6.0),  # 5
    ]


    def cost_matrix(points: list[tuple[float, float]]) -> list[list[float]]:
        # Symmetric Euclidean distance matrix; cuOpt indexes routes into this.
        return [
            [round(math.hypot(a[0] - b[0], a[1] - b[1]), 2) for b in points]
            for a in points
        ]


    def login() -> str:
        # Sign in and return the bearer token.
        resp = requests.post(
            f"{FRONTEND_URL}/auth/login",
            json={"email": EMAIL, "password": PASSWORD},
            timeout=15,
            verify=True,
        )
        # Raise on HTTP error.
        resp.raise_for_status()
        return resp.json()["access_token"]


    def solve(token: str) -> dict:
        # Three vehicles at the depot.
        fleet = {
            # Start position.
            "vehicle_locations": [[0, 0]] * 3,
            # Cargo room.
            "capacities": [[15, 15, 15]],
            # Time window.
            "vehicle_time_windows": [[0, 600]] * 3,
        }
        # Five stops with demands.
        tasks = {
            # Stop ids.
            "task_locations": [1, 2, 3, 4, 5],
            # Per-stop demand.
            "demand": [[3, 4, 4, 3, 2]],
            # Time window.
            "task_time_windows": [[0, 600]] * 5,
            # Service time.
            "service_times": [10, 10, 10, 10, 10],
        }
        # Five second solver budget.
        config = {"time_limit": 5}
        # Distance matrix over the six locations (depot + five stops). cuOpt
        # requires this - the *_locations above are indices into it.
        matrix = cost_matrix(LOCATIONS)
        # Assemble the payload. travel_time_matrix_data lets the solver honor the
        # task/vehicle time windows; reusing the distance matrix is fine here.
        payload = {
            "cost_matrix_data": {"data": {"0": matrix}},
            "travel_time_matrix_data": {"data": {"0": matrix}},
            "fleet_data": fleet,
            "task_data": tasks,
            "solver_config": config,
        }
        # Bearer header.
        headers = {"Authorization": f"Bearer {token}"}

        # POST the payload.
        submit = requests.post(
            f"{BASE_URL}/cuopt/request",
            json=payload,
            headers=headers,
            timeout=30,
        )
        # Raise on HTTP error.
        submit.raise_for_status()
        # Capture the request id.
        req_id = submit.json().get("reqId") or submit.json().get("request_id")

        # Poll for the answer. cuOpt is async: while the job is still running,
        # the solution endpoint keeps returning a bare {"reqId": ...} marker
        # (HTTP 200). Only once the solver section appears is the job done, so
        # keep polling until then rather than returning the first 200 body.
        for _ in range(30):
            poll = requests.get(
                f"{BASE_URL}/cuopt/solution/{req_id}",
                headers=headers,
                timeout=15,
            )
            if poll.status_code == 200:
                body = poll.json()
                # The result may be wrapped in {"response": {...}} or flat.
                container = body.get("response", body)
                if "solver_response" in container or "solver_infeasible_response" in container:
                    return body
            # Not ready yet - wait a second and try again.
            time.sleep(1)

        # Give up after 30 tries.
        raise TimeoutError("cuOpt answer did not return within 30s.")


    def main() -> None:
        # Sign in.
        token = login()
        # Solve.
        result = solve(token)
        # The solver result may be wrapped in {"response": {...}} or returned
        # flat. Feasible answers use "solver_response"; partial ones use
        # "solver_infeasible_response". The present key tells you which.
        container = result.get("response", result)
        solver = container.get("solver_response") or container.get("solver_infeasible_response")
        # If neither key is present the shape is unexpected - dump it so we can
        # see exactly what the solver returned.
        if not solver:
            print("Unexpected response shape. Raw payload:")
            print(json.dumps(result, indent=2)[:3000])
            return
        # Print whether the answer is feasible.
        print("Feasible:", "solver_response" in container)
        # Print how many vehicles the solver used.
        print("Vehicles used:", solver.get("num_vehicles"))
        # Print the total cost (the field is solution_cost, not total_cost).
        print("Total cost:", solver.get("solution_cost"))
        # Print each vehicle's route. Values are indices into LOCATIONS (0 = depot).
        for vehicle_id, info in (solver.get("vehicle_data") or {}).items():
            print(f"  vehicle {vehicle_id}: {info.get('route')}")


    if __name__ == "__main__":
        sys.exit(main())
    ```

## Task 3: Run the Script

1. Export the connection details and run the script.

    ```bash
    # Get the frontend URL for auth
    kubectl get ingress | grep demo-cuopt | awk '{print $3}'

    # demo-cuopt-partner.129-153-183-144.nip.io
    export BACKEND_URL=https://demo-cuopt-partner.129-153-183-144.nip.io

    ```bash
    # Get the cuOpt backend ingress URL:
    kubectl get ingress | grep 2-cuopt | awk '{print $3}'

    # cuopt-142039b6-2-cuopt-14.129-153-183-144.nip.io

    export CUOPT_BASE_URL=https://cuopt-142039b6-2-cuopt-14.129-153-183-144.nip.io
    ```

    Set the admin email.

    ```bash
    # Use the email you used to register to the frontend
    export CUOPT_EMAIL=workshop@oracle.com
    ```

    Set the admin password.

    ```bash
    # Use the password you used to register to the frontend
    export CUOPT_PASSWORD='YourSecurePassword1!'
    ```

    Run the script.

    ```bash
    python solve.py
    Feasible: True
      Vehicles used: 2
      Total cost: 21.359999656677246
        vehicle 0: [0, 1, 0]
        vehicle 1: [0, 3, 5, 4, 2, 0]
    ```

    You should see `Feasible: True`, a `Vehicles used` count, a `Total cost`
    value above zero, and one route line per vehicle (lists of location
    indices, where `0` is the depot).
    A `401` means the token expired or the creds are wrong.
    Rerun the script; it logs in fresh on each call.
    A `403` means the role lacks the `cuopt.solve` scope.
    Sign in as an admin and assign the role from the front-end Admin tab.

## Task 4: Inspect the Request in the Cluster

1. From cloud shell, watch the backend logs while the script runs.

    ```bash
    kubectl logs -n cuopt -l app.kubernetes.io/name=cuopt-backend --tail=20 -f
    ```

2. Run `python solve.py` again.

    You should see one `POST /api/cuopt/request` line.
    You should also see one `GET /api/cuopt/solution/{req_id}` line per loop in the backend pod log.
    Stop the tail with `Ctrl+C`.


Congratulations, you made it to the end of the labs!

## Learn More

- [cuOpt request payload docs](https://docs.nvidia.com/cuopt/user-guide/serv-api.html#post-cuopt-request).
- [`/auth/login` docs](https://github.com/oci-ai-incubations/accelerator-pack-auth-service).

## Acknowledgements

* **Author** - Dennis Kennetz, OCI AI Accelerator Program.
* **Last Updated By/Date** - Dennis Kennetz, May 2026.
