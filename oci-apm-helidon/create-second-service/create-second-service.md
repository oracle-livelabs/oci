# Create a Second Service

## Introduction

In this lab, you will create a second Maven project, where the server listens on port 8081. You will configure APM tracer on this service, with similar steps to the Lab 2 and 3.

Estimated time: 10 minutes

### Objectives

* Create another Maven project to demonstrate a tracking of the requests that go from one service to another using APM Explorer.

### Prerequisites

* This Lab requires the completion of Lab 1, 2 and 3

## Task 1: Build another Maven project

1. Launch OCI Cloud Shell, if not opened already.

2. Ensure the Java version in the path is 11.0.7.
	``` bash
	<copy>
	java -version
	</copy>
	```
	![Cloud Shell](images/1-1-java.png " ")

	If you completed the Lab1 in a different Cloud Shell session, you will need to reset the JAVA_HOME environment variable, by running run the followings.

	``` bash
	<copy>
	export JAVA_HOME=~/graalvm-ce-java11-20.1.0
	export PATH="$JAVA_HOME/bin:$PATH"
	</copy>
	```

2.	From the home directory, run the Maven archetype:

	``` bash
	<copy>
  cd ~
	mvn -U archetype:generate -DinteractiveMode=false \
	    -DarchetypeGroupId=io.helidon.archetypes \
	    -DarchetypeArtifactId=helidon-quickstart-se \
	    -DarchetypeVersion=2.3.2 \
	    -DgroupId=io.helidon.examples \
	    -DartifactId=helidon-quickstart-se-2 \
	    -Dpackage=io.helidon.examples.quickstart.se
	</copy>
	```
  The project will be built and create a directory; ***helidon-quickstart-se-2***

## Task 2: Modify pom.xml file in the Helidon application

1.	From the ***helidon-quickstart-se-2*** directory,	open ***pom.xml*** file with an editor tool (e.g., vi tool)
	``` bash
	<copy>
	vi ~/helidon-quickstart-se-2/pom.xml
	</copy>
	```
   	>NOTE: For how to use the vi editor, refer to the Lab3, Task1, step 3

3.	Add the following repositories blocks between the ***properties*** and ***dependencies*** sections:

		<repositories>
		  <repository>
		    <id>oci</id>
		    <name>OCI Object Store</name>
		    <url>https://objectstorage.us-ashburn-1.oraclecloud.com/n/idhph4hmky92/b/prod-agent-binaries/o</url>
		  </repository>
		</repositories>
	![pom.xml](images/1-2-pomxml.png " ")
4.	At the end of the dependencies section, find a line ***&lt;/dependencies&gt;*** and add the followings before that line:

		<dependency>
		    <groupId>io.helidon.tracing</groupId>
		    <artifactId>helidon-tracing</artifactId>
		 </dependency>
		<dependency>
		    <groupId>com.oracle.apm.agent.java</groupId>
		    <artifactId>apm-java-agent-tracer</artifactId>
		    <version>[1.0.1389,)</version>
		</dependency>
		<dependency>
		    <groupId>com.oracle.apm.agent.java</groupId>
		    <artifactId>apm-java-agent-helidon</artifactId>
		    <version>[1.0.1389,)</version>
		</dependency>
	![pom.xml](images/1-1-pomxml.png " ")
5.	Save and close the file.

## Task 3: Modify application.yaml file

1.	Open application.yaml file with an editor.
	``` bash
	<copy>
	vi ~/helidon-quickstart-se-2/src/main/resources/application.yaml
	</copy>
	```
2.	Update the application.yaml file as in the below example. Note the port number is ***8081***. Ensure to replace ***&lt;data upload endpoint&gt;*** and ***&lt;private data key&gt;*** with the values collected from the Oracle Cloud console in the earlier steps.

		app:
		  greeting: "Hello from SE-2"

		server:
		  port: 8081
		  host: 0.0.0.0

		tracing:
		  name: "Helidon APM Tracer"
		  service: "helidon-http2"
		  data-upload-endpoint: <data upload endpoint of your OCI domain>
		  private-data-key: <private data key of your OCI domain>
		  collect-metrics: true
		  collect-resources: true
		  properties:
		    - key: com.oracle.apm.agent.log.level
		      value: INFO

	![Cloud Shell](images/3-1-applicationyaml.png " ")

