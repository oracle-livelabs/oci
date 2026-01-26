# Lab 4: Decouple Application Components/Microservices Using Open-Source STOMP API

## Introduction

In this lab, you will use the open-source STOMP protocol to produce and consume messages from an OCI Queue. This lab demonstrates how to integrate with OCI Queues using STOMP for decoupling application components.


Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

* Produce messages to Queue using open source STOMP
* Consume messages from Queue using open source STOMP

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Prepare the Environment

1. **Ensure Your Instance is Ready:**

	* Use the compute instance created in **Lab 2**.
	* Ensure Python 3 is installed.

2. **Install Required Python Libraries:**

	Install the stomp.py library for STOMP integration:

	```
	<copy>
	pip3 install stomp.py
	</copy>
	```

	Confirm the installation:
	```
	<copy>
	python3 -c "import stomp; print('STOMP library installed successfully')"
	</copy>
	```

3. **Verify OCI Configuration:**

	Confirm the OCI Queue OCID, user credentials, and region-specific STOMP endpoint.

## Task 2: Generate OCI Credentials for STOMP

OCI Queue's STOMP endpoint uses credentials associated with Auth Tokens in OCI. Here is how to create them -

1. **Locate Your OCI Username**

	* Log in to the [OCI Console](https://www.oracle.com/cloud/sign-in.html)
	* Click your profile icon in the upper-right corner and select **User Settings**.
	* Note your **Username** from the details shown.

2. **Create an Auth Token for STOMP**

	* In the **User Settings**, scroll down to the Auth Tokens section.
	* Click **Generate Token**.
	* Provide a description (e.g., *STOMP Auth Token*) and click **Generate Token**.
	* Copy the generated token immediately. It will serve as your **password** for STOMP connections.

3. **Use Credentials in STOMP Applications**

	* **Username**: Your OCI username
	* **Password**: The Auth Token

## Task 3: Write the Producer Application

1. **Create the Producer Script:**

	On your instance, create a file named *stomp_producer.py*:

	```
	<copy>
	nano stomp_producer.py
	</copy>
	```

	Paste the producer code:

	```python
	<copy>
	import time
	import stomp
	import base64
	import ssl

	# OCI Queue ID and STOMP endpoint
	queue_id = '<Queue OCID>'  # Replace with your OCI Queue OCID
	hosts = [('cell-1.queue.messaging.<region>.oci.oraclecloud.com', 61613)]  # Replace with your region's STOMP host and port

	username = '<parent tenancy>/<user name>'   # Replace with your parent tenancy and user name
	password = '<password>'   # Replace with your password
	encoded_password = base64.b64encode(password.encode("utf-8")).decode("utf-8")

	conn = stomp.Connection(host_and_ports=hosts)
	conn.set_ssl(for_hosts=hosts)

	conn.connect(username=username, passcode=encoded_password, wait=True)

	try:
		print("Sending messages to OCI Queue...")
		count = 1
		while True:
			message = f'Hello OCI Queue via STOMP! Message {count}'
			conn.send(body=message, destination=queue_id)
			print(f"Sent message: {message}")
			count += 1
			time.sleep(1)

	except KeyboardInterrupt:
		print("Producer interrupted. Disconnecting...")
		conn.disconnect()

	</copy>
	```

2. **Run the Producer Script:**

	```
	<copy>
	python3 stomp_producer.py
	</copy>
	```

3. **Verify Messages Sent:**

	* The script will output sent messages.
	* Confirm the messages in the OCI Console under the Queue Details page.

## Task 4: Write the Consumer Application

1. **Create the Consumer Script:**
	On your instance, create a file named *stomp_consumer.py*:

	```
	<copy>
	nano stomp_consumer.py
	</copy>
	```

	The consumer code:

	```python
	<copy>
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
			self.conn.ack(id=frame.headers['message-id'], subscription=frame.headers['subscription'])
			print(f"Message {frame.headers['message-id']} acknowledged (deleted).")

	# OCI Queue configuration
	queue_id = '<Queue OCID>'  # Replace with your OCI Queue OCID
	hosts = [('cell-1.queue.messaging.<region>.oci.oraclecloud.com', 61613)]. # Replace region and port for SSL (61614)

	# OCI User credentials
	username = '<parent tenancy>/<user name>'.  # Replace with your OCI username
	password = '<password>'. # Replace with your OCI password
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

		conn.subscribe(destination=queue_id, id=1, ack='client-individual')

		print("Waiting for messages...")
		while True:
			time.sleep(1)

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
	python3 stomp_consumer.py
	</copy>
	```

3. **Verify Messages Consumed:**

	* The script will print received messages.
	* Acknowledged messages will be deleted from the queue.

## Task 5: Test the Producer and Consumer

1. **Simultaneous Testing:**

	* Open two terminal sessions.
	* Run the producer script in one session and the consumer script in another.
	* Verify real-time message exchange between the producer and consumer.

2. **Monitor Queue Activity:**

	Use the OCI Console to monitor the queue's activity and ensure messages are processed correctly.

## Task 6: Cleanup (Optional)

1. **Stop the Producer and Consumer:**

	Interrupt the running scripts using Ctrl+C.

2. **Delete Messages:**

	Ensure all messages in the queue are processed and acknowledged.

3. **Terminate Resources:**

	If no longer needed, delete the compute instance to avoid additional costs.

## Learn More

* [OCI Queue Blog](https://blogs.oracle.com/cloud-infrastructure/post/announcing-oci-queue)
* [OCI Queue Documentation](https://docs.oracle.com/en-us/iaas/Content/queue/home.htm)

## Acknowledgements

* **Author** - Abhishek Bhaumik, Product Manager
* **Last Updated By/Date** - Abhishek Bhaumik, January 2025
