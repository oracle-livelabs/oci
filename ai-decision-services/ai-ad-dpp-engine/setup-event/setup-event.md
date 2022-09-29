Lab 7: Setting up Events
===

OCI event is a service listening to desired change happening in the target service. Here is a list of [DB](https://docs.oracle.com/en-us/iaas/Content/Events/Reference/eventsproducers.htm#dbaasevents__AutoDB) and [Object Storage](https://docs.oracle.com/en-us/iaas/Content/Events/Reference/eventsproducers.htm#ObjectStor__bucket) related events that Event can monitor.

For us, go to Events Service → Rules → Create Rule, and create a rule as following:  
![](../attchments/Set-Ev2.png)

*   At event type, choose **Object Storage**, choosing **Object - Create** and **Object - Update**.
*   At attribute, choose **bucketName** as **Attribute**. Attribute Values should be **training-data-bucket** and **inferencing-data-bucket**, which we generated above.
    
*   At actions, choose **Functions** as action type, and select the right compartment, application and function we've just provisioned.

The finalized Rule Logic should look. like this:

```java
MATCH event WHERE (
  eventType EQUALS ANY OF (
    com.oraclecloud.objectstorage.updateobject,
    com.oraclecloud.objectstorage.createobject
  )
  AND (
    bucketName MATCHES ANY OF (
      training-data-bucket,
      inferencing-data-bucket
    )
  )
)
```

  

A sample event will look like this:

 Expand source

```java
{
  "eventType" : "com.oraclecloud.objectstorage.updateobject",
  "cloudEventsVersion" : "0.1",
  "eventTypeVersion" : "2.0",
  "source" : "ObjectStorage",
  "eventTime" : "2022-08-24T18:45:39Z",
  "contentType" : "application/json",
  "data" : {
    "compartmentId" : "<compartment_ocid>",
    "compartmentName" : "<compartment_name>",
    "resourceName" : "<dataset_name>",
    "resourceId" : "<resource_id>",
    "availabilityDomain" : "PHX-AD-1",
    "additionalDetails" : {
      "bucketName" : "<bucket_name>",
      "versionId" : "<version_id>",
      "archivalState" : "Available",
      "namespace" : "<namespace>",
      "bucketId" : "<bucket_ocid>",
      "eTag" : "<etag>"
    }
  },
  "eventID" : "<event_id>",
  "extensions" : {
    "compartmentId" : "<compartment_id>"
  }
}
```

Finally, enable the logs for troubleshooting purpose.

![](../attachments/Set-Ev1.png)