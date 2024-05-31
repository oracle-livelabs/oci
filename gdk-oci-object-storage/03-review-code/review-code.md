# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available in the _lab_ directory in VS Code.

The application is a simple "RESTful" microservice that can upload, download, and delete users' profile pictures.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Application Dependencies

The build files contain the following dependencies to support OCI Object Storage.

_lib/pom.xml_

	<dependency>
		<groupId>io.micronaut.objectstorage</groupId>
		<artifactId>micronaut-object-storage-core</artifactId>
		<scope>compile</scope>
	</dependency>

_oci/pom.xml_

	<dependency>
		<groupId>io.micronaut.objectstorage</groupId>
		<artifactId>micronaut-object-storage-oracle-cloud</artifactId>
		<scope>compile</scope>
	</dependency>
	<dependency>
		<groupId>io.micronaut.oraclecloud</groupId>
		<artifactId>micronaut-oraclecloud-sdk</artifactId>
		<scope>compile</scope>
	</dependency>

## Task 2: Review the Controller API

`ProfilePicturesApi` defines an interface with the three REST endpoints of the microservice.

_lib/src/main/java/com/example/ProfilePicturesApi.java_

	public interface ProfilePicturesApi {

		@Post(uri = "/{userId}", consumes = MULTIPART_FORM_DATA) // <1>
		HttpResponse<?> upload(CompletedFileUpload fileUpload, String userId, HttpRequest<?> request);

		@Get("/{userId}") // <2>
		Optional<HttpResponse<StreamedFile>> download(String userId);

		@Status(NO_CONTENT) // <3>
		@Delete("/{userId}") // <4>
		void delete(String userId);
	}

1. The [`@Post`](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Post.html) annotation maps the `upload` method to an HTTP POST request.

2. The [`@Get`](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Get.html) annotation maps the `download` method to an HTTP GET request.

3. You can return `void` in the controller’s method and specify the HTTP status code via the [`@Status`](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Status.html) annotation.

4. The [`@Delete`](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Delete.html) annotation maps the `delete` method to an HTTP DELETE request on `/{userId}`.

## Task 3: Review the Controller Implementation

The `ProfilePicturesController` class implements the `ProfilePicturesApi` interface.

_lib/src/main/java/com/example/ProfilePicturesController.java_

	@Controller(ProfilePicturesController.PREFIX) // <1>
	@ExecuteOn(TaskExecutors.IO) // <2>
	class ProfilePicturesController implements ProfilePicturesApi {

		static final String PREFIX = "/pictures";

		private final ObjectStorageOperations<?, ?, ?> objectStorage; // <3>
		private final HttpHostResolver httpHostResolver; // <4>

		ProfilePicturesController(ObjectStorageOperations<?, ?, ?> objectStorage,
								HttpHostResolver httpHostResolver) {
			this.objectStorage = objectStorage;
			this.httpHostResolver = httpHostResolver;
		}

1. The class is defined as a controller with the [`@Controller`](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Controller.html) annotation mapped to the path `/pictures`.

2. It is critical that any blocking I/O operations (such as fetching the data from the database) are offloaded to a separate thread pool that does not block the Event loop.

3. Inject a bean of type [`ObjectStorageOperations`](https://micronaut-projects.github.io/micronaut-object-storage/latest/api/io/micronaut/objectstorage/ObjectStorageOperations.html), the parent interface for object storage operations enables you to use the API in a generic way for all cloud providers.

4. [`HttpHostResolver`](https://docs.micronaut.io/latest/api/io/micronaut/http/server/util/HttpHostResolver.html) allows you to resolve the hostname for an HTTP request.

## Task 4: Review the Upload Endpoint

The `upload endpoint` receives a file from the HTTP client via `CompletedFileUpload` and the `userId` path parameter, uploads it to Object Storage using [`ObjectStorageOperations`](https://micronaut-projects.github.io/micronaut-object-storage/latest/api/io/micronaut/objectstorage/ObjectStorageOperations.html), and return its `ETag` in an HTTP response header to the client.

_lib/src/main/java/com/example/ProfilePicturesController.java_

	@Override
	public HttpResponse<?> upload(CompletedFileUpload fileUpload,
								String userId,
								HttpRequest<?> request) {
		String key = buildKey(userId); // <1>
		UploadRequest objectStorageUpload = UploadRequest.fromCompletedFileUpload(fileUpload, key); // <2>
		UploadResponse<?> response = objectStorage.upload(objectStorageUpload); // <3>

		return HttpResponse
					.created(location(request, userId)) // <4>
					.header(ETAG, response.getETag()); // <5>
	}

	private static String buildKey(String userId) {
		return userId + ".jpg";
	}

	private URI location(HttpRequest<?> request, String userId) {
		return UriBuilder.of(httpHostResolver.resolve(request))
					.path(PREFIX)
					.path(userId)
					.build();
	}

1. The key represents the object name under which the file will be stored.

2. You can use any of the [`UploadRequest`](https://micronaut-projects.github.io/micronaut-object-storage/latest/api/io/micronaut/objectstorage/request/UploadRequest.html) static methods to build an upload request.

3. The upload operation returns an [`UploadResponse`](https://micronaut-projects.github.io/micronaut-object-storage/latest/api/io/micronaut/objectstorage/response/UploadResponse.html), which wraps the cloud-specific SDK response.

4. Returns the absolute URL of the resource in the location header.

5. The response object contains some common properties for all cloud vendors, such as the `ETag`, that is sent in a header to the client.

## Task 5: Review the Download Endpoint

The `download endpoint` retrieves the object from Object Storage using the key and transforms it into a `StreamedFile`.

_lib/src/main/java/com/example/ProfilePicturesController.java_

	@Override
	public Optional<HttpResponse<StreamedFile>> download(String userId) {
		String key = buildKey(userId);
		return objectStorage.retrieve(key) // <1>
					.map(ProfilePicturesController::buildStreamedFile); // <2>
	}

	private static HttpResponse<StreamedFile> buildStreamedFile(ObjectStorageEntry<?> entry) {
		StreamedFile file = new StreamedFile(entry.getInputStream(), IMAGE_JPEG_TYPE).attach(entry.getKey());
		MutableHttpResponse<Object> httpResponse = HttpResponse.ok();
		file.process(httpResponse);
		return httpResponse.body(file);
	}

1. The retrieve operation returns an [`ObjectStorageEntry`](https://micronaut-projects.github.io/micronaut-object-storage/latest/api/io/micronaut/objectstorage/ObjectStorageEntry.html).

2. Transform the `ObjectStorageEntry` into an `HttpResponse<StreamedFile>`.

## Task 6: Review the Delete Endpoint

The `delete endpoint` deletes the object from Object Storage using the key.

_lib/src/main/java/com/example/ProfilePicturesController.java_

	@Override
	public void delete(String userId) {
		String key = buildKey(userId);
		objectStorage.delete(key);
	}

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
