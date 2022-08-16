## Introduction

### Objectives

## Task 1: 

Run the following commands from within your VM instance.  
> **Note:** Replace `mycluster.opensearch.us.example.com` with your previously captured API endpoint.

1. Download the sample data set - `oci` index

   ```
   curl -O https://docs.oracle.com/en/learn/oci-opensearch/files/OCI_services.json
   ```

2. Create mapping (optional). If you don't run this command or any variation of it, a default mapping will be automatically created.


   ```
   curl -XPUT "https://mycluster.opensearch.us.example.com:9200/oci" -H 'Content-Type: application/json' --cacert cert.pem -d'
   {
     "mappings": {
       "properties": {
       "id": {"type": "integer"},
       "category": {"type": "keyword"},
      "text": {"type": "text"},
      "title": {"type": "text"},
      "url": {"type": "text"}
       }
     }
   }
   '
   ```

3. Push the data set.

   ```
   curl -H 'Content-Type: application/x-ndjson' -XPOST "https://mycluster.opensearch.us.example.com:9200/oci/_bulk?pretty" --data-binary @OCI_services.json --cacert cert.pem
   ```

4. Check your indices.

   ```
   curl "https://mycluster.opensearch.us.example.com:9200/_cat/indices" --cacert cert.pem
   ```

The response should show you the index you created, named `oci`.

## Task 2: Query the OCI Search Service – Sample search query

Run the following command:

   ```
   curl -X GET "https://mycluster.opensearch.us.example.com:9200/oci/_search?q=title:Kubernetes&pretty" --cacert cert.pem
   ```

For more information about query syntax, see the OpenSearch or ElasticSearch tutorials.  
