# Build and Run the Application

## Introduction

This lab takes you through the steps to build and run the sample application, and use it to upload, download, and delete pictures from the OCI Object Storage bucket.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Build and run the application
* Upload a picture
* Download the picture
* Delete the picture
* Stop the application

## Task 1: Build and run the application

1. In the same terminal in VS Code, run the following command(s).

<if type="mn_run">
   Use `mn:run` to build and start the application on port 8080.

	``` bash
	<copy>
	./mvnw install -pl lib -am && ./mvnw mn:run -pl oci
	</copy>
	```
</if>

<if type="jar">
   Build an executable JAR file and then use `java -jar` to run it.

	``` bash
	<copy>
	./mvnw clean && ./mvnw install -pl lib -am && ./mvnw package -pl oci

	java -jar oci/target/oci-1.0-SNAPSHOT.jar
	</copy>
	```
</if>

## Task 2: Upload a picture

1. Open a second terminal in VS Code using the **Terminal** >> **New Terminal** menu.

2. From the second terminal, send an HTTP POST request to the `/pictures/{userId}` endpoint to upload a picture to the bucket:

	``` bash
	<copy>
	curl -i -F 'fileUpload=@test-data/pic1.jpg' http://localhost:8080/pictures/user1
	</copy>
	```

   VS Code may prompt you to open the URL in a browser as shown below. Just click the **Configure Notifications** gear icon and then click **Don't Show Again**.

   ![VS Code Ports](images/vscode-ports.png)

   ![VS Code Don't Show Again](images/vscode-dont-show-again.png)

3. Check the bucket contents. Go to the **OCI Console** >> **Storage** >> **Object Storage & Archive Storage** >> **Buckets** >> **Bucket Details** screen opened in the browser.

   Refresh the screen and scroll down to the **Objects** list. You should see an object named _user1.jpg_.

   ![Objects List](images/objects-list-user1.jpg)

## Task 3: Download the picture

1. From the second terminal in VS Code, send an HTTP GET request to the `/pictures/{userId}` endpoint to download the picture from the bucket:

	``` bash
	<copy>
	curl http://localhost:8080/pictures/user1 -O -J
	</copy>
	```

2. You should see the profile picture _user1.jpg_ downloaded in the _LAB_ directory in VS Code. Click the picture to view it.

   ![View Picture](./images/view-pic-user1.jpg)

## Task 4: Delete the picture

1. From the second terminal in VS Code, send an HTTP DELETE request to the `/pictures/{userId}` endpoint to delete the picture from the bucket:

	``` bash
	<copy>
	curl -X DELETE http://localhost:8080/pictures/user1
	</copy>
	```

2. Check the bucket contents. Go to the **OCI Console** >> **Storage** >> **Object Storage & Archive Storage** >> **Buckets** >> **Bucket Details** screen opened in the browser.

   Refresh the screen and scroll down to the **Objects** list. The object _user1.jpg_ has been deleted from the bucket.

   ![Objects List](./images/objects-list-empty.jpg)

## Task 5: Stop the application

1. In the first terminal in VS Code, use `CTRL+C` to stop the application.

Congratulations! You've successfully completed this lab. Your Java application can successfully upload, download and delete pictures from the OCI Object Storage bucket.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
