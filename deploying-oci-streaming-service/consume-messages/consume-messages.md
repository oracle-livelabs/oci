
# Consuming Messages

## Introduction

Estimated time: 20 min

Consuming messages from a stream requires you to:

1. Create a cursor.
2. Use the cursor to read messages.
3. Use the returned cursor to continue reading messages.

A cursor is a pointer to a location in a stream. The location could be a specific offset or time in a partition.

Before you start to consume messages, you need to indicate the point from which you want to start consumption. You can do this by creating a cursor using the CreateCursor API.

There are five supported cursor types:

- TRIM_HORIZON - Start consuming from the oldest available message in the stream.
- AT_OFFSET - Start consuming at a specified offset.
- AFTER_OFFSET - Start consuming after the given offset.
- AT_TIME - Start consuming from a given time. The timestamp of the returned message will be on or after the supplied time.
- LATEST - Start consuming messages that were published after you created the cursor.

Once you've created a cursor, you can start to consume messages using GetMessages.

As long as you keep consuming messages, there is no need to re-create a cursor, so cursors should be created outside of your loops to get messages.

### Objectives

- Consume messages as a individual consumer.
- Consume messages in a group.

### Prerequisites

- Stream Pool and stream is created.
- Sample messages are published to the stream.

## Individual Consumers

If you choose to use individual consumers to consume messages from your streams instead of using consumer groups, you can't take advantage of many of the benefits of Streaming, such as service-managed coordination, horizontal scaling, and offset management. Your applications will need to handle these scenarios.

When you create a cursor for an individual consumer, you need to specify the partition in the stream that the cursor should use. If your stream has more than one partition with messages, you need to create multiple cursors to read them.

Create the cursor for partition 0
```sh
<copy>
    oci streaming stream cursor create-cursor --partition 0 --stream-id $STREAM_OCID --type TRIM_HORIZON --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

Get the message using the cursor returned from create-cursor call or get message call
```sh
<copy>
    oci streaming stream message get --cursor $CURSOR --stream-id $STREAM_OCID --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

## Group Consumers

Consumers can be configured to consume messages as part of a group. Each stream partition is assigned to a member of a consumer group. An individual member of a consumer group is called an instance. Each instance in a consumer group receives messages from one or more partitions.

Consumer groups handle the coordination that is required for multiple consumers to share the consumption of a stream. A consumer group automatically:

- Assigns one or more partitions to an instance
- Tracks the messages received by the group and manages commits
- Requests the proper partition(s) and offset(s) on behalf of each instance
- Balances the group as instances join or leave

Each consumer group receives all of the messages in the stream at least once.

Consumer groups are ephemeral. They disappear when they're not used for the retention period of the stream.

A consumer group is created on the first CreateGroupCursor request. Group cursors define a group name/instance name pair. When you create your group cursor, you should provide the ID of the stream, a group name, an instance name, and one of the following supported cursor types TRIM_HORIZON, AT_TIME or LATEST

```sh
<copy>
oci streaming stream cursor create-group-cursor --group-name G1 --instance-name i1 --type TRIM_HORIZON --stream-id $STREAM_OCID --endpoint  https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

Get the message using the cursor returned from create-cursor call or get message call
```sh
<copy>
oci streaming stream message get --cursor $CURSOR --stream-id $STREAM_OCID --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

Check status of the group
```sh
<copy>
    oci streaming stream group get --group-name G1 --stream-id $STREAM_OCID --endpoint https://cell-1.streaming.us-phoenix-1.oci.oraclecloud.com
</copy>
```

## Acknowledgements

- **Author** - Nitin Soni
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Madhusudhan Rao, Apr 2022
