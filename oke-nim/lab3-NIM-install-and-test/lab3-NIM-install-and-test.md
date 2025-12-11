# Deploy the LLM NIM and testing inferences

## Deploy the Llama3 LLM NIM
NIM are intended to be run on NVIDIA GPUs, with the type and number of
GPUs depending on the model. With the GPU Operator installed you can use
Helm to install your LLM.

Create a deployment YAML that references the model-specific container.
For example here, for **llama-3.1-nemotron-nano-8b-v1**.


````shell
<copy>
cat <<ENDEND > oke-nim-llama.yaml 
image:
  repository: nvcr.io/nim/nvidia/llama-3.1-nemotron-nano-8b-v1
  tag: 1.8.4
  pullSecrets:
    - name: ngc-secret

model:
  name: nvidia/llama-3.1-nemotron-nano-8b-v1
  ngcAPISecret: ngc-api-secret

service:
  type: LoadBalancer
ENDEND
</copy>
````

Download the **nim-llm** helm chart from the NVIDIA NGC repository.


````shell
<copy>
helm fetch https://helm.ngc.nvidia.com/nim/charts/nim-llm-1.3.0.tgz
--username='$oauthtoken' --password=$NGC\_API\_KEY
</copy>
````


Run the install.


````shell
<copy>
helm install my-nim nim-llm-1.3.0.tgz -f oke-nim-llama.yaml -n nim
</copy>
````

![Helm install](./images/image16.png)



Check the progress of the install.

````shell
<copy>
kubectl get pods -n nim
</copy>
````

![Check Progress](./images/image17.png)


When you see the pod status as **Running**, this mean the installation
was successful.

Check what services are running.

````shell
<copy>
kubectl get svc -n nim
</copy>
````


Look for the pod name **my-nim-nim-llm** and take note of
the **EXTERNAL-IP**.

![Nim information](./images/image18.png)


## Testing the Inference API

Once the NIM is live, send a test prompt via curl or Postman. Replace
the &lt;EXTERNAL\_IP&gt;: with the **EXTERNAL-IP** from the
**my-nim-nim-llm service**.

````shell
<copy>
curl -X POST http://<EXTERNAL_IP>:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "What should I do for a 4 day vacation in Greece?”}
    ],
    "model": "meta/llama3-8b-instruct",
    "max_tokens": 200
  }'
</copy>
````


You should see a response like the one below.

````shell
<copy>
{ 
 "id": "cmpl-abc123",
  "object": "chat.completion",
  "created": 1752132000,
  "model": "meta/llama3-8b-instruct",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Day 1: Athens—Acropolis, Acropolis Museum, Plaka. Day 2: Athens—Agora, food tour, Lycabettus at sunset. Day 3: Ferry to Hydra—car‑free island, coastal walk, swim, seafood taverna. Day 4: Hydra morning hike, ferry back and fly out. Tips: buy combo ticket for sites, prebook ferry, carry cash for small tavernas. Budget: €120–€180/day mid‑range; ferries €35–€60 each way."
      }
    }
  ],
  "usage": {
    "prompt_tokens": 55,
    "completion_tokens": 140,
    "total_tokens": 195
  }
}
</copy>
````

Send another prompt "What is oracle Autonomous Database?".

````shell
<copy>
curl -X POST http://<EXTERNAL_IP>:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "What is oracle Autonomous Database?"}
    ],
    "model": "meta/llama3-8b-instruct",
    "max_tokens": 150
  }'
</copy>
````

LLM’s response.

````shell
<copy>
{
  "id": "cmpl-xyz987",
  "object": "chat.completion",
  "created": 1752132500,
  "model": "meta/llama3-8b-instruct",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Oracle Autonomous Database is a cloud-based database service that uses machine learning to automate key management tasks such as provisioning, tuning, backups, and patching. It is designed to run without human intervention, reducing administrative overhead while improving performance, reliability, and security. Available in configurations for transaction processing, data warehousing, or mixed workloads, it scales automatically and includes built-in security and analytics capabilities."
      }
    }
  ],
  "usage": {
    "prompt_tokens": 19,
    "completion_tokens": 102,
    "total_tokens": 150
  }
}
</copy>
````

As part of the prompt settings, you can tweak the system prompt, model,
and the max\_tokens. Let’s try updating the system prompt that the size
of the max\_tokens.

````shell
<copy>
curl -X POST http://<EXTERNAL_IP>:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "system", "content": "Act as a Software Engineer and respond to the questions towards a new solution development ."},
      {"role": "user", "content": "What is oracle Autonomous Database?"}
    ],
    "model": "meta/llama3-8b-instruct",
    "max_tokens": 2048
  }'
