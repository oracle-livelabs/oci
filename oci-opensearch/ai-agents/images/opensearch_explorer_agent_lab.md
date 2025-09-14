# OCI Live Lab: OpenSearch 3.0 AI Agents & Agent Tools — Explorer Agent for Sample Data (Non‑Vectorized)

**Duration:** ~20 minutes  
**Audience:** DevOps, SREs, Data/ML Engineers, Architects  
**Level:** Intermediate  
**Services:** OCI OpenSearch Service v3.0  

---

## Introduction: Why Agents and Agent Tools in OpenSearch?

Agentic systems shift from static dashboards to **goal-driven automation**. In OpenSearch 3.0, **AI Agents** (MCP-driven) coordinate **Agent Tools**—reusable, declarative capabilities like keyword search, aggregations, schema introspection, and RAG. Together they enable:
- Conversational analytics across logs, metrics, and business data  
- Automated triage & **RCA** by chaining search → summarize → recommend actions  
- **Graceful degradation** with fallbacks (e.g., BM25 search if vectors are absent)  
- A single interface to heterogeneous data (observability, commerce, flights)  

This lab starts with **non‑vectorized** OpenSearch sample datasets (eCommerce and Flights). You’ll build an **Explorer Agent** that uses **BM25/keyword tools**, **aggregations**, and **schema utilities**—then (optionally) add a vector/RAG tool later.

---

## What You Already Have (Assumptions)

- An **OpenSearch 3.0** domain up and accessible
- Sample datasets ingested from Dashboards:
  - `opensearch_dashboards_sample_data_ecommerce`
  - `opensearch_dashboards_sample_data_flights`
- A deployed **LLM model** (for summarization/explanations)
- (Optional) A deployed **embedding model** and a vectorized KB (e.g., `kb-errors`)

> This lab **does not** cover installation. Focus is on **Agent Tools** and **AI Agents**.

---

## Learning Objectives

1. Register **utility tools** (list indices, describe mappings)  
2. Register **BM25 search tools** for eCommerce & Flights (non‑vector)  
3. Register **aggregation tools** for quick insights (top-k, trends)  
4. Create an **Explorer Agent** that orchestrates these tools with fallbacks  
5. Execute example prompts that traverse both datasets  
6. (Optional) Extend with a **RAG** tool over a vectorized KB

---

## 1) Register Utility Tools (Index Discovery & Introspection)

### 1.1 List Indexes Tool
Helps the agent discover available data sources.

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "ListIndexTool",
      "name": "ListIndexes",
      "description": "List all indices available in this cluster",
      "parameters": {}
    }
  ]
}
```

### 1.2 Describe Index (Mappings) Tool
Lets the agent learn field names/types for query planning.

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "DescribeIndexTool",
      "name": "DescribeIndex",
      "description": "Get mappings and settings for a given index",
      "parameters": {
        "index": "<dynamic-from-user>"
      }
    }
  ]
}
```

> **Tip:** Many agent failures are simply schema mismatches. This tool lets the agent inspect fields (e.g., `category`, `customer_full_name`, `Carrier`, `DestCityName`, `timestamp`), then form valid queries.

---

## 2) Register BM25/Keyword Search Tools (Non‑Vector Retrieval)

We’ll create **two** dedicated search tools—one for each sample dataset. These use full‑text/BM25 and keyword filters; no vectors required.

### 2.1 eCommerce BM25 Search Tool
Index: `opensearch_dashboards_sample_data_ecommerce`

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "BM25DBTool",
      "name": "EcomSearch",
      "description": "Keyword/BM25 search over the eCommerce sample data",
      "parameters": {
        "index": "opensearch_dashboards_sample_data_ecommerce",
        "default_query_fields": ["customer_full_name^2", "category", "products.product_name", "products.sku", "email", "geoip.city_name", "manufacturer", "tags", "type", "user"],
        "size": 25,
        "timeout": "5s"
      }
    }
  ]
}
```

**Example queries this tool can handle:**
- “orders with `Men's Clothing` in **July 2022**”  
- “find purchases by `Eddie Underwood`”

