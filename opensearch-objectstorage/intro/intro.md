
# Introduction

Estimated time: 120 minutes

### Goal: Search Documents uploaded to Object Storage in a Google like search engine

![streaming-architecture](images/opensearch-intro.png)

Using LowCode tools, we will develop a program to search Documents uploaded to Object Storage in a Google like search engine.

Documents like: 
- Word, Excel, PDF, ... , 
- Images with text. Using AI and Text Recognition.
- Images without text. Using AI Vision and Labelling
- Custom document: Images of Belgian ID cards

### Architecture

![streaming-architecture](images/opensearch-architecture.png)

### How

It works like this:
- A document is uploaded to the Object Storage.
- An event is raised and queue in Streaming (Kafka)
- The events are processed in Oracle Integration Cloud 
- Based on the file type, it will process it in the right way
- Then the result is uploaded to OpenSearch

Then, a end-user can look for these documents in Google like search page designed with Visual Builder.

The internal processing is designed with a LowCode tool.

![Integration](images/opensearch-oic.png)

### Objectives

- Create the Components
    - Compartment, Object Storage Bucket, Stream, Event, OpenSearch, ...
- Create an OCI Function to parse the documents
- Integrate to the Components together
- Create a Google like user interface

## Acknowledgements 

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 27 Sep 2022