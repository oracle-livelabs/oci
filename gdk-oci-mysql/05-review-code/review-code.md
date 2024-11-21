# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available for review in VS Code.

The sample `Genre` application is a part of a larger `Books` demo application. However, the main goal of this lab is to demonstrate OCI MySQL HeatWave Database connectivity using GDK. Hence, the scope of the application is limited to just a single entity called `Genre` with just two columns (an ID and a name).

The application is a simple "RESTful" microservice that exposes CRUD-like operations as APIs to list, get, put, and delete the `Genre` entity. The entity is mapped to an MySQL HeatWave Database table using the Micronaut Data JDBC feature.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Review the Data Source Configuration

The configuration file contains the datasource definition

_oci/src/main/resources/application-oraclecloud.properties_

``` properties
datasources.default.db-type=mysql
datasources.default.dialect=MYSQL
datasources.default.driver-class-name=com.mysql.cj.jdbc.Driver
datasources.default.url=${DATASOURCES_DEFAULT_URL:`jdbc:mysql://localhost:3306/db`}
datasources.default.username=${JDBC_USER:sherlock}
datasources.default.password=${JDBC_PASSWORD:elementary}
```

The use of properties, in the form `property: ${<env-var>:<default-value>}`, to define the datasource
enables the configuration to be externalized. For example, if an environment variable (`<env-var>`) such as `DATASOURCES_DEFAULT_URL` is not defined, the Micronaut framework will use the default value (`<default-value>`) specified.
So if `DATASOURCES_DEFAULT_URL` is not specified, the Micronaut framework sets the value of `url` to `jdbc:mysql://localhost:3306/db`.

## Task 2: Review the Database Migration with Flyway