3.	Save and close the file.

## Task 4: Modify Main.java file

1.	Open ***Main.java*** file with an editor on your choice.
	``` bash
	<copy>
	vi ~/helidon-quickstart-se-2/src/main/java/io/helidon/examples/quickstart/se/Main.java
	</copy>
	```
2.	Edit the file to configure the tracer.

 a.	Add the import statement below:
		 ``` bash
		 <copy>
		 import io.helidon.tracing.TracerBuilder;
		 </copy>
		 ```

 b.	In the startServer method, find a line ***.addMediaSupport(JsonpSupport.create())***. Add the following above that line:
		 ``` bash
		 <copy>
		 .tracer(TracerBuilder.create(config.get("tracing")).build())
		 </copy>
		 ```
Refer to the sample image below:

	![Main.java](images/3-1-main_java.png " ")

3.	Save and close the file.

## Task 5: Add custom span to GreetService class

1.	Open ***GreetService.java*** file with an editor
	``` bash
	<copy>
	vi ~/helidon-quickstart-se-2/src/main/java/io/helidon/examples/quickstart/se/GreetService.java
	</copy>
	```

2.	Edit the file.

 a.	Add the import statement below:
		 ``` bash
		 <copy>
		 import io.opentracing.Span;
		 </copy>
		 ```

	![GreetService.java](images/5-1-greetservice.png " ")
 b. Replace the ***getDefaultMessageHandler*** method with the following:
		 ``` bash
		 <copy>


		 private void getDefaultMessageHandler(ServerRequest request,
		                                    ServerResponse response) {
		     var spanBuilder = request.tracer()
		         .buildSpan("getDefaultMessageHandler");
		     request.spanContext().ifPresent(spanBuilder::asChildOf);
		     Span span = spanBuilder.start();
		     try {
		         sendResponse(response, "World");
		     } finally {
		         span.finish();
		     }
	   }

		</copy>
		```

	![GreetService.java](images/5-2-greetservice.png " ")
3.	Save and close the file.

## Task 6: Build and start the application

1.	From the ***helidon-quickstart-se-2*** directory, run MVN package, skipping unit tests.

	``` bash
	<copy>
	cd ~/helidon-quickstart-se-2/; mvn package -DskipTests=true
	</copy>
	```

 	 ![Cloud Shell](images/6-1-mvn.png " ")

	>NOTE: If your build fails with an error, run java -version and make sure it points to the JDK 11. If it does not return openjdk version"11.0.7", go back to the task 1 in this Lab and re-run the export commands to set the environment variable. This can happen when a session is interrupted during the lab exercise. Confirm the java version returns 11.0.7 and re-execute the mvn package command.  

  ![Cloud Shell](images/4-1-error-mvn.png " ")

2.	Start the application by running the application jar file

	``` bash
	<copy>
	nohup java -jar target/helidon-quickstart-se-2.jar&
	</copy>
	```
3.	Open a command shell in a new browser window. Test the application by running the curl command and verify the response. Note that the port number is 8081, not 8080.
	``` bash
	<copy>
	curl http://localhost:8081/greet
	</copy>
	```

	![Oracle Cloud console](images/6-2-greet_test.png " ")


## Task 7: Verify the traces of the second service in APM Trace Explorer

1.	From the OCI menu, select **Observability & Management**, then **Trace Explorer**.  Verify that there is a trace with the service name ***helidon-http2***.
	![Oracle Cloud console](images/7-1-trace_explorer.png " ")

 In the next Lab, you will modify the first service to call the second service.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,<br>
David Le Roy, Director, Product Management,<br>
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, December 2021
