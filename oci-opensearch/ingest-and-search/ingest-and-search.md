# Ingest data and search

## Introduction

In this lab, you will focus on creating an index by ingesting sample data to the OCI OpenSearch cluster, as well as running a search query. We have prepared a JSON file with sample data, which will be downloaded and used to create an index named `oci`.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
- Ingesting sample data to the OCI OpenSearch cluster, creating an index
- Run a sample search query to the Search API 

## Task 1: Ingest sample data

Run the following commands from within your VM instance.  
> **Note:** Replace `https://mycluster.opensearch.us.example.com:9200` with your previously captured API endpoint.

1. Download the sample data set - `oci` index

   ```bash
   <copy>curl -O "https://raw.githubusercontent.com/oracle-livelabs/oci/main/oci-opensearch/files/OCI_services.json"</copy>
   ```

2. Create mapping (optional). If you don't run this command or any variation of it, a default mapping will be automatically created.

   ```bash
   <copy>curl -XPUT "https://<opensearch_private_IP>:9200/oci4" -H 'Content-Type: application/json' -k -u <USERID:PASSWORD> -d '{        "mappings": {
    "properties": {
      "id": {"type": "integer"},
      "category": {"type": "keyword"},
      "text": {"type": "text"},
      "title": {"type": "text"},
      "url": {"type": "text"}
    }}}'
   </copy>
   ```

3. Push the data set.

   ```bash
   <copy>curl -H 'Content-Type: application/x-ndjson' -XPOST "https:// <opensearch_private_IP>:9200/oci/_bulk?pretty" --data-binary @OCI_services.json -k -u <USERID:PASSWORD></copy>
   ```

4. Check your indices.

   ```bash
   <copy>curl "https://mycluster.opensearch.us.example.com:9200/_cat/indices"</copy>
   ```

The response should show you the index you created, named `oci`.

## Task 2: Query the OCI Search Service – Sample search query

Run the following command:

   ```bash
   <copy>curl -X GET "https://<opensearch_private_IP>:9200/oci/_search?q=title:Kubernetes&pretty" --insecure -u <USERID:PASSWORD></copy>
   ```

For more information about query syntax, see the OpenSearch or ElasticSearch tutorials.  

## Acknowledgements

* **Author** - Nuno Gonçalves
* **Last Updated By/Date** - Hassan Ajan, August 2023
