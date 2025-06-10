# Lab 5: Queue Channels - Filter Messages and Messaging Fairness using open source STOMP API

## Introduction

This lab demonstrates how to produce and consume messages using the open-source STOMP protocol with OCI Queue channels. You will use channel metadata to enable message categorization and fairness in consumption.

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:

* Produce messages to Queue Channels using open-source STOMP
* Filter messages and consume messages from Queue Channels using open-source STOMP

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Prepare the Environment

1. **Ensure Your Instance is Ready:**

	* Use the compute instance created in **Lab 2**.
	* Confirm that Python 3 and the stomp.py library are installed:

	```
	<copy>
	pip3 install stomp.py
	</copy>
	```

2. **Verify OCI Configuration:**

	* Confirm your OCI Queue OCID, user credentials, and STOMP endpoint are correctly configured.
	* For channel-specific operations, verify that the channel ID is correctly defined.

## Task 2: Generate OCI Credentials for STOMP

OCI Queue's STOMP endpoint uses credentials associated with Auth Tokens in OCI. Here is how to create them:

1. **Locate Your OCI Username**

	* Log in to the [OCI Console](https://www.oracle.com/cloud/sign-in.html).
	* Click your profile icon in the upper-right corner and select **User Settings**.
	* Note your **Username** from the details shown.

2. **Create an Auth Token for STOMP**

	* In the **User Settings**, scroll down to the **Auth Tokens** section.
	* Click **Generate Token**.
	* Provide a description (e.g., *STOMP Auth Token*) and click **Generate Token**.
	* Copy the generated token immediately. It will serve as your **password** for STOMP connections.

3. **Use Credentials in STOMP Applications**
	**Username**: Your OCI username
	**Password**: The Auth Token


## Task 3: Write the Producer Application

1. **Create the Producer Script:**

	On your instance, create a file named *stomp_producer_channel.py*:

	```
	<copy>
	nano stomp_producer_channel.py
	</copy>
	```

	The producer code:

	```python
	<copy>
	#!/usr/bin/python3
	import time
	import stomp
	import base64
	import ssl

	# OCI Queue ID and STOMP endpoint
	queue_id = '<Queue OCID>'  # Replace with your OCI Queue OCID
	channel_id = f'{queue_id}/STOMPCH1'  # Replace with your Channel
	hosts = [('cell-1.queue.messaging.<region>.oci.oraclecloud.com', 61613)]  # Replace with your region's STOMP host and port

	# OCI User credentials
	username = '<parent tenancy>/<username>'  # Replace with your username
	password = '<password>'  # Replace with your password

	# Encode the password to Base64 as required for OCI STOMP connections
	encoded_password = base64.b64encode(password.encode("utf-8")).decode("utf-8")

	# Initialize STOMP connection with SSL
	conn = stomp.Connection(host_and_ports=hosts)
	conn.set_ssl(for_hosts=hosts)

	# Connect to the queue
	conn.connect(username=username, passcode=encoded_password, wait=True)

	try:
		print("Sending messages to OCI Queue with Channel...")
		count = 1
		while True:
			# Message content
			message = f'Hello OCI Queue via STOMP! Message {count}'

			# Include channel metadata in headers as needed
	#        headers = {
	#            'x-oci-metadata-channel-id': queue_id
	#            'x-oci-custom-properties-custom_key': 'custom_value'
	#        }

			# Send message to the destination queue
			conn.send(body=message, destination=channel_id) # include headers=headers if headers specified earlier
			print(f"Sent message: {message} via Channel: {channel_id}")
			count += 1
			time.sleep(1)  # Send messages every second

	except KeyboardInterrupt:
		print("Producer interrupted. Disconnecting...")
		conn.disconnect()
	except Exception as e:
		print(f"Error: {e}")
		conn.disconnect()

	</copy>
	```

2. **Run the Producer Script:**

	```
	<copy>
	python3 stomp_producer_channel.py
	</copy>
	```

3. **Verify Messages Sent:**

	* The script will output messages sent with the channel ID.
	* Check the OCI Console to verify the channel-specific messages.

## Task 4: Write the Consumer Application

1. **Create the Consumer Script:**

	On your instance, create a file named *stomp_consumer_channel.py*:

	```
	<copy>
	nano stomp_consumer_channel.py
	</copy>
	```

	The consumer code:

	```python
	<copy>
	#!/usr/bin/python3
	import time
	import stomp
	import base64
	import ssl

	# Define a Listener class inheriting from stomp.ConnectionListener
	class Listener(stomp.ConnectionListener):
		def __init__(self, conn):
			self.conn = conn

		def on_error(self, frame):
			print(f"Received an error: {frame.body}")

		def on_message(self, frame):
			print(f"Received a message: {frame.body}")

			# Acknowledge (delete) the message after processing
			self.conn.ack(id=frame.headers['message-id'], subscription=frame.headers['subscription'])
			print(f"Message {frame.headers['message-id']} acknowledged (deleted).")

	# OCI Queue configuration
	queue_id = '<Queue OCID>'  # Replace with your OCI Queue OCID
	channel_id = f'{queue_id}/STOMPCH1'  # Replace with your Channel
	hosts = [('cell-1.queue.messaging.<region>.oci.oraclecloud.com', 61613)]  # Replace region and port for SSL (61614)

	# OCI User credentials
	username = '<parent tenancy>/<username>'  # Replace with your OCI username
	password = '<password>'  # Replace with your OCI password

	# Encode the password to Base64
	encoded_password = base64.b64encode(password.encode("utf-8")).decode("utf-8")

	# Initialize STOMP connection with SSL
	conn = stomp.Connection(host_and_ports=hosts)
	conn.set_ssl(for_hosts=hosts, ssl_version=ssl.PROTOCOL_TLS)

	# Set the listener for handling messages
	conn.set_listener('', Listener(conn))

	# Connect to the queue
	try:
		print("Connecting to OCI Queue...")
		conn.connect(username=username, passcode=encoded_password, wait=True)
		print("Connected successfully.")

		# Subscribe to the queue with channel filter
		#Optional header as needed
	#    headers = {
	#        'x-oci-metadata-channel-id': queue_id
	#    }
		conn.subscribe(destination=channel_id, id=1, ack='client-individual') #include headers=headers if specified earlier

		print("Waiting for messages...")
		while True:
			time.sleep(1)  # Keep the consumer alive

	except KeyboardInterrupt:
		print("Disconnecting consumer...")
		conn.disconnect()

	except Exception as e:
		print(f"Error: {e}")
		conn.disconnect()
	</copy>
	```

2. **Run the Consumer Script:**

	```
	<copy>
	python3 stomp_consumer_channel.py
	</copy>
	```

3. **Verify Messages Consumed:**

	* The script will print received messages with the channel ID.
	* Confirm the messages are deleted after acknowledgment.

## Task 5: Test Messaging Fairness

1. **Simulate Multiple Channels:**

	* Modify the producer script to send messages to multiple channels.
	* Use separate consumer scripts to consume messages from different channels.

2. **Monitor Activity:**

	* Use the OCI Console to monitor message distribution across channels.
	* Verify that each channel's consumer receives only its designated messages.

## Task 6: Cleanup (Optional)

1. **Stop the Producer and Consumer:**

	* Interrupt the running scripts using Ctrl+C.

2. **Delete Messages:**

	* Ensure all messages in the queue and channels are processed and acknowledged.

3. **Terminate Resources:**

	* If no longer needed, delete the compute instance to avoid additional costs.

## Learn More

* [OCI Queue Blog](https://blogs.oracle.com/cloud-infrastructure/post/announcing-oci-queue)
* [OCI Queue Documentation](https://docs.oracle.com/en-us/iaas/Content/queue/home.htm)

## Acknowledgements

* **Author** - Abhishek Bhaumik, Product Manager
* **Last Updated By/Date** - Abhishek Bhaumik, January 2025
