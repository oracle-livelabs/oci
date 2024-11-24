# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available for review in VS Code.

You'll see how easy it is to configure a Micronaut application to publish metrics to OCI Monitoring with the GDK.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Application Dependencies

The build files contain the following dependencies to enable Micronaut's Micrometer integration with OCI Monitoring:

- `micronaut-micrometer-core`
- `micronaut-oraclecloud-bmc-monitoring`
- `micronaut-oraclecloud-micrometer`

_lib/pom.xml_

	<dependency>
		<groupId>io.micronaut.micrometer</groupId>
		<artifactId>micronaut-micrometer-core</artifactId>
		<scope>compile</scope>
	</dependency>

_oci/pom.xml_

	<dependency>
		<groupId>io.micronaut.micrometer</groupId>
		<artifactId>micronaut-micrometer-core</artifactId>
		<scope>compile</scope>
	</dependency>
	<dependency>
		<groupId>io.micronaut.oraclecloud</groupId>
		<artifactId>micronaut-oraclecloud-bmc-monitoring</artifactId>
		<scope>compile</scope>
	</dependency>
	...
	<dependency>
		<groupId>io.micronaut.oraclecloud</groupId>
		<artifactId>micronaut-oraclecloud-micrometer</artifactId>
		<scope>compile</scope>
	</dependency>

## Task 2: Review the Controller

The controller class `BookController` exposes the `Book` resource with REST APIs for the common CRUD operations.

_lib/src/main/java/com/example/BookController.java_

``` java
@Controller("/books") // <1>
@ExecuteOn(TaskExecutors.IO)
class BookController {
```

1. The class is defined as a controller with the [@Controller](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Controller.html) annotation mapped to the path `/books`.

``` java
@Get // <2>
@Timed("books.index") // <3>
Iterable<Book> index() {
   return bookRepository.findAll();
}
```

2. Maps a `GET` request to `/books`, which returns a list of all books. 

3. Creates a `Timer` metric with the name `books.index` that contains the `total time`, `max time` and `count`. The `@Timed` annotation is used to add timing support to methods such as those serving web request endpoints.

``` java
@Get("/{isbn}") // <4>
@Counted("books.find") // <5>
Optional<Book> findBook(String isbn) {
   return bookRepository.findByIsbn(isbn);
}
```

4. Maps a `GET` request to `/books/{isbn}` to find a book by its International Standard Book Number (ISBN).

5. Creates a `Counter` metric with the name `books.find` that only contains a count.

## Task 3: Review the Service Class

The service class `MicroserviceBooksNumberService` retrieves information from the database and publishes custom metrics based on it. In this example, the custom metrics reflect the number of books containing the word "microservices" in their title.

_lib/src/main/java/com/example/MicroserviceBooksNumberService.java_

``` java
@Singleton
public class MicroserviceBooksNumberService {

   ...
   private final Counter checks;
   private final Timer time;
   private final AtomicInteger microserviceBooksNumber = new AtomicInteger(0);
   ...

   MicroserviceBooksNumberService(BookRepository bookRepository,
                                 MeterRegistry meterRegistry) {
      this.bookRepository = bookRepository;
      checks = meterRegistry.counter("microserviceBooksNumber.checks");
      time = meterRegistry.timer("microserviceBooksNumber.time");
      meterRegistry.gauge("microserviceBooksNumber.latest", microserviceBooksNumber);
   }
```

The constructor registers the following custom meters:
- `microserviceBooksNumber.checks` stores the number of times this check is performed.
- `microserviceBooksNumber.time` stores the total time spent on each check.
- `microserviceBooksNumber.latest` stores the total number of books containing the word "microservices" in their title.

