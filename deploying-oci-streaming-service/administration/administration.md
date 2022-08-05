
# Stream Pools and Streams

## Introduction

**Stream pool** is a grouping mechanism that you can use to organize and manage streams, including any shared Kafka or security settings. Every stream needs to be a member of a stream pool. If you don't create a stream pool, the Streaming service uses a default pool to contain your streams.

You can use stream pools to:

- Organize streams into groups matching your organizational structure or a specific solution
- Restrict access to a specified virtual cloud network (VCN) inside your tenancy so that streams in the pool are not accessible through the internet
- Specify whether the data in the pool's streams should be encrypted using your own Vault encryption key or an Oracle-managed key

When you create a stream, you need to specify whether it should become a member of an existing stream pool, or a member of a new, automatically created stream pool. There is no limit to the number of stream pools you can create.

## Task 1 :Working with Stream Pools

1. check for the existing set of stream-pools you have in your compartment

    ```sh
    <copy>
    export COMPARTMENT_OCID=<compartment OCID>
    </copy>
    ```

    ```sh
    <copy>
    oci streaming admin stream-pool list -c $COMPARTMENT_OCID
    </copy>
    ```

2. Create a Stream pool with public endpoint

    ```sh
    <copy>
        oci streaming admin stream-pool create -c $COMPARTMENT_OCID --name MyPublicStreamPool
    </copy>
    ```

    For more complex configurations use this CLI command to get the example JSON strcture 

    ```sh
    <copy>
        oci streaming admin stream-pool create --generate-full-command-json-input
    </copy>
    ```

3. Deleting a stream pool

    ```sh
    <copy>
    export STREAM_POOL_OCID=<Stream pool OCID>
    </copy>
    ```

    ```sh
    <copy>
    oci streaming admin stream delete –stream-pool-id $STREAM_POOL_OCID
    </copy>
    ```

## Task 2 :Working with Streams

1. check for the existing set of streams you have in your compartment

    ```sh
    <copy>
    oci streaming admin stream list -c $COMPARTMENT_OCID
    </copy>
    ```

2. Create a stream in a stream pool with 2 partitions. One can also mention the retention time which is 24 hrs by default.

    ```sh
    <copy>
    oci streaming admin stream create --name <StreamName> --partitions 2 --stream-pool-id $STREAM_POOL_OCID
    </copy>
    ```

3. Deleting a stream

    ```sh
    <copy>
    export STREAM_OCID=<Stream OCID>
    </copy>
    ```

    ```sh
    <copy>
    oci streaming admin stream delete --stream-id $STREAM_OCID
    </copy>
    ```

## Acknowledgements

- **Author** - Nitin Soni
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Madhusudhan Rao, Apr 2022