</copy>
````


LLM’s response.

````shell
<copy>
{
  "id": "cmpl-abc2000",
  "object": "chat.completion",
  "created": 1752133000,
  "model": "meta/llama3-8b-instruct",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Oracle Autonomous Database (ADB) is a fully managed, self-driving cloud database service offered on Oracle Cloud Infrastructure (OCI). It leverages advanced machine learning to automate the full lifecycle of a database — including provisioning, configuring, securing, tuning, scaling, patching, and repairing — without human intervention. This eliminates much of the manual database administration work while improving reliability, security, and performance.\n\n**1. Architecture**\nThe architecture is built on Oracle Database technology running in the OCI environment, enhanced with AI/ML-driven automation. Key layers include:\n- **Compute Layer**: Dedicated or shared infrastructure, optimized for database workloads.\n- **Storage Layer**: Exadata storage servers with high-bandwidth, low-latency access to persistent data.\n- **Automation Layer**: ML models monitor workloads, optimize indexes, allocate CPU/memory dynamically, and detect anomalies.\n- **Security Layer**: Always-on encryption (TDE), automatic security patching, access controls, and audit logging.\n\n**2. Deployment Options**\n- **Autonomous Transaction Processing (ATP)**: Optimized for OLTP workloads, mobile/web apps, ERP, and CRM systems.\n- **Autonomous Data Warehouse (ADW)**: Optimized for analytics, BI, data lakes, and reporting.\n- **Autonomous JSON Database**: For applications requiring a JSON-native store with SQL integration.\n- **Autonomous Database on Dedicated Exadata Infrastructure**: For isolation, compliance, and predictable performance.\n\n**3. Key Features**\n- **Self-Driving**: Automates provisioning, scaling, backups, tuning, and patching.\n- **Self-Securing**: Automatically applies security updates, encrypts all data, and protects from malicious attacks.\n- **Self-Repairing**: Detects and recovers from failures automatically with minimal downtime (99.995% SLA).\n- **Elastic Scaling**: CPU and storage scale independently without downtime.\n- **Data Integration**: Native connectors for Oracle Analytics Cloud, GoldenGate, Data Integration, and 3rd-party BI tools.\n- **Multi-Model Support**: Relational, JSON, spatial, graph, blockchain tables.\n\n**4. Benefits**\n- **Reduced Operational Cost**: Eliminates most DBA repetitive tasks.\n- **Higher Reliability**: Machine learning reduces misconfiguration risk.\n- **Performance Optimization**: Automatic indexing and query plan adjustments.\n- **Security Compliance**: Meets standards like ISO 27001, SOC, PCI-DSS, HIPAA.\n\n**5. Use Cases**\n- Real-time analytics dashboards.\n- High-transaction e-commerce platforms.\n- IoT sensor data ingestion and analysis.\n- Financial fraud detection.\n- Government and regulated industries requiring high compliance.\n\n**6. Technical Specs (OCI ADB)**\n- Storage: Up to petabytes with Exadata scale-out storage.\n- Memory: Up to hundreds of GB per instance.\n- CPUs: Elastic OCPU model (per second billing).\n- Network: RDMA over Converged Ethernet (RoCE) for ultra-low latency.\n\nIn summary, Oracle Autonomous Database combines Oracle’s database expertise with cloud-scale automation to deliver a service that is faster to deploy, easier to maintain, and more secure than traditional database models, freeing up teams to focus on innovation instead of administration."
      }
    }
  ],
  "usage": {
    "prompt_tokens": 45,
    "completion_tokens": 1020,
    "total_tokens": 1065
  }
}
</copy>
````



## Final Thoughts

Running NIM on OKE brings together the best of NVIDIA and Oracle Cloud:
performance-optimized model microservices deployed on enterprise-grade,
scalable infrastructure.

Whether you're deploying a GenAI chatbot, a document Q&A system, or
powering a RAG pipeline, this architecture gives you:

- Full control over models and infrastructure

- The flexibility of Kubernetes with the speed of NVIDIA inference

- Seamless integration into your broader OCI AI and data ecosystem

Ready to start? Visit
[<u>cloud.oracle.com</u>](https://cloud.oracle.com/), provision your OKE
cluster, and try deploying your first NIM today.



## Acknowledgements
- **Created By** -  Alejandro Casas OCI Product Marketing; Julien Lehmann, OCI Product Marketing
- **Contributors** - Dimitri Maltezakis Vathypetrou, NVIDIA Developer Relations; Anurag Kuppala, NVIDIA AI Solution Architect
- **Last Updated By/Date** - Dec 12th, Alejandro Casas, Julien Lehmann