``` java
   public void updateNumber() {
      time.record(() -> {
         try {
               Iterable<Book> allBooks = bookRepository.findAll();
               long booksNumber = StreamSupport.stream(allBooks.spliterator(), false)
                     .filter(b -> b.getName().toLowerCase().contains(SEARCH_KEY))
                     .count();

               checks.increment();
               microserviceBooksNumber.set((int) booksNumber);
         } catch (Exception e) {
               log.error("Problem setting the number of microservice books", e);
         }
      });
   }
```

The `updateNumber()` method queries the database, counts the total number of books containing the word "microservices" in their title and updates the `microserviceBooksNumber.latest` meter with the value. It records the time taken and increments the number of times this check is performed.

``` java
   @Scheduled(fixedRate = "${customMetrics.updateFrequency:1h}",
            initialDelay = "${customMetrics.initialDelay:0s}")
   public void updateNumber() {
      ...
      ...
   }
```

The metric update is scheduled using the `@Scheduled` annotation. The `customMetrics.updateFrequency` parameter corresponds to the update rate and has a default value of one hour. The `customMetrics.initialDelay` parameter corresponds to a delay after application startup before the metrics calculation and has a default value of zero seconds.

## Task 4: Review the Books Database

The application uses [Micronaut integration with Flyway](https://micronaut-projects.github.io/micronaut-flyway/latest/guide/) to create a database schema on the fly.

Flyway migration is automatically triggered before your application starts. Flyway reads the migration file(s) from the _lib/src/main/resources/db/migration/_ directory. During application startup, Flyway runs the commands in the SQL file and creates the schema needed for the application.

Using the SQL statements in _V1__schema.sql_, Flyway creates a table with the name `book` and populates it with four records.

_lib/src/main/resources/db/migration/V1__schema.sql_

``` sql
DROP TABLE IF EXISTS book;

CREATE TABLE book (
    id   BIGINT NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
   name  VARCHAR(255) NOT NULL UNIQUE,
   isbn  CHAR(13) NOT NULL UNIQUE
);

INSERT INTO book (isbn, name)
VALUES ("9781491950357", "Building Microservices"),
       ("9781680502398", "Release It!"),
       ("9780321601919", "Continuous Delivery"),
       ("9781617294549", "Microservices Patterns");
```

## Task 5: Review the Metrics Collection Configuration

Several groups of metrics are enabled by default: these include system metrics (such as JVM information and uptime), as well as metrics tracking web requests, data sources activity, and others.

_oci/src/main/resources/application-oraclecloud.properties_

``` properties
# <1>
micronaut.metrics.enabled=true
# <2>
micronaut.metrics.binders.files.enabled=true
micronaut.metrics.binders.jdbc.enabled=true
micronaut.metrics.binders.jvm.enabled=true
micronaut.metrics.binders.logback.enabled=true
micronaut.metrics.binders.processor.enabled=true
micronaut.metrics.binders.uptime.enabled=true
micronaut.metrics.binders.web.enabled=true
# <3>
micronaut.metrics.export.oraclecloud.enabled=true
# <4>
micronaut.metrics.export.oraclecloud.namespace=gcn_metrics_oci
# <5>
micronaut.metrics.export.oraclecloud.compartmentId=${COMPARTMENT_OCID}
```

1. Overall metrics can be enabled or disabled. To disable, change to false.

2. Metrics groups can be individually enabled or disabled. In this case all metrics groups are enabled. To disable, change to false.

3. To export metrics to OCI, enable Oracle Cloud as an export location for Micrometer. Then create queries and monitor metrics in the OCI Monitoring service’s Metrics Explorer UI.

4. Set the namespace for metrics to something meaningful, for example, a name such as `gcn_metrics_oci`. The namespace groups the metrics in OCI Monitoring.

5. By default, metrics are published in the root compartment of your tenancy. The `compartmentId` property specifies the compartment to which metrics should be published.

**Note:** This way (`property: ${<placeholder>}`) of defining properties enables you to externalize the configuration easily. In this example, the value is picked up from an environment variable named `COMPARTMENT_OCID`.

In the next section, you will configure the application to use OCI Monitoring.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
