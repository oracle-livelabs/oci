
# Message Publishing

Messages are published to a single partition in a stream. If there is more than one partition in the stream, the decision of which partition to publish the message to depends on whether your producers are using the Streaming API, or taking advantage of Streaming's Kafka compatibility and using the Kafka API.

The partition where a message is published is calculated using the message's key. If the key is null, the partition is calculated using a random 16-byte value. You cannot specify which partition a key uses. Passing a null key puts the message in a random partition.

## Handling Large Messages

If your messages are larger than the 1 MB limit, you can either use chunking or send the message by using Oracle Cloud Infrastructure Object Storage.

- Chunking: You can split large payloads into multiple, smaller chunks that the Streaming service can accept.
- Object Storage: A large payload is placed in Object Storage and only the pointer to that data is transferred.

## Publish message

```sh
<copy>
oci streaming stream message put --stream-id $STREAM_OCID --messages '[{"key":"string","value":"string"},{"key":"string","value":"string"}]' --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

OR

```sh
<copy>
oci streaming stream message put --stream-id $STREAM_OCID --messages file://msg.json --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

## Acknowledgements

- **Author** - Nitin Soni
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Madhusudhan Rao, Apr 2022