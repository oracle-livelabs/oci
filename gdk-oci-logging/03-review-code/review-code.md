# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available for review in VS Code.

You'll see how easy it is to configure a Micronaut application to send logs to OCI Logging with the GDK.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Application Dependencies

The build file contains the following dependency to support the [Logback](https://logback.qos.ch/) appender that pushes logs to Oracle Cloud.

_oci/pom.xml_

	<dependency>
		<groupId>io.micronaut.oraclecloud</groupId>
		<artifactId>micronaut-oraclecloud-logging</artifactId>
		<scope>compile</scope>
	</dependency>


## Task 2: Review the Controller

Our application contains a simple controller class, named `GreetingController`, containing a single method `greet` which is invoked by an HTTP POST request. The method has an informational log statement to log the greeting message.

_lib/src/main/java/com/example/GreetingController.java_

``` java
import org.slf4j.Logger; // <1>
import org.slf4j.LoggerFactory; // <1>

@Controller
class GreetingController {

    private static final Logger LOG = LoggerFactory.getLogger(GreetingController.class); // <2>

    @Post("/greet")
    void greet(@Body String message) {
        LOG.info(message); // <3>
    }
}
```

1. Import the Simple Logging Facade for Java (SLF4J) Logger and LoggerFactory classes. SLF4J serves as a simple facade or abstraction for various logging frameworks, such as `java.util.logging`, `logback` and `reload4j`. SLF4J enables the user to plug in the desired logging framework at deployment time.

2. Get a logger with the class name.

3. This logger is in turn used to log the message received in each POST request.

## Task 3: Review the Logback configuration

The Logback configuration has been modified by adding the `OracleCloudAppender` to send log statements to OCI Logging in addition to `STDOUT`.

_oci/src/main/resources/logback.xml_

	<configuration debug='false'>

		<appender name='STDOUT' class='ch.qos.logback.core.ConsoleAppender'>
			<encoder>
				<pattern>%cyan(%d{HH:mm:ss.SSS}) %gray([%thread]) %highlight(%-5level) %magenta(%logger{36}) - %msg%n</pattern>
			</encoder>
		</appender>
		<appender name='ORACLE' class='io.micronaut.oraclecloud.logging.OracleCloudAppender'>
			<!-- <appender-ref ref='STDOUT'/> -->
			<logId><!-- TODO set the value of the Oracle Cloud log OCID here --></logId>
			<encoder class='ch.qos.logback.core.encoder.LayoutWrappingEncoder'>
				<layout class='ch.qos.logback.contrib.json.classic.JsonLayout'>
					<jsonFormatter class='ch.qos.logback.contrib.jackson.JacksonJsonFormatter'/>
				</layout>
			</encoder>
		</appender>

		<root level='INFO'>
			<appender-ref ref='ORACLE'/>
			<appender-ref ref='STDOUT'/>
		</root>

	</configuration>

In the next section, you will configure OCI Logging and include the OCI Log OCID in the _logback.xml_ file.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
