# Lab 2: Decouple application components/ micro-services using OCI Queue SDK

## Introduction

In this lab, you will create a compute instance, install Python, set up the OCI SDK, and write producer and consumer applications to send and retrieve messages from an OCI Queue.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

* Produce messages to Queue using OCI SDK
* Consume messages from Queue using OCI SDK

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Create a Compute Instance

1. **Navigate to Compute Service:**

	* Log in to the [OCI Console](https://cloud.oracle.com/).
	* Open the navigation menu (☰), and under **Compute**, select **Instances**.

2. **Create a New Instance:**

	* Click **Create Instance**.
	* Enter the following details:
		* **Name**: Enter a name for the instance (e.g., OCIQueueLabInstance).
		* **Compartment**: Select the appropriate compartment.
		* **Image and Shape**:
			* Select the image (e.g., Oracle Linux 8 or Ubuntu 22.04).
			* Choose the shape based on your requirements (e.g., VM.Standard.E2.1).
		* **Networking**:
			* Select an existing Virtual Cloud Network (VCN) or create a new one.
			* Assign a public IP for easy SSH access.
	* Click **Create**.

3. **Connect to the Instance**:

	* Once the instance is running, copy the public IP.
	* Use an SSH client to connect:

		```
		<copy>
		ssh -i <path_to_private_key> opc@<instance_public_ip>
		</copy>
		```

## Task 2: Install Python and Required Packages

1. **Update the System:**

	```
	<copy>
	sudo apt update && sudo apt upgrade -y  # For Ubuntu sudo dnf update -y # For Oracle Linux
	</copy>
	```

2. **Install Python:**

	```
	<copy>
	sudo apt install python3 python3-pip -y  # For Ubuntu sudo dnf install python3 python3-pip -y # For Oracle Linux
	</copy>
	```

3. **Install OCI SDK:**

	```
	<copy>
	pip3 install oci
	</copy>
	```

4. **Verify Installation:**

	```
	<copy>
	python3 -c "import oci; print('OCI SDK Installed Successfully')"
	</copy>
	```

## Task 3: Set Up OCI Configuration

1. **Generate an API Key:**

	* In the OCI Console, go to your user profile and select API Keys.
	* Click **Add API Key → Generate API Key Pair**.
	* Download the private key and copy the public key fingerprint.

2. **Upload the Public Key to OCI:**

	Upload the public key to your user profile in OCI.

3. **Create the Configuration File:**

	On your instance, create a .oci directory:

	```ssh
	<copy>
	mkdir -p ~/.oci
	</copy>
	```

	Create the config file:

	```
	<copy>
	nano ~/.oci/config
	</copy>
	```

	Add the following content:

	```
	<copy>
	[DEFAULT]
	user=<user_ocid>
	fingerprint=<public_key_fingerprint>
	key_file=~/.oci/<private_key_filename>
	tenancy=<tenancy_ocid> region=us-phoenix-1
	</copy>
	```

	Replace placeholders (*user\_ocid*, *tenancy\_ocid*, etc.) with your specific details.

4. **Set Permissions:**

	```
	<copy>
	chmod 600 ~/.oci/<private_key_filename>
	</copy>
```

## Task 4: Write the Producer Application

1. **Create the Producer Script:**

	Save the provided producer code to a file named *producer.py*:

		```
		<code>
		nano producer.py
		</code>
		```

	The producer code:
	```python
	<copy>
	import oci

	def send_messages(queue_id, message_content_list):
		# Load the OCI config from the default file
		config = oci.config.from_file()

		# Initialize QueueClient
		queue_client = oci.queue.QueueClient(config, service_endpoint="https://cell-1.queue.messaging.<region>.oci.oraclecloud.com") #Replace with your messaging endpoint

		# Create message entries
		messages = [oci.queue.models.PutMessagesDetailsEntry(content=content) for content in message_content_list]
		put_message_details = oci.queue.models.PutMessagesDetails(messages=messages)

		# Send messages to the queue
		response = queue_client.put_messages(queue_id=queue_id, put_messages_details=put_message_details)

		print("Messages sent successfully:")
		for put_message in response.data.messages:
			print(f"Message ID: {put_message.id}")

	if __name__ == "__main__":
		QUEUE_ID = "<Queue OCID>"  # Replace with your OCI Queue OCID
		REGION = "us-phoenix-1"  # Replace with your region
		MESSAGE_CONTENT_LIST = ["Message 1", "Message 2", "Message 3"]

		send_messages(QUEUE_ID, MESSAGE_CONTENT_LIST)
	</copy>
	```

2. **Run the Producer Script:**

	```
	<copy>
	python3 producer.py
	</copy>
	```

3. **Verify Message Sent:**
Check the OCI Console to see messages in the queue.


## Task 5: Write the Consumer Application

1. **Create the Consumer Script:**

	Save the provided consumer code to a file named *consumer.py*:

	```
	<copy>
	nano consumer.py
	</copy>
	```

	The consumer code:
	```python
	<copy>
	import oci

	def receive_messages(queue_id):
		# Load the OCI config from the default file
		config = oci.config.from_file()

		# Initialize QueueClient
		queue_client = oci.queue.QueueClient(config, service_endpoint="https://cell-1.queue.messaging.<region>.oci.oraclecloud.com") #Replace with your messaging endpoint

		# Retrieve messages from the queue
		get_messages_response = queue_client.get_messages(queue_id=queue_id, limit=5)
		get_message_list = get_messages_response.data.messages

		print("Received messages:")
		for get_message in get_message_list:
			print(f"Message ID: {get_message.id}")
			print(f"Receipt: {get_message.receipt}")
			print(f"Content: {get_message.content}")
			print(f"Visible After: {get_message.visible_after}")
			print(f"Expire After: {get_message.expire_after}")
			print(f"Delivery Count: {get_message.delivery_count}")
			print("-" * 30)

		# Acknowledge and delete messages from the queue
		delete_message_entry_list = [oci.queue.models.DeleteMessagesDetailsEntry(receipt=message.receipt) for message in get_message_list]

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
		QUEUE_ID = "<Queue OCID>"   # Replace with your OCI Queue OCID

		receive_messages(QUEUE_ID)

	</copy>
	```

2. **Run the Consumer Script:**

	```
	<copy>
	python3 consumer.py
	</copy>
	```

3. **Verify Message Retrieval:**
Ensure that messages are retrieved and acknowledged as deleted in the OCI Console.

## Learn More

* [OCI Queue Blog](https://blogs.oracle.com/cloud-infrastructure/post/announcing-oci-queue)
* [OCI Queue Documentation](https://docs.oracle.com/en-us/iaas/Content/queue/home.htm)

## Acknowledgements

* **Author** - Abhishek Bhaumik, Product Manager
* **Last Updated By/Date** - Abhishek Bhaumik, January 2025
