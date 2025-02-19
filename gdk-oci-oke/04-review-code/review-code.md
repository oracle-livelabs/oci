# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available for review in VS Code.

The application is a simple "RESTful" microservice that can upload, download, and delete users' profile pictures.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Build Configuration

1. The build files contain the following dependencies for OCI Object Storage.

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

2. The build file contains the following dependencies to enable [OKE Workload Identity Authentication](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contenggrantingworkloadaccesstoresources.htm).

_oci/pom.xml_

    <dependency>
        <groupId>io.micronaut.oraclecloud</groupId>
        <artifactId>micronaut-oraclecloud-oke-workload-identity</artifactId>
    </dependency>


3. The build file uses the `jib-maven-plugin` to build a container image with the application native executable:

_oci/pom.xml_

    <build>
        <plugins>
            <plugin>
                <groupId>com.google.cloud.tools</groupId>
                <artifactId>jib-maven-plugin</artifactId>
                <configuration>
                    <to>
                        <!-- <image>${project.name}</image> -->
                        <image>${jib.to.image}</image>
                    </to>
                    <from>
                        <image>${jib.from.image}</image>
                    </from>
                </configuration>
            </plugin>

4. The build file configures the native executable container image build using the following properties:

_oci/pom.xml_

    <properties>
        ...
        <!-- Runtime base container image to package the native executable -->
        <micronaut.native-image.base-image-run>frolvlad/alpine-glibc:alpine-3.16</micronaut.native-image.base-image-run>

        <!-- Using the latest GFTC Oracle GraalVM for JDK 17 Native Image container image to build the native executable -->
        <jib.from.image>container-registry.oracle.com/graalvm/native-image:17-ol8</jib.from.image>

        <!-- Using the OCIR Repo to push the generated runtime image containing the native executable -->
        <jib.to.image>${env.OCI_OS_OKE_IMAGE}</jib.to.image>
    </properties>



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


## Task 7: Review the Kubernetes API configuration files

Review the _auth.yml_ configuration file.

_auth.yml_

```
apiVersion: v1
kind: Namespace # <1>
metadata:
  name: ${K8S_NAMESPACE}
---
apiVersion: v1
kind: ServiceAccount # <2>
metadata:
  namespace: ${K8S_NAMESPACE}
  name: gdk-service-acct
---
kind: Role # <3>
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: ${K8S_NAMESPACE}
  name: gdk_service_role
rules:
  - apiGroups: [""]
    resources: ["services", "endpoints", "configmaps", "secrets", "pods"]
    verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding # <4>
metadata:
  namespace: ${K8S_NAMESPACE}
  name: gdk_service_role_bind
subjects:
  - kind: ServiceAccount
    name: gdk-service-acct
roleRef:
  kind: Role
  name: gdk_service_role
  apiGroup: rbac.authorization.k8s.io
```

  1. Create a Kubernetes namespace whose name is set using the environment variable `K8S_NAMESPACE`.

  2. Create a Kubernetes service account named `gdk-service-acct`.

  3. Create a Kubernetes role named `gdk_service_role`.

  4. Bind the role `gdk_service_role` to the service account `gdk-service-acct`.

Review the _k8s-oci.yml_ configuration file.

_k8s-oci.yml_

```
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: ${K8S_NAMESPACE} # <1>
  name: "gdk-os-oke-oci"
spec:
  selector:
    matchLabels:
      app: "gdk-os-oke-oci"
  template:
    metadata:
      labels:
        app: "gdk-os-oke-oci"
    spec:
      serviceAccountName: gdk-service-acct # <2>
      automountServiceAccountToken: true
      containers:
        - name: "gdk-os-oke-oci"
          image: ${OCI_OS_OKE_IMAGE} # <3>
          imagePullPolicy: Always # <4>
          ports:
            - name: http
              containerPort: 8080
          readinessProbe:
            httpGet:
              path: /health/readiness
              port: 8080
            initialDelaySeconds: 5
            timeoutSeconds: 3
          livenessProbe:
            httpGet:
              path: /health/liveness
              port: 8080
            initialDelaySeconds: 5
            timeoutSeconds: 3
            failureThreshold: 10
          env:
          - name: OCI_OS_NS # <5>
            value: ${OCI_OS_NS}
          - name: OCI_OS_BUCKET_NAME # <5>
            value: ${OCI_OS_BUCKET_NAME}
          - name: MICRONAUT_ENVIRONMENTS # <6>
            value: "oraclecloud"
      imagePullSecrets: # <7>
        - name: ocirsecret
---
apiVersion: v1
kind: Service
metadata:
  namespace: ${K8S_NAMESPACE} # <1>
  name: "gdk-os-oke-oci"
  annotations: # <8>
    oci.oraclecloud.com/load-balancer-type: "lb"
    service.beta.kubernetes.io/oci-load-balancer-shape: "flexible"
    service.beta.kubernetes.io/oci-load-balancer-shape-flex-min: "10"
    service.beta.kubernetes.io/oci-load-balancer-shape-flex-max: "10"
spec:
  selector:
    app: "gdk-os-oke-oci"
  type: LoadBalancer
  ports:
    - protocol: "TCP"
      port: 8080
```

  1. Add `metadata.namespace` to segregate user-defined resources and to simplify resource cleanup.

  2. Add `spec.serviceAccountName` to associate the service account with the pod. Add `spec.automountServiceAccountToken` and set it to `true`. These are needed to enable OKE Workload Identity for this deployment.

  3. Update the `spec.containers[0].image` to point to your image in OCIR using the environment variable `OCI_OS_OKE_IMAGE`.

  4. Add `spec.containers[0].imagePullPolicy`. In this example, we set it to `Always`.

  5. Add `spec.containers[0].env` to set the container environment variables `OCI_OS_NS` and `OCI_OS_BUCKET_NAME`. These two variables are used by the GDK application to access the OCI Object Storage Bucket at runtime.

  6. Set the container environment variable `MICRONAUT_ENVIRONMENTS` to `oraclecloud` to enable Micronaut to load the appropriate configuration file while starting the application.

  7. Add `imagePullSecrets` for OKE to pull a private container image from OCIR.

  8. Use these annotations to provision an [OCI Load Balancer with a flexible shape](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcreatingloadbalancers-subtopic.htm#flexible).

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
