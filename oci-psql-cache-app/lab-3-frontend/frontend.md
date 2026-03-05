## Deploying the Application 

### Introduction
In this lab, you will deploy an application that connects to the OCI Cache and the OCI Database with PostgreSQL instances you created earlier.

**Estimated Time:** 25-40 minutes

## Task 1:Create the Compute Instance

1.	In the Cloud Console, navigate to Compute > Instances and click Create Instance
![Navigate to Compute Instances](images/compute-1.png)

2.	Click on Create Instance. Ensure the transport-lab-demo compartment is selected for this lab.
![Navigate to Create Instance](images/compute-2.png)

3.	Configure the Compute instance to use Oracle Linux 9 and select the transport-lab-vcn VCN created earlier in this lab.
![Configure the Compute Instance](images/compute-3.png)

## Task 2:Deploy the Application

1.	Clone the GitHub repository using the link below and follow the instructions:
https://github.com/phantompete/CachePostgres_LiveLab

**Reminder test with original primary endpoints for cache and postgres**
In the config.txt file, configure the following settings: 
-	PostgreSQL host
-	Redis host
-	OCI Region (where the instances are created)
-	Database Secret OCID 
-	Public Transport API key*
*To obtain a Public Transport API key, generate one on the Golemio API Keys Management page: https://api.golemio.cz/api-keys

Make the deployment script executable and then run it:
```sh
chmod +x deploy.sh  
./deploy.sh 
```

The deployment script performs the following actions:
- Unzip the compressed folder containing the necessary files.
- Automatically open the required firewall ports.
- Start the backend server on port 8585.
- Start the frontend server on port 8080.
- Install psql (required in later steps).
- Create the necessary database schema and tables.


2. In your browser, navigate to http://<public_IP>:<port> using the public IP of your Compute instance to access the application.
3. Confirm that the map appears in your browser. The application is connected to an empty database, so no data points are displayed yet. Load the necessary data into the database before continuing to enable interactive map features.
4. Download the data set from the provided link. Use the psql command-line tool, installed by the deployment script, to load the SQL script.  

Tip: To avoid manual transfers, use wget.

Run the following command to load the data:
```sql
psql copy stop_times from ‘/home/opc/pid_gtfs/stop_times.csv’ WITH (FORMAT csv, HEADER true)
```
This command imports records into the stop_times table.

Use the same steps to import data into the stops and routes tables.
```sql
psql copy stops from ‘/home/opc/pid_gtfs/stops.csv’ WITH (FORMAT csv, HEADER true)
psql copy routes from ‘/home/opc/pid_gtfs/routes.csv’ WITH (FORMAT csv, HEADER true)
```

## Task 3:Testing

1.	Now that the data is loaded, vehicles move on the map every 30 seconds (the cache’s API refresh interval). 
- Inspect the backend logs to see when each operation is fetched: from the API, database, or cache and how long it takes.

2.	What happens in the background? The sequence below explains the flow:
- Query the cache. On a cache miss, proceed to the next step. 
- Query the database or, if necessary, the third-party API.
- The first request retrieves data from the database and caches it; subsequent requests hit the cache, significantly improving performance. Cached data expires after 5 minutes.
- For vehicle locations: data is fetched directly from the third-party API and cached for 30 seconds to throttle API calls while delivering near-live updates.

3.	What problem are we solving here?
- Caching is often misunderstood as a simple, temporary buffer before writing data to the primary database. In this lab, we’ll implement a hybrid caching strategy to improve performance and scalability:
Read-through cache for static data (e.g., stops) with a 5-minute TTL.
Cache-aside or write-through for real-time data (e.g., vehicle locations) with a 30-second TTL.
- Timing comparisons to quantify latency savings and load reduction.
By offloading repetitive queries and throttling API calls, this approach lowers response times, reduces database and API load, and scales more efficiently under high traffic.
4.	Here’s an overview of how the backend is structured, how it connects to the frontend, and the key components of our data model and API:

-insert data model + diagram of the API- 

```json
GET /rt_routes/ 
[
  {
    "gtfs_trip_id": "X",
    "route_type": "Y",
    "gtfs_route_short_name": "Z"
  }
]

GET /rt_trip/${trip_id}
{
  "longitude": A,
  "latitude": B,
  "trip_id": "C",
  "start_timestamp": "D",
  "origin_timestamp": "E",
  "last_stop_id": "F",
  "last_stop_arrival": "G",
  "last_stop_departure": "H",
  "next_stop_id": "I",
  "next_stop_arrival": "J",
  "next_stop_departure": "K"
}

GET /trip/${trip_id}
[
  {
    "stop_id": "X",
    "arrival_time": "Y",
    "departure_time": "Z"
  }
]

GET /stop/${stop_id}
{
  "stop_id": "A",
  "stop_name": "B",
  "latitude": C,
  "longitude": D
}
```

5.	When you’ve completed the lab, delete the compute instance, database, and cache. If you’d like to continue exploring, keep those resources running.

## Summary

**Congratulations you have completed the workshop!**

You have successfully created and connected to OCI Database with PostgreSQL, OCI Cache and deployed an application that integrates the two solutions.

## Acknowledgments

- **Created By/Date** - Piotr Kurzynoga, Andriy Dorohkin, April 2026
- **Last Updated By** - Piotr Kurzynoga, April 2026