### 2.2 Flights BM25 Search Tool
Index: `opensearch_dashboards_sample_data_flights`

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "BM25DBTool",
      "name": "FlightsSearch",
      "description": "Keyword/BM25 search over the Flights sample data",
      "parameters": {
        "index": "opensearch_dashboards_sample_data_flights",
        "default_query_fields": ["Carrier", "FlightNum", "DestCountry", "DestCityName", "OriginCityName", "FlightDelayType", "AvgTicketPrice", "dayOfWeek"],
        "size": 50,
        "timeout": "5s"
      }
    }
  ]
}
```

**Example queries this tool can handle:**
- “delayed flights into **Los Angeles** last week”  
- “average ticket price for **Carrier=OpenAI Air**”

> **Note:** If your environment uses different field names (e.g., lowercase, snake_case), first run `DescribeIndex` to confirm, then adjust `default_query_fields` accordingly.

---

## 3) Register Aggregation Tools (Top‑K & Trends)

Let the agent compute metrics and summaries without exporting data.

### 3.1 eCommerce Aggregations
Top categories by revenue; average order value; orders over time.

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "AggregationTool",
      "name": "EcomAggs",
      "description": "Run common aggregations on eCommerce data",
      "parameters": {
        "index": "opensearch_dashboards_sample_data_ecommerce",
        "presets": [
          {
            "name": "top_categories_by_revenue",
            "agg": {
              "sum_revenue": { "sum": { "field": "taxless_total_price" } },
              "by_category": {
                "terms": { "field": "category.keyword", "size": 10 },
                "aggs": { "cat_revenue": { "sum": { "field": "taxless_total_price" } } }
              }
            }
          },
          {
            "name": "avg_order_value",
            "agg": { "avg_order_value": { "avg": { "field": "taxful_total_price" } } }
          },
          {
            "name": "orders_per_day",
            "agg": {
              "per_day": {
                "date_histogram": { "field": "order_date", "fixed_interval": "1d" },
                "aggs": { "sum_revenue": { "sum": { "field": "taxless_total_price" } } }
              }
            }
          }
        ]
      }
    }
  ]
}
```

### 3.2 Flights Aggregations
Delays, average ticket prices, top destinations.

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "AggregationTool",
      "name": "FlightsAggs",
      "description": "Run common aggregations on Flights data",
      "parameters": {
        "index": "opensearch_dashboards_sample_data_flights",
        "presets": [
          {
            "name": "avg_ticket_price_by_carrier",
            "agg": {
              "by_carrier": {
                "terms": { "field": "Carrier.keyword", "size": 10 },
                "aggs": { "avg_price": { "avg": { "field": "AvgTicketPrice" } } }
              }
            }
          },
          {
            "name": "delays_by_dest_city",
            "agg": {
              "by_city": {
                "terms": { "field": "DestCityName.keyword", "size": 10 },
                "aggs": { "avg_delay": { "avg": { "field": "FlightDelayMin" } } }
              }
            }
          },
          {
            "name": "flights_over_time",
            "agg": {
              "per_day": {
                "date_histogram": { "field": "timestamp", "fixed_interval": "1d" }
              }
            }
          }
        ]
      }
    }
  ]
}
```

> **Flexibility:** The `presets` pattern makes it easy for the agent to select by name (e.g., `avg_ticket_price_by_carrier`) and optionally apply filters (time windows, carriers, cities).

---

## 4) (Optional) Register a RAG Tool for a Vectorized KB

If you also maintain a vectorized troubleshooting KB (e.g., `kb-errors` with `embedding`), add one **Hybrid** or **Vector** retriever + a **RAG** tool for grounded answers.

```json
POST /_plugins/_ml/mcp/tools/_register
{
  "tools": [
    {
      "type": "HybridDBTool",
      "name": "KBHybridRetriever",
      "description": "Hybrid retriever over kb-errors",
      "parameters": {
        "model_id": "<embedding-model-id>",
        "index": "kb-errors",
        "embedding_field": "embedding",
        "source_field": "text",
        "k": 5,
        "alpha": 0.5
      }
    },
    {
      "type": "RAGTool",
      "name": "KBRAG",
      "description": "RAG grounded on kb-errors",
      "parameters": {
        "retriever": "KBHybridRetriever",
        "llm_model": "<llm-model-id>",
        "context_size": 3
      }
    }
  ]
}
```

---

## 5) Create the **Explorer Agent**

This agent can **discover indices**, **inspect schema**, run **BM25 search** and **aggregations** across eCommerce and Flights, and (optionally) escalate to **RAG**.

```json
POST /_plugins/_ml/mcp/agents/_register
{
  "name": "ExplorerAgent",
  "description": "Explores eCommerce and Flights sample indices using BM25 search, aggregations, and schema tools. Falls back gracefully.",
  "tools": [
    "ListIndexes",
    "DescribeIndex",
    "EcomSearch",
    "FlightsSearch",
    "EcomAggs",
    "FlightsAggs",
    "KBRAG"
  ],
  "fallback": {
    "primary": "EcomSearch",
    "secondary": "FlightsSearch",
    "tertiary": "DescribeIndex"
  },
  "planning": {
    "instructions": "Prefer DescribeIndex before first-time queries on a given index. Use *Aggs presets for metrics; use BM25 tools for record-level detail. Summarize with the LLM when useful."
  }
}
```

> If you didn’t register `KBRAG`, you can omit it from `tools`.

---

## 6) Run Example Tasks

### 6.1 Discover data sources
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "List available indices and identify the sample eCommerce and Flights datasets."
}
```

