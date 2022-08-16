## Introduction

### Objectives

## Task 1: Create an OCI Search Service cluster

1. Open the Oracle Cloud Console navigation menu. Click **Databases**, **OCI Search Service**, and then click **Clusters**. Then, click **Create cluster**. Provide *opensearch-cluster* as name and select *opensearch-livelab* as the compartment where you want to create the cluster.

   <img src="../images/image1.png" alt="Oracle Cloud Console screen - Configure cluster" />

2. Click **Next**.
3. Choose the cluster sizing, and then click **Next**.

   <img src="../images/image2.png" alt="Oracle Cloud Console screen - Configure nodes" />

4. Select the VCN you created and then select the private subnet.

   <img src="../images/image3.png" alt="Oracle Cloud Console screen - Configure networking" />

5. Click **Next**.

   <img src="../images/image4.png" alt="Oracle Cloud Console screen - cluster details page, after cluster creation" />

6. Copy your API Endpoint, as found in the Cluster details page, in the Cluster information section.

## Task 2: OCI OpenSearch cluster health check

1. Connect to the instance via SSH:  

```
ssh -i ~/.ssh/<your_ssh_key> opc@<your_VM_instance_public_IP>
```

2. Download the required certificate:

```
curl -O https://docs.oracle.com/en/learn/oci-opensearch/files/cert.pem
```  

The certificate is downloaded and saved as `cert.pem`, in your current directory. This certificate is suitable for region `us-ashburn-1`.  

3. Run the following command, after replacing mycluster.opensearch.us.example.com with your search API endpoint:

```
curl https://mycluster.opensearch.us.example.com:9200 --cacert cert.pem
```

If all the steps were performed correctly you should see a response as follows:  

```
{
"name" : "opensearch-master-0",
"cluster_name" : "opensearch-cluster",
"cluster_uuid" : "ABCDEFT",
"version" : {
   "distribution" : "opensearch",
   "number" : "1.2.4-SNAPSHOT",
   "build_type" : "tar",
   "build_hash" : "eae8d26d675172402f2f2144ef0f",
   "build_date" : "2022-02-08T16:44:39.596468Z",
   "build_snapshot" : true,
   "lucene_version" : "8.10.1",
   "minimum_wire_compatibility_version" : "6.8.0",
   "minimum_index_compatibility_version" : "6.0.0-beta1"
},
"tagline" : "The OpenSearch Project: https://opensearch.org/"
}
```