[Flyway](https://flywaydb.org/documentation/) automates schema changes, significantly simplifying schema management tasks, such as migrating, rolling back, and reproducing in multiple environments.

The application uses [Micronaut integration with Flyway](https://micronaut-projects.github.io/micronaut-flyway/latest/guide/) to create a database schema on the fly by:

1. Including the following dependencies:

	_oci/pom.xml_

	``` xml
	<dependency>
		<groupId>io.micronaut.flyway</groupId>
		<artifactId>micronaut-flyway</artifactId>
		<scope>compile</scope>
	</dependency>
	```

	``` xml
	<dependency>
		<groupId>org.flywaydb</groupId>
		<artifactId>flyway-mysql</artifactId>
		<scope>runtime</scope>
	</dependency>
	```

2. Enabling Flyway in the _application-oraclecloud.properties_ file for the `default` datasource:

	_oci/src/main/resources/application-oraclecloud.properties_

	```properties
	flyway.datasources.default.enabled=true
	```

	Flyway migration is automatically triggered before the application starts. Flyway will read migration commands in the _resources/db/migration/_ directory, run them if necessary, and verify that the configured data source is consistent with them.

3. Creating an SQL file to create a `genre` table in the database:

	_lib/src/main/resources/db/migration/V1\_\_schema.sql_

	``` sql
	DROP TABLE IF EXISTS genre;
	
	CREATE TABLE genre (
		id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		name  VARCHAR(255) NOT NULL UNIQUE
	);
	```

   During application startup, Flyway runs the commands in this SQL file and creates the schema needed for the application.

## Task 3: Review the Domain Entity

In this example, the domain entity is a simple `Genre` object that maps to the `genre` table. It has an auto-generated `id` and a unique `name`.

_lib/src/main/java/com/example/domain/Genre.java_

``` java
@Serdeable
@MappedEntity // <1>
public class Genre {
```

1. `@MappedEntity` specifies that the entity is mapped to the database. If your table name differs from the entity name, pass the table name as the value. For example: `@MappedEntity(value = "TABLE_NAME")`. In the case of this application, the table name `genre` matches the entity name `Genre`.

## Task 4: Review the Repository Access

The repository interface `GenreRepository` defines the operations to access the database. Micronaut Data implements the interface at compilation time:

_lib/src/main/java/com/example/repository/GenreRepository.java_

``` java
@JdbcRepository(dialect = MYSQL) // <1>
public interface GenreRepository extends PageableRepository<Genre, Long> { // <2>

    Genre save(@NonNull @NotBlank String name); // <3>
```

1. `@JdbcRepository` with a specific dialect: `MYSQL` in this example.

2. `Genre`, the entity to treat as the root entity for the purposes of querying, is established either from the method signature or from the generic type parameter specified to the `GenericRepository` interface. The repository extends from `PageableRepository`. It inherits the hierarchy `PageableRepository` → `CrudRepository` → `GenericRepository`.

    - `PageableRepository`: A repository that supports pagination. It provides `findAll(Pageable)` and `findAll(Sort)`.
    - `CrudRepository`: A repository interface for performing CRUD (Create, Read, Update, Delete). It provides methods such as `findAll()`, `save(Genre)`, `deleteById(Long)`, and `findById(Long)`.
    - `GenericRepository`: A root interface that features no methods but defines the entity type and ID type as generic arguments.

3. Micronaut validation is built on the standard framework – [JSR 380](https://jcp.org/en/jsr/detail?id=380), also known as Bean Validation 2.0. Micronaut [has built-in support for validation of beans](https://docs.micronaut.io/latest/guide/#beanValidation) that are annotated with `javax.validation` annotations. The necessary dependencies are included by default when creating a new application, so you don’t need to add anything else.

## Task 5: Review the Controller

The controller class `GenreController` exposes the `Genre` resource with REST APIs for the common CRUD operations.

_lib/src/main/java/com/example/controller/GenreController.java_

``` java
@ExecuteOn(TaskExecutors.IO) // <1>
@Controller("/genres") // <2>
class GenreController {
```

1. It is critical that any blocking I/O operations (such as fetching data from a database) are offloaded to a separate thread pool that does not block the Event loop.

2. The class is defined as a controller with the [@Controller](https://docs.micronaut.io/latest/api/io/micronaut/http/annotation/Controller.html) annotation mapped to the path `/genres`.

``` java
private final GenreService genreService;

GenreController(GenreService genreService) { // <3>
    this.genreService = genreService;
}
```

3. Use constructor injection to inject a bean of type `GenreService`.

``` java
@Get("/{id}") // <4>
public Optional<Genre> show(Long id) {
    return genreService.findById(id); // <5>
}
```

4. Maps a `GET` request to `/genres/{id}`, which attempts to show a genre. This illustrates the use of a URL path variable `id`.

5. Returning an empty optional when the genre doesn’t exist makes the Micronaut framework respond with 404 (not found).

``` java
@Put("/{id}/{name}") // <6>
public HttpResponse<?> update(long id, String name) {
    genreService.update(id, name);
    return HttpResponse
            .noContent()
            .header(LOCATION, URI.create("/genres/" + id).getPath()); // <7>
}
```

6. Maps a `PUT` request to `/genres/{id}/{name}`, which attempts to update the corresponding genre name. This illustrates the use of URL path variables `id` and `name`.

7. It is easy to add custom headers to the response.

``` java
@Get("/list") // <8>
public List<Genre> list(@Valid Pageable pageable) { // <9>
    return genreService.list(pageable);
}
```

8. Maps a `GET` request to `/genres/list`, which returns a list of genres.

9. You can bind `Pageable` as a controller method argument. (For more information, see [Pageable configuration](https://micronaut-projects.github.io/micronaut-data/latest/guide/configurationreference.html#io.micronaut.data.runtime.config.DataConfiguration.PageableConfiguration).) For example, you can configure the default page size with the configuration property `micronaut.data.pageable.default-page-size`.

``` java
@Post // <10>
public HttpResponse<Genre> save(@Body("name") @NotBlank String name) {
    Genre genre = genreService.save(name);

    return HttpResponse
            .created(genre)
            .headers(headers -> headers.location(URI.create("/genres/" + genre.getId())));
}
```

10. Maps a `POST` request to `/genres`, which attempts to save a genre.

``` java
@Delete("/{id}") // <11>
@Status(NO_CONTENT)
public void delete(Long id) {
    genreService.delete(id);
}
```

11. Maps a `DELETE` request to `/genres/{id}`, which attempts to remove a genre. This illustrates the use of a URL path variable `id`.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