Expected plan: call **ListIndexes** → shortlist `opensearch_dashboards_sample_data_ecommerce`, `opensearch_dashboards_sample_data_flights`.

---

### 6.2 Inspect schema before querying
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "Show me the important fields to query in the eCommerce sample index."
}
```

Expected plan: **DescribeIndex** on eCommerce; agent outputs search-friendly fields (e.g., `order_date`, `customer_full_name`, `category`, `taxful_total_price`).

---

### 6.3 Business insight (eCommerce): top revenue categories (last 30d)
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "Using the eCommerce dataset, compute the top 5 categories by revenue in the last 30 days and summarize findings."
}
```

Expected plan: **EcomAggs**(`top_categories_by_revenue`) with a date filter → LLM summary.

---

### 6.4 Flights ops: delays into Los Angeles (7d) + average ticket price by carrier
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "For flights arriving to Los Angeles in the last 7 days, summarize average delay by destination city and list average ticket price by carrier."
}
```

Expected plan: **FlightsAggs**(`delays_by_dest_city`) with city/time filters → **FlightsAggs**(`avg_ticket_price_by_carrier`) → LLM summary.

---

### 6.5 Drill‑down (eCommerce): find relevant orders
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "Find 10 example orders that include Men's Clothing and summarize typical basket composition."
}
```

Expected plan: **EcomSearch** with query on `category:'Men\'s Clothing'` → LLM summary of product mixes.

---

### 6.6 Mixed exploration: compare two carriers on price & delays
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "Compare average ticket price and average delay between Carrier A and Carrier B in the last month and provide a short recommendation."
}
```

Expected plan: **FlightsAggs** (avg price by carrier) + (delays by city or per carrier, depending on mapping) → LLM summarization & recommendation.

---

### 6.7 (Optional) Troubleshooting with KB RAG
```json
POST /_plugins/_ml/mcp/agents/ExplorerAgent/_execute
{
  "input": "We see gateway timeouts in payments during checkout. What RCA steps should we try based on the KB?"
}
```

Expected plan: **KBRAG** → grounded recommendations from `kb-errors`.

---

## 7) Verify & Maintain

List tools:
```json
GET /_plugins/_ml/mcp/tools/_list
```

List agents:
```json
GET /_plugins/_ml/mcp/agents/_list
```

Update agent (e.g., to add a new preset/tool):
```json
POST /_plugins/_ml/mcp/agents/_update
{
  "name": "ExplorerAgent",
  "tools": ["ListIndexes","DescribeIndex","EcomSearch","FlightsSearch","EcomAggs","FlightsAggs","KBRAG","<NewToolName>"]
}
```

---

## 8) Troubleshooting Notes (Quick)

- **Schema mismatch / 400 errors:** Run `DescribeIndex` first; confirm field names (`.keyword` for terms aggs).  
- **GSON `Expected BEGIN_ARRAY but was STRING`:** Check that your POST body is valid JSON and `tools` is an array.  
- **No results:** Loosen query, remove filters, raise `size`, or use different fields in `default_query_fields`.  
- **Permission issues (403/404):** Ensure your principal has ML & index read privileges; confirm domain is v3.0.  
- **Slow queries:** Reduce `size`, apply time filters, use targeted fields, or run aggregations instead of raw scans.

---

## Wrap‑Up

You created an **Explorer Agent** that:
- Discovers and understands indices (List/Describe)  
- Runs **BM25** searches over **non‑vectorized** eCommerce & Flights data  
- Computes business and operational insights via **aggregations**  
- (Optionally) escalates to **RAG** for grounded recommendations

**Next:** In the dedicated MCP Server lab, you’ll call these agents from code (e.g., LangChain), add guardrails, and wire actions back into incident workflows.
