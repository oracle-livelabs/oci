# Review the Sample Application Source Code

## Introduction

This lab reviews the sample Micronaut application code used in the workshop. The application source code and build scripts are available for review in VS Code.

The application is a simple "RESTful" microservice that manages the inventory of items.

You'll see how easy it is to configure a Micronaut application to send traces to OCI APM Tracing with the GDK.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Review the sample application source code

## Task 1: Tracing Annotations

The Micronaut framework uses the [Micronaut Tracing](https://micronaut-projects.github.io/micronaut-tracing/latest/guide/index.html) and [OpenTelemetry](https://opentelemetry.io/) to generate and export tracing data.

The [`io.micronaut.tracing.annotation`](https://micronaut-projects.github.io/micronaut-tracing/latest/api/io/micronaut/tracing/annotation/package-summary.html) package provides the following annotations that can be declared on methods to create new spans or continue existing spans:

- [@NewSpan](https://micronaut-projects.github.io/micronaut-tracing/latest/api/io/micronaut/tracing/annotation/NewSpan.html): Used on methods to create a new span; defaults to the method name, but a unique name may be assigned instead.

- [@ContinueSpan](https://micronaut-projects.github.io/micronaut-tracing/latest/api/io/micronaut/tracing/annotation/ContinueSpan.html): Used on methods to continue an existing span; primarily used in conjunction with `@SpanTag` (below).

- [@SpanTag](https://micronaut-projects.github.io/micronaut-tracing/latest/api/io/micronaut/tracing/annotation/SpanTag.html): Used on method parameters to assign a value to a span; defaults to the parameter name, but you can assign a unique name instead. To use the `@SpanTag` on a method argument, the method must be annotated with either `@NewSpan` or `@ContinueSpan`.

## Task 2: Review the Application Dependencies

Your build configuration files contain the `io.micronaut.tracing` dependency which means all HTTP server methods (those annotated with `@Get`, `@Post`, and so on) create spans automatically.

_lib/pom.xml_

	<dependency>
		<groupId>io.micronaut.tracing</groupId>
		<artifactId>micronaut-tracing-opentelemetry</artifactId>
		<scope>compile</scope>
	</dependency>

	<dependency>
		<groupId>io.micronaut.tracing</groupId>
		<artifactId>micronaut-tracing-opentelemetry-http</artifactId>
		<scope>compile</scope>
	</dependency>

Micronaut provides a Zipkin exporter that uses Micronaut’s HTTP client instead of OKHttp client. This reduces the dependency graph and makes your native executable smaller.

_oci/pom.xml_

	<dependency>
		<groupId>io.micronaut.tracing</groupId>
		<artifactId>micronaut-tracing-opentelemetry-zipkin-exporter</artifactId>
		<scope>compile</scope>
	</dependency>

## Task 3: Review the Inventory Service

The `InventoryService` class uses a WarehouseClient bean to interact with an external Warehouse service to fetch the product counts and place orders. This class demonstrates how to create and use spans using `io.micronaut.tracing.annotation` and `OpenTelemetry`.

_lib/src/main/java/com/example/InventoryService.java_

``` java
InventoryService(Tracer tracer, WarehouseClient warehouse) { // <1>
   this.tracer = tracer;
   this.warehouse = warehouse;

   inventory.put("laptop", 4);
   inventory.put("desktop", 2);
   inventory.put("monitor", 11);
}
```

1. To do tracing you’ll need to acquire an `OpenTelemetry Tracer`. Inject an `OpenTelemetry Tracer` bean using Micronaut Constructor Injection.

``` java
@NewSpan("stock-counts") // <2>
public Map<String, Integer> getStockCounts(@SpanTag("inventory.item") String item) { // <3>
   Map<String, Integer> counts = new HashMap<>();
   if (inventory.containsKey(item)) {
      int count = inventory.get(item);
      counts.put("store", count);

      if (count < 10) {
            counts.put("warehouse", inWarehouse(storeName, item));
      }
   }

   return counts;
}
```

2. Create a new `io.micronaut.tracing.annotation` span called “stock-counts”.

3. Add a `io.micronaut.tracing.annotation` tag called “inventory.item” that will contain the value contained in the parameter `item`. Span tags and attributes are key-value pairs used to provide additional context on a span about the specific operation it tracks, such as results or operation properties.

``` java
private int inWarehouse(String store, String item) {
   Span.current().setAttribute("inventory.store-name", store); // <4>

   return warehouse.getItemCount(store, getUPC(item));
}
```

4. Alternate way of adding a key called "inventory.store-name". Get the current OpenTelemetry span and set the value of its attribute named “inventory.store-name” to the `store` parameter.

``` java
private void orderFromWarehouse(String item, int count) {
   Span span = tracer.spanBuilder("warehouse-order") // <5>
            .setAttribute("item", item)
            .setAttribute("count", count)
            .startSpan();

   warehouse.order(Map.of(
            "store", storeName,
            "product", item,
            "amount", count,
            "upc", getUPC(item)));

   span.end(); // <6>
}
```

5. Alternate way of creating a new span called "warehouse-order". Create an OpenTelemetry span named “warehouse-order”, set its attributes and start the span.

6. End the span started in 5.

## Task 4: Review the Store Controller

The `StoreController` class also demonstrates the use of Micronaut Tracing annotations (`io.micronaut.tracing.annotation`).

_lib/src/main/java/com/example/StoreController.java_

``` java
@Post("/order")
@Status(CREATED)
@NewSpan("store.order") // <1>
void order(@SpanTag("order.item") String item, @SpanTag int count) { // <2>
   inventory.order(item, count);
}
```

1. Create a new span called "store.order". 

2. Add tags for the method parameters. Name the first parameter “order.item”, and use the default name for the second parameter. 

``` java
@Get("/inventory") // <3>
List<Map<String, Object>> getInventory() {
   return inventory.getProductNames().stream()
            .map(this::getInventory)
            .collect(Collectors.toList());
}
```

3. A span is created automatically if your build configuration file contains the `io.micronaut.tracing` dependency.

``` java
@Get("/inventory/{item}")
@ContinueSpan // <4>
Map<String, Object> getInventory(@SpanTag("item") String item) { // <5>
   Map<String, Object> counts = new HashMap<>(inventory.getStockCounts(item));
   if (counts.isEmpty()) {
      counts.put("note", "Not available at store");
   }

   counts.put("item", item);

   return counts;
}
```

4. Used to continue an existing span. Required for `@SpanTag` (see 5).

5. Add a tag for the method parameter. Tag is only added to the span if `micronaut-tracing-opentelemetry-http` is included as a dependency; otherwise ignored.

## Task 5: Review the Warehouse Client

The `WarehouseClient` class also demonstrates how to use Micronaut Tracing annotations.

_lib/src/main/java/com/example/WarehouseClient.java_

``` java
...
import io.micronaut.tracing.annotation.ContinueSpan;
import io.micronaut.tracing.annotation.NewSpan;
import io.micronaut.tracing.annotation.SpanTag;
...

@Client("/warehouse") // <1>
public interface WarehouseClient {

    @Post("/order")
    @NewSpan
    void order(@SpanTag("warehouse.order") Map<String, ?> json);

    @Get("/count")
    @ContinueSpan
    int getItemCount(@QueryValue String store,
                     @SpanTag @QueryValue int upc);
}
```

1. Some external service without tracing.

## Task 6: Review the Warehouse Controller

The `WarehouseController` class is a dummy class that represents an external service that will be called by `WarehouseClient`.

_lib/src/main/java/com/example/WarehouseController.java_

``` java
@ExecuteOn(TaskExecutors.IO) // <1>
@Controller("/warehouse") // <2>
class WarehouseController {

    @Get("/count") // <3>
    HttpResponse<?> getItemCount() {
        return HttpResponse.ok(new Random().nextInt(11));
    }

    @Post("/order") // <4>
    HttpResponse<?> order() {
        try {
            //To simulate an external process taking time
            Thread.sleep(500);
        } catch (InterruptedException ignored) {
        }

        return HttpResponse.accepted();
    }
}
```

1. It is critical that any blocking I/O operations (such as fetching the data from the database) are offloaded to a separate thread pool that does not block the Event loop.
2. The class is defined as a controller with the `@Controller` annotation mapped to the path `/warehouse`.
3. The `@Get` annotation maps the `getItemCount()` method to an HTTP GET request on `/warehouse/count`.
4. The `@Post` annotation maps the `order()` method to an HTTP POST request on `/warehouse/order`.

In the next section, you'll configure the application to send traces to this APM Domain.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
