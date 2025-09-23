# Lab 3: Queue Channels - Filter Messages and Messaging Fairness using OCI Queue SDK

## Introduction

In this lab, you will learn how to use OCI Queue SDK to produce and consume messages while utilizing channels. Channels help ensure messaging fairness by categorizing messages and consuming them based on their assigned channel.

Estimated Lab Time: 30 minutes



### Objectives

In this lab, you will:

* Produce messages to Queue Channels using OCI SDK
* Filter messages and consume messages from Queue Channels using OCI SDK

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed


## Task 1:  Set Up the Environment

1. **Ensure Your Instance is Ready:**

	* Use the compute instance created in **Lab 2**.
	* Confirm Python and the OCI SDK are installed.

2. **Verify OCI Configuration:**

	* Ensure the *.oci/config* file is correctly set up with the required API credentials.
	* Test connectivity with a basic OCI SDK script to verify proper setup.

## Task 2: Write the Producer Application

1. **Create the Producer Script:**

	On your instance, create a file named *producer\_with\_channels.py*:

	```
	<copy>
	nano producer_with_channels.py
	</copy>
	```

	The producer code:

	```python
	<copy>
	import oci

	def send_messages(queue_id, message_content_list, channel_id=None):
		config = oci.config.from_file()
		queue_client = oci.queue.QueueClient(config, service_endpoint="https://cell-1.queue.messaging.<region>.oci.oraclecloud.com")   # Replace with your messaging endpoint

		messages = [
			oci.queue.models.PutMessagesDetailsEntry(
				content=content,
				metadata=oci.queue.models.MessageMetadata(
					channel_id=channel_id,
					custom_properties={
						'custom_key': 'custom_value'
					}
				) if channel_id else None
			)
			for content in message_content_list
		]
		put_message_details = oci.queue.models.PutMessagesDetails(messages=messages)

		response = queue_client.put_messages(queue_id=queue_id, put_messages_details=put_message_details)

		print("Messages sent successfully:")
		for put_message, message in zip(response.data.messages, messages):
			channel_metadata = message.metadata.channel_id if message.metadata else "None"
			print(f"Message ID: {put_message.id}, Channel ID: {channel_metadata}")

	if __name__ == "__main__":
		QUEUE_ID = "<Queue OCID>"   # Replace with your Queue OCID
		CHANNEL_ID = "Channel1"
		MESSAGE_CONTENT_LIST = ["Message 1", "Message 2", "Message 3"]

		send_messages(QUEUE_ID, MESSAGE_CONTENT_LIST, channel_id=CHANNEL_ID)
		print("Messages sent successfully.")
	</copy>
	```

2. **Run the Producer Script:**

	```
	<copy>
	python3 producer_with_channels.py
	</copy>
	```

3. **Verify Messages Sent:**

	* The script will print confirmation with message IDs and channel IDs.
	* Confirm the messages in the OCI Console under the **Queue Details** page.


## Task 3: Write the Consumer Application

1. **Create the Consumer Script:**

	On your instance, create a file named *consumer\_with\_channels.py*:

	```
	<copy>
	nano consumer_with_channels.py
	</copy>
	```

	The consumer code:

	```python
	<copy>
	import oci

	def receive_messages(queue_id, channel_id=None):
		config = oci.config.from_file()
		queue_client = oci.queue.QueueClient(config, service_endpoint="https://cell-1.queue.messaging.<region>.oci.oraclecloud.com") # Replace with your messaging endpoint

		get_messages_response = queue_client.get_messages(
			queue_id=queue_id,
			visibility_in_seconds=30,
			timeout_in_seconds=20,
			limit=5,
			channel_filter=channel_id
		)
		get_message_list = get_messages_response.data.messages

		if not get_message_list:
			print("No messages available to process.")
			return

		print("Received messages:")
		for get_message in get_message_list:
			print(f"Message ID: {get_message.id}")
			print(f"Content: {get_message.content}")
			print("-" * 30)

		delete_message_entry_list = [
			oci.queue.models.DeleteMessagesDetailsEntry(receipt=message.receipt)
			for message in get_message_list
		]

		if delete_message_entry_list:
			delete_details = oci.queue.models.DeleteMessagesDetails(entries=delete_message_entry_list)
			batch_delete_message_response = queue_client.delete_messages(queue_id=queue_id, delete_messages_details=delete_details)
			print("Acknowledged and deleted messages:")
			for entry in batch_delete_message_response.data.entries:
				if hasattr(entry, 'error_code'):
					print(f"Error code: {entry.error_code}, Error message: {entry.error_message}")
				else:
					print("Message deleted successfully")

	if __name__ == "__main__":
		QUEUE_ID = "<Queue OCID>"  # Replace with your Queue OCID 
		CHANNEL_ID = "Channel1"  # Optional: Replace with your Channel OCID

		receive_messages(QUEUE_ID, channel_id=CHANNEL_ID)
	</copy>
	```

2. **Run the Consumer Script:**

	```
	<copy>
	python3 consumer_with_channels.py
	</copy>
  	```

3. **Verify Messages Consumed:**

	* The script will print the details of received messages.
	* Ensure that the messages correspond to the specific channel (if filtered).

## Task 4: Test Messaging Fairness

1. **Simulate Multiple Producers and Consumers:**

	* Run the *producer\_with\_channels.py* with multiple channel IDs to simulate channel-based distribution.
	* Use multiple instances of the *consumer\_with\_channels.py* with specific channel filters.

2. **Monitor Message Flow:**

	* Ensure that each consumer only processes messages from its assigned channel.
	* Verify fairness in message distribution across channels in the OCI Console.

## Task 5: Cleanup (Optional)

1. **Delete Unprocessed Messages:**

	Ensure that all messages in the queue are processed and acknowledged.

2. **Terminate Resources:**

	If no longer needed, delete the queue and compute instance to avoid additional costs.

## Learn More

* [OCI Queue Blog](https://blogs.oracle.com/cloud-infrastructure/post/announcing-oci-queue)
* [OCI Queue Documentation](https://docs.oracle.com/en-us/iaas/Content/queue/home.htm)

## Acknowledgements

* **Author** - Abhishek Bhaumik, Product Manager
* **Last Updated By/Date** - Abhishek Bhaumik, January 2025
