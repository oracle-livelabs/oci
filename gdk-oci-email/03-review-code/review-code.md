# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available in the _lab_ directory in VS Code.

You'll see how easy it is to configure a Micronaut application to send emails with OCI Email Delivery using the GDK.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Application Dependencies

The build file contain the following dependencies to support OCI Email Delivery.

- `micronaut-email-javamail` is mandatory
- `micronaut-email-template` and `micronaut-views-jte` are optional. These two libraries are required when using email templates.

_oci/pom.xml_

	<dependency>
		<groupId>io.micronaut.email</groupId>
		<artifactId>micronaut-email-javamail</artifactId>
		<scope>compile</scope>
	</dependency>
	<dependency>
		<groupId>io.micronaut.email</groupId>
		<artifactId>micronaut-email-template</artifactId>
		<scope>compile</scope>
	</dependency>
	<dependency>
		<groupId>io.micronaut.views</groupId>
		<artifactId>micronaut-views-jte</artifactId>
		<scope>compile</scope>
	</dependency>

## Task 2: Review the Session Provider

Micronaut Email requires a bean of type `SessionProvider` when using JavaMail to create a `Session`. The `SessionProviderImpl` class provides an implementation of the `SessionProvider` interface.

_oci/src/main/java/com/example/SessionProviderImpl.java_

``` java
@Singleton // <1>
class SessionProviderImpl implements SessionProvider {
```

1.	Use `jakarta.inject.Singleton` to designate a class as a singleton.

``` java
private final Properties properties;
private final String user;
private final String password;

SessionProviderImpl(MailPropertiesProvider provider,
				@Property(name = "smtp.user") String user, // <2>
				@Property(name = "smtp.password") String password) { // <2>
	this.properties = provider.mailProperties();
	this.user = user;
	this.password = password;
}
```

2.	Annotate a constructor parameter with `@Property` to inject a configuration value. The SMTP configuration is injected via constructor parameters annotated with `@Property`. Alternatively, use a POJO annotated with `@ConfigurationProperties`.

``` java
@Override
@NonNull
public Session session() {
return Session.getInstance(properties, new Authenticator() {
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(user, password); // <3>
	}
});
}
```

3. Use `user` and `password` to create the `Session`.

## Task 3: Review the Controller Implementation

The controller class `EmailController` uses the Micronaut `EmailSender` to send emails.

_oci/src/main/java/com/example/EmailController.java_

``` java
@ExecuteOn(TaskExecutors.IO) // <1>
@Controller("/email") // <2>
class EmailController {
```

1. It is critical that any blocking I/O operations (such as fetching the data from the database) are offloaded to a separate thread pool that does not block the Event loop.

2. The class is defined as a controller with the `@Controller` annotation mapped to the path `/email`.

``` java
private final EmailSender<?, ?> emailSender;

EmailController(EmailSender<?, ?> emailSender) { // <3>
this.emailSender = emailSender;
}
```

3. Use constructor injection to inject a bean of type `EmailSender`.

``` java
@Post(uri = "/basic", produces = TEXT_PLAIN) // <4>
String index() {
emailSender.send(Email.builder()
			.to(toEmail)
			.subject("Micronaut Email Basic Test: " + LocalDateTime.now())
			.body("Basic email")); // <5>
return "Email sent.";
}
```

4. By default, a Micronaut response uses `application/json` as `Content-Type`. In this case, the method returns a String, not a JSON object, so it is set to `text/plain`.

5. The method sends a plain-text email.

``` java
@Post(uri = "/template/{name}", produces = TEXT_PLAIN) // <4>
String template(String name) {
emailSender.send(Email.builder()
			.to(toEmail)
			.subject("Micronaut Email Template Test: " + LocalDateTime.now())
			.body(new TemplateBody<>(HTML,
				new ModelAndView<>("email", singletonMap("name", name))))); // <6>
return "Email sent.";
}
```

6. To send an HTML email, the method leverages Micronaut's template rendering capabilities.

``` java
@Post(uri = "/attachment", produces = TEXT_PLAIN, consumes = MULTIPART_FORM_DATA) // <7>
String attachment(CompletedFileUpload file) throws IOException {
emailSender.send(Email.builder()
			.to(toEmail)
			.subject("Micronaut Email Attachment Test: " + LocalDateTime.now())
			.body("Attachment email")
			.attachment(Attachment.builder()
				.filename(file.getFilename())
				.contentType(file.getContentType().orElse(APPLICATION_OCTET_STREAM_TYPE).toString())
				.content(file.getBytes())
				.build()
			)); // <8>
return "Email sent.";
}
```

7. A Micronaut controller action consumes `application/json` by default. Consuming other content types is supported with the `@Consumes` annotation or the `consumes` member of any HTTP method annotation.

8. The method sends an email with an attachment.

## Task 4: Review the Email Template

The sample application contains the following [JTE template](https://micronaut-projects.github.io/micronaut-views/latest/guide/#jte).

_oci/src/main/jte/email.jte_

	@param String name

	<!DOCTYPE html>
	<html lang="en">
	<body>
	<p>
    	Hello, <span>${name}</span>!
	</p>
	</body>
	</html>

## Task 6: Review the Email Sender Configuration

The following snippet configures the default sender details. By using placeholder variables such as `FROM_EMAIL` and `FROM_NAME`, you can externalize the values via environment variables and avoid hard-coding.

_oci/src/main/resources/application-oraclecloud.properties_

	# <1>
	micronaut.email.from.email=${FROM_EMAIL\:`default@gdk.example`}
	# <2>
	micronaut.email.from.name=${FROM_NAME\:'Default Sender'}

1. Sender’s email.
2. Sender’s name.

**Note:** This way (`property=${<placeholder>:<default-value>}`) of defining properties enables you to externalize the configuration easily. For example, if a configuration placeholder (`<placeholder>`) such as `FROM_NAME` is not defined, the Micronaut framework will use the default value (`<default-value>`) specified. So, in this case, if `FROM_NAME` is not specified, the Micronaut framework sets the value of `name` to `Default Sender`.

## Task 7: Review the SMTP configuration

The following snippet configures the SMTP credentials. This approach lets you externalize the values via environment variables or secure storage such as OCI Vault. 

_oci/src/main/resources/application-oraclecloud.properties_

	# <3>
	smtp.password=${SMTP_PASSWORD\:'default-pass'}
	# <4>
	smtp.user=${SMTP_USER\:'default-user'}

3. SMTP password.
4. SMTP username.

## Task 8: Review the JavaMail Properties Configuration

The following snippet configures the JavaMail properties:

_oci/src/main/resources/application-oraclecloud.properties_

	javamail.properties.mail.smtp.auth=true
	# <5>
	javamail.properties.mail.smtp.host=${SMTP_HOST\:'default-smtp.example'}
	javamail.properties.mail.smtp.port=587
	javamail.properties.mail.smtp.starttls.enable=true

5. SMTP server.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
