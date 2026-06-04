# Submit an Optimization Job from the UI

## Introduction

The cuOpt front-end is a React app on Nginx.
It loads a fleet plan.
It sends stops and vehicles to the backend.
The backend forwards the request to the NVIDIA cuOpt NIM.
The front-end then renders the routes on Google Maps or Leaflet.

In this lab you sign in to the front-end.
You pick a benchmark, configure a fleet, and run one cuOpt solve.
You will reuse the route output as the baseline for the dataset swap in Lab 5.

Estimated Time: 20 minutes.

### Objectives

In this lab, you will:

- Sign in to the cuOpt front-end.
- Pick a benchmark and set a fleet.
- Run a cuOpt solve.
- Review the routes, map, and impact panels.

### Prerequisites

- Completed [Lab 2 - Explore Pack Services](../explore-services/explore-services.md).
- The `starter_pack_url` from the stack outputs.
- The Blueprints admin credentials.

## Task 1: Sign In to VRP front-end

1. Open the **Outputs** tab of the Resource Manager stack (At Home).
   Or open the URL list your instructor shared (Live).

    - Search `starter_pack_url` and visit the output.

      ![image1.png](./images/image1.png)

    - **IMPORTANT**: The credentials here will be used in the next lab, please store them somewhere!
    - Register an account via the UI:

      ![image2.png](./images/image2.png)

      ![image3.png](./images/image3.png)

2. Select "Leaflet" as the "Maps" API:
    - Google is selected by default, switch to "Leaflet".

      ![image4.png](./images/image4.png)

      ![image5.png](./images/image5.png)

## Task 2: Configure Your Region

1. Click the **Configuration** tab on the left nav.

    - Click Configuration and view modifiable fields.

      ![image6.png](./images/image6.png)

    - Change the Country to the **United States > Save**.

      ![image7.png](./images/image7.png)

    - After this, feel free to investigate some of the other options.

## Task 3: Load a Benchmark Scenario

1. Return to the **Dashboard** tab.

    - The map should now show New York.

2. Set the fleet constraints.

    - Set **Vehicles** to `10`.
    - Set **Capacity per vehicle** to `50`.
    - Leave the job type mix at the defaults.

      ![image8.png](./images/image8.png)

3. Generate random stops.

    - Go to the **Stops** tab and click "Generate Random Stops".

      ![image9.png](./images/image9.png)

    - You will see them show up on the map.
    
      ![image10.png](./images/image10.png)

## Task 4: Run the Solve

1. Click **Run Optimization**.

    - Scroll down to the bottom of the "Stops" and click "Run Optimization."

      ![image11.png](./images/image11.png)

    - The front-end POSTs the payload to `/api/cuopt/request`.
    - The backend forwards it to the cuOpt NIM with the `cuopt.solve` scope on your JWT.
    - The request returns a request id.
    - The front-end polls `/api/cuopt/solution/{req_id}` until the answer arrives.
    - The solution can take 30 seconds.

2. Review the result.

    - The map updates with one color-coded polyline per vehicle.

      ![image12.png](./images/image12.png)

    - The **Routes** panel lists each vehicle stop sequence, distance, and duration.

      ![image13.png](./images/image13.png)

    - The **Impact** tab shows projected daily savings and jobs-per-tech metrics.

      ![image14.png](./images/image14.png)


## Task 5: Confirm the Job Hit the cuOpt NIM

1. View the pod logs in the Blueprints portal.

    - As a refresher from Lab 2, go back to the blueprints portal.
    - Go to pod logs.
    - Select the "default" namespace.
    - identify the "recipe-cuopt-**-2-cuopt" pod and **View Logs & Details**
    - Scroll to the bottom and see the log polling.

      ![image15.png](./images/image15.png)

2. Run a second solve from the UI.

    - Run a second solve with both UIs open and refresh the logs.

## Task 6: Download the generated dataset, modify, and rerun

1. Go back to the "Stops" tab in the VRP portal.

    - Go back to **Stops > Download CSV**

      ![image16.png](./images/image16.png)

    - Change the "demand" for stops 1,10,20,30,40,50.
    - Re-upload the CSV:
    
      ![image17.png](./images/image17.png)
    - Run optimize, explore results.

You have now completed the required part of the Lab! Congratulations.

Proceed to [Lab 5 - Submit Jobs Directly to the cuOpt API](../python-api/python-api.md).

## Learn More

- [NVIDIA cuOpt docs](https://docs.nvidia.com/cuopt/index.html).
- [Vehicle Routing Problem overview](https://en.wikipedia.org/wiki/Vehicle_routing_problem).

## Acknowledgements

* **Author** - Dennis Kennetz, OCI AI Accelerator Program.
* **Last Updated By/Date** - Dennis Kennetz, May 2026.
