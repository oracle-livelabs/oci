# Monitor the Log

## Introduction

Observability는 로그와 매트릭, 트레이스(추적)를 조합하여 현재 시스템의 상태를 이해하고 설명하는 데 도움을 줍니다. 시스템에 대한 가시성을 높이는데 도움을 줍니다.

예상 시간: Task 1 기준 - 30 분

### 목표

* OCI Logging Analytics로 OKE 로그 모니터링 하는 법 익히기
* OSS ElasticSearch/Kibana로 OKE 로그 모니터링 하는 법 익히기 (선택사항)
* OCI Logging 서비스를 사용하여 OKE 로그 모니터링 하는 법 익히기 (선택사항)

### 전제 조건

* **Lab 4: Deploy the MuShop Application** 완료하고 현재 앱이 실행 중일 것


### OKE 로그

쿠버네티스에서 발생하는 로그는 크게 두 가지로 볼 수 있습니다. 쿠버네티스 프로세스에서 발생하는 로그와 컨테이너 애플리케이션에서 발생하는 로그입니다.

- **OKE(Container Engine for Kubernetes) 쿠버네티스 프로세스 로그**

    * Control Plane 영역에 있는 로그로, 2023년 9월부터 OCI 서비스 로그를 OKE에 대해서도 지원하기 시작하여, OKE 쿠버네티스 프로세스(kube-scheduler, kube-controller-manager, cloud-controller-manager, and kube-apiserver)의 로그를 *OCI Logging* 서비스의 *Service Log* 형식으로 OCI Logging 서비스에서 수집할 수 있습니다.
    * 타 로그모니터링 시스템에 전달이 필요한 경우, OCI Logging 수집된 로그를 Service Connector를 통해 타 시스템으로 전달합니다.

- **OKE 상의 컨테이너 애플리케이션 로그**: 컨테이너 애플리케이션의 로그를 수집을 위해서는 일반적으로 Agent를 설치하여 로그를 수집하며, 사용을 원하는 각 로그 모니터링 시스템에서 요구하는 방식으로 설치 구성합니다.

    * OCI Logging 서비스: Custom Log 형식을 지원하여, Worker Node에 Agent 설치하고, OCI Logging 서비스에서 수집하는 기능을 제공합니다.
    * OCI Logging Analytics: 전문 로그 분석 서비스로 로그 수집, 분석하능 기능을 제공합니다.
    * ElasticSearch/Kibana: 컨테이너 로그 모니터링으로 많이 사용하는 솔루션으로, Fluent Bit 또는 FluentD를 통해 로그 수집하고 모니터링합니다. 
    * OCI OpenSearch 서비스: ElasticSearch의 라이선스 문제로 분기된 OpenSearch를 OCI 제공하는 서비스입니다. ElasticSearch와 동일한 방식으로 Fluent Bit 또는 FluentD를 통해 로그 수집하고 모니터링합니다. 

## Task 1: OCI Logging Analytics

### OCI Kubernetes Monitoring Solution

OCI Logging Analytics에서 지원하는 방법에 맞춰 컨테이너 로그도 입수(ingest) 할 수 있지만 관련 구성 및 설정이 필요합니다. OCI Kubernetes Monitoring Solution는 OCI Logging Analytics, OCI Monitoring, OCI Management Agent 와 FluentD를 통해 Kubernetes를 모니터링을 한 번의 설치로 자동화하는 솔루션으로 오픈소스 형태로 제공하고 있습니다. 

- [GitHub - OCI Kubernetes Monitoring Solution](https://github.com/oracle-quickstart/oci-kubernetes-monitoring)

[Monitor Kubernetes and OKE clusters with OCI Logging Analytics](https://docs.oracle.com/ko/solutions/kubernetes-oke-logging-analytics/index.html) 문서에서 아키텍처를 보면, 로그 수집을 위해 컴포넌트로 FluentD Collector와 Logging Analytics FluentD Plugin이 설치되어 쿠버네티스 상의 로그를 수집합니다.

![OCI Kubernetes Monitoring Solution](images/k8s-oke-monitoring.png)

### OCI Kubernetes Monitoring Solution 설치

OCI 마켓플레이스를 통해 설치하거나, GitHub 리파지토리 소스를 통해 Resource Manager, Terraform, Helm 등으로 설치할 수 있습니다. 

*설치전에 대상 Region에 OCI Logging Analytics가 활성화되어 있어야 합니다. 내비게이션 메뉴에서 **Observability & Management** > **Logging Analytics** 화면으로 이동하여, 활성화되었는지 확인합니다. 활성화되지 않은 경우 먼저 활성화합니다.*

1. [GitHub - OCI Kubernetes Monitoring Solution](https://github.com/oracle-quickstart/oci-kubernetes-monitoring) 으로 이동합니다.

2. GitHub Repository 아래 버튼을 클릭하여 최신 소스로 설치를 시작합니다.

    ![Deploy to Oracle Cloud](images/deploy-to-oracle-cloud.png)

3. 설치를 시작하면 Resource Manager의 Stack 생성화면으로 이동됩니다.

4. 작성일 기준으로 V3.2.0 버전을 사용하였습니다.

5. 설치 기본 정보를 입력합니다.

     - Create in compartment: Resource Manager Stack이 설치될 위치입니다.

     ![Create Stack](images/k8s-oke-monitoring-create-stack-1.png)

6. 변수값을 입력합니다.

     - OKE Cluster: OKE Cluster가 위치한 Compartment와 대상 클러스터를 선택합니다.
     - OCI Observability & Management Service Configuration: Logging Analytics 대쉬보드와 LogGroup의 위치하는 Compartment를 선택하고, 만들 Logging Analytics LogGroup을 이름을 입력합니다.
         * Enable Metric Server Installation: mushop-utilities에서 이미 metric-server를 OKE에 설치한 상태이므로 여기서는 *체크하지 않습니다.*
         * OCI Logging Analytics Log Group Name: MyOKELogGroup-*xx*
     - OCI IAM Policies and Dynamic Groups: 모니터링할 OKE 클러스터에 대한 접근을 위해 자동으로 Dynamic Group과 Policy가 만들어집니다. 자동설치가 싫거나, 권한이 없는 경우, 사전에 별도로 권한에 설정합니다.

     ![Create Stack](images/k8s-oke-monitoring-create-stack-2.png)

7. Next를 클릭합니다.

8. 결과를 리뷰하고, **Create**를 클릭하여, 설치 및 적용합니다.

9. 설치가 완료할 때 까지 기다립니다. 실패한 경우, Logs를 확인하여 문제를 해결하고 재시도합니다.

10. 아래 Dynamic Group 및 Policy이 만들어집니다. Log & Object Collection Pods가 있는 Worker Nodes들에 OCI Logging Analytics에 로그를 업로드할 권한을 부여하고 있습니다

     - Dynamic Group: oci-kubernetes-monitoring-xxx...

         ```shell
         Match any rules defined below
         
         # Rule 1
         ALL {instance.compartment.id = 'ocid1.compartment.oc1..aaaaa_____32sa'}
         
         # Rule 2
         ALL {resource.type='managementagent', resource.compartment.id='ocid1.compartment.oc1..aaaaa_____32sa'}
         ```

     - Policy: oci-kubernetes-monitoring-yyy...

         - OCI Logging Anaytics Comparment로 선택한 Compartment에 생성됨
    
         ```shell
         Allow dynamic-group oci-kubernetes-monitoring-xxx... to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment oci-hol
         Allow dynamic-group oci-kubernetes-monitoring-xxx... to use METRICS in compartment oci-hol WHERE target.metrics.namespace = 'mgmtagent_kubernetes_metrics'
         ```

11. 왼쪽 위 내비게이션 메뉴에서 **Observability & Management** > **Logging Analytics** > **Administration**으로 이동합니다.

12. Resources > Log Groups에 보면 설치시 생성된 LogGroup를 확인할 수 있습니다.

     ![Log Group](images/k8s-oke-monitoring-log-group.png)

13. Dashboard 메뉴를 클릭하면, Kubernetes 대쉬보드가 추가된 것을 확인할 수 있습니다.

     ![OKE Monitoring Dashboard](images/k8s-oke-monitoring-dashboards.png)

14. 대상으로 지정된 OKE 클러스터 설치된 자원을 확인합니다.

    - helm chart로 설치된 것을 확인할 수 있습니다.

      ```shell
      $ helm list -n default
      NAME                            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
      oci-kubernetes-monitoring       default         1               2023-10-16 08:55:30.03630867 +0000 UTC  deployed        oci-onm-3.0.2   3.0.0      
      ```

    - oci-onm 네임스페이스에 관련 Pod가 설치되었습니다.

      ```shell
      $ kubectl get pod -n oci-onm
      NAME                             READY   STATUS    RESTARTS   AGE
      oci-onm-logan-5959f8f699-jh4sn   1/1     Running   0          25m
      oci-onm-logan-5ksk2              1/1     Running   0          25m
      oci-onm-logan-c7cdb              1/1     Running   0          25m
      oci-onm-logan-sfgbk              1/1     Running   0          25m
      oci-onm-mgmt-agent-0             1/1     Running   0          25m
      ```
      

### Logging Analytics - 로그 모니터링

1. OCI 콘솔로 이동합니다.

2. 왼쪽 위 내비게이션 메뉴에서 **Observability & Management** > **Logging Analytics** > **Log Explorer**으로 이동합니다.

3. 필터에서 Log Group Compartment를 원하는 대상으로 선택합니다.

     ![Select Compartment](images/log-explorer-compartment.png)

4. 기본값으로 파이 차트 형식으로 보여 줍니다. 대상 클러스터에서 수집된 여러가지 소스에서 수집된 로그를 보여줍니다.

     ![Log Records](images/log-explorer-logrecords.png)

5. Worker Node 로그 및 사전 정의한 Kubernetes 로그이외에 애플리케이션 로그를 확인하기 위해 Kubernetes Container Generic Logs를 드릴 다운합니다.

     ![Log Drill Down](images/log-explorer-drilldown-k8s-logs.png)

6. 클라스터상의 수집된 컨테이너 로그들을 볼수 있습니다.

     ![Kubernetes Container Generic Logs](images/log-explorer-drilldown-k8s-generic-log.png)

7. 테스트를 위해 default 네임스페이스에 배포된 nginx 앱을 사용하겠습니다.

8. 필터링을 위해 *Search Fields*에 namespace로 검색합니다. 검색 결과 중에서 Namespace를 클릭하면 현재 검색된 로그들을 Namespace 단위로 카운트가 보입니다. 여기서 default namespace를 선택하고 적용합니다.

     ![image-20230907182822235](images/log-explorer-k8s-mushop-namespace.png =50%x*)

9. 검색 쿼리가 아래와 같이 변경되었습니다. 아래와 같이 직접 `and Namespace = mushop`를 입력하여도 됩니다.

     ```shell
     'Log Source' = 'Kubernetes Container Generic Logs' and Namespace = mushop | timestats count as logrecords by 'Log Source' | sort -logrecords
     ```

10. MuShop 앱 접속을 위해 Nginx Ingress Controller의 Load Balancer IP를 다시 확인합니다.

    ````
    <copy>    
    kubectl get svc -n mushop-utilities
    </copy>    
    ````

    결과 예시
    ````
    NAME                                              TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
    ...
    mushop-utils-ingress-nginx-controller             LoadBalancer   10.96.153.161   138.xxx.xxx.xxx   80:30636/TCP,443:30140/TCP   6d22h
    ...    
    ````

11. Mushop UI이 store-front Pod의 로그를 조회합니다. app: storefront 레이블을 기준으로 로그를 조회합니다.

    ````
    <copy>
    kubectl logs -lapp=storefront -f --tail=10
    </copy>
    ````

12. 확인된 IP를 통해 이전에 배포된 MuShop 앱을 접속해 봅니다. 테스트를 위해 URL에 테스트용 값을 추가합니다. 예, /?logging-analytics-logtest

    ![MuShop Logging Analytics Log](images/mushop-logging-analytics-log.png)

13. 발생한 POD 로그는 다음과 같습니다.

    ````
    $ kubectl logs -lapp=storefront -f --tail=10
    ...
    10.0.10.20 - - [16/Oct/2023:09:55:57 +0000] "GET /?logging-analytics-logtest HTTP/1.1" 200 4793 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36" "10.0.10.201, 10.0.10.28"
    ...
    ````

14. 결과가 많으면, 쿼리에 검색조건을 추가하여 다시 검색합니다.

     ![Log Query](images/mushop-logging-analytics-log-query.png)


### Logging Analytics - Dashboard

1. **Logging Analytics** > **Dashboard**로 이동합니다.

2. Kubernetes 대쉬보드가 추가된 것을 확인할 수 있습니다.

     ![Kubernetes Monitoring Dashboards](images/k8s-oke-monitoring-dashboards.png)

3. Kubernetes Cluster Summary를 클릭합니다.

     ![Cluster Summary Dashboard](images/k8s-oke-monitoring-dashboard-cluster-summary.png)

4. 배치된 위젯을 클릭하면, 해당 조건에 따라 로그를 쿼리하는 화면으로 이동합니다.

     ![Widget](images/k8s-oke-monitoring-dashboard-widget.png)
     ![Widget Query](images/k8s-oke-monitoring-dashboard-widget-query.png)
 
5. 다른 대쉬보드들로 비슷한 형식으로 제공합니다.


### Management Agent 및 메트릭 확인

OCI Kubernetes Monitoring Solution 버전이 올라가면서 OCI Kubernetes Monitoring Solution 설치시 OCI Management Agent도 함께 설치되어, OCI Monitoring상에 추가적으로 대상 쿠버네티스 클러스터에서 수집된 메트릭을 제공합니다.

1. 쿠버네티스 클러스스터에 설치된 자원을 다시 조회해 보면, mgmt-agent가 설치된 것을 알 수 있습니다.

     ```shell
     $ kubectl get pod -n oci-onm
     NAME                             READY   STATUS    RESTARTS   AGE
     oci-onm-logan-5959f8f699-jh4sn   1/1     Running   0          25m
     oci-onm-logan-5ksk2              1/1     Running   0          25m
     oci-onm-logan-c7cdb              1/1     Running   0          25m
     oci-onm-logan-sfgbk              1/1     Running   0          25m
     oci-onm-mgmt-agent-0             1/1     Running   0          25m
     ```

2. OCI 콘솔에 로그인합니다.

3. 왼쪽 위 내비게이션 메뉴에서  **Observability & Management** > **Management Agents** > **Agent**로 이동합니다.

4. Agent가 등록된 것을 확인합니다.

     ![Management Agent](images/management-agents.png)

5. 등록된 Agent를 클릭하면, 설치된 Agent의 현재 상태를 확인할 수 있습니다. 필요하면, 왼쪽 Time range에서 조회 시간을 1시간으로 변경합니다.

     ![Management Agent with Time Range](images/management-agents-k8s-agent.png)

6. 내비게이션 메뉴에서  **Observability & Management** > **Monitoring** > **Metrics Explorer**로 이동합니다.

7. 화면 아래 Query 부분으로 이동합니다. Management Agent 설치로 인해 Metric namespace에 `mgmtagent_kubernetes_metrics`가 추가되었습니다. 선택하면 Metric name에서 제공하는 메트릭들을 볼 수 있습니다.

     ![Kubernetes Metrics](images/management-agents-k8s-metrics.png)

7. OKE에 설치된 Agent Pod를 통해 수집된 메트릭을 OCI Monitoring상의 메트릭으로 제공하는 것을 확인했습니다. 이를 사용해 OCI에서 제공하는 메트릭 모니터링, 알람 설정 등을 하거나, Logging Analytics 상의 대쉬보드로 구성하는 등 추가적인 모니터링 관련 설정을 할 수 있습니다.


## Task 2: OSS ElasticSearch/Kibana (선택사항)

### 실습 비디오

[](youtube:HvxxkpJYvA4)


### Elastic Search + Kibana 설치

1. 설치용 namespace를 만듭니다.

    ```
    <copy>
    kubectl create ns logging
    </copy>    
    ```

2. Helm Chart를 통해 설치하기 위해 저장소를 등록합니다. 본 예제에서는 Bitnami Helm Chart 저장소를 사용합니다.

    ```
    <copy>    
    helm repo add bitnami https://charts.bitnami.com/bitnami
    </copy>       
    ```

3. Lab 3, 4에서 사용하던 values.yaml과 중복되지 않도록 다른 폴더에서 진행합니다.

4. 배포 설정값 정의
 
    ElasticSearch Helm Chart 배포시 사용할 values.yaml 파일을 만듭니다.
    - 다음 values.yaml은 kibana를 함께 설치하고, kibana 접근 URL을 이전 장에서 설치한 nginx ingress controller를 사용하는 예시입니다.

 
    ```yaml
    <copy>   
    cat <<EOF > values.yaml
    global:
      kibanaEnabled: true
    kibana:
      ingress:
        enabled: true
        pathType: Prefix
        hostname: "*"
        path: /kibana(/|$)(.*)
        annotations:
          kubernetes.io/ingress.class: nginx
        tls: false
      configuration:
        server:
          basePath: /kibana
          rewriteBasePath: true
    EOF
    </copy>      
    ```

    - 추가적인 사용자 설정이 필요한 경우, 대상 Chart에서 제공하는 파라미터를 참고하여 values.yaml을 작성할 수 있습니다.
        * https://github.com/bitnami/charts/tree/master/bitnami/elasticsearch/#parameters

5. elasticsearch helm chart 설치

    ```
    <copy>    
    helm install elasticsearch -f values.yaml bitnami/elasticsearch --version 19.16.3 -n logging
    </copy>
    ```

6. 설치

    아래와 같이 설치되며, 실제 컨테이너가 기동하는 데 까지 약간의 시간이 걸립니다.
 
    ```
    $ helm install elasticsearch -f values.yaml bitnami/elasticsearch --version 19.16.3 -n logging
    NAME: elasticsearch
    ...
      Elasticsearch can be accessed within the cluster on port 9200 at elasticsearch.logging.svc.cluster.local
    
      To access from outside the cluster execute the following commands:
    
        kubectl port-forward --namespace logging svc/elasticsearch 9200:9200 &
        curl http://127.0.0.1:9200/
    ```

7. 설치된 elastic search 내부 주소와 포트를 확인합니다. 이후 fluentbit에서 로그 전송을 위해 사용할 주소입니다.
    - 주소: elasticsearch.logging.svc.cluster.local
    - 포트: 9200

8. Pod가 모두 기동할때 까지 기다립니다.

    ````
    <copy>
    kubectl get pod -n logging --watch
    </copy>    
    ````

9. 설정값이 잘못되어 재설치가 필요한 경우 다음 명령으로 먼저 삭제하고 재설치합니다.

    ```
    <copy>    
    helm delete elasticsearch -n logging
    </copy>
    ```

### Fluent Bit 구성

참고 문서

- https://docs.fluentbit.io/manual/installation/kubernetes#installation

1. FluentBit Helm Chart 저장소를 추가합니다.

    ```
    <copy>
    helm repo add fluent https://fluent.github.io/helm-charts
    </copy>
    ```

2. ElasticSearch로 로그를 포워딩하기 위한 설정값을 작성합니다.

    - Replace_Dots On: 다음과 같이 labels의 key에 app.kubernetes.io와 같이 *.*이 포함된 경우 ElasticSearch 전송시 오류가 발생합니다. 이를 방지하기 위해 추가합니다.

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          ...
          labels:
            ...
            app.kubernetes.io/name: storefront
            ...
        ```    


    - Suppress\_Type\_Name On: ElasticSearch 8에서 _type 관련 오류가 발생하는 것을 방지하기 위해 추가합니다.
        * [Removal of mapping types](https://www.elastic.co/guide/en/elasticsearch/reference/current/removal-of-types.html#_schedule_for_removal_of_mapping_types)

    ````
    <copy>
    cat <<EOF > myvalues.yaml
    config:
      outputs: |
        [OUTPUT]
            Name es
            Match *
            Host elasticsearch.logging.svc.cluster.local
            Port 9200
            tls Off
            tls.verify Off
            Retry_Limit False
            Logstash_Format On
            Logstash_Prefix logstash
            Trace_Error On
            Replace_Dots On
            Suppress_Type_Name On
    EOF
    
    </copy>
    ````


3. OKE 클러스터에 FluentBit을 설치합니다.

    ```
    <copy>
    helm upgrade --install fluent-bit fluent/fluent-bit -f myvalues.yaml -n logging 
    </copy>
    ```


### Kibana 설정

1. ingress controller의 주소를 확인합니다.

    ```
    $ <copy>kubectl get ingress -n logging</copy>
    NAME                   CLASS    HOSTS   ADDRESS        PORTS   AGE
    elasticsearch-kibana   none     *       138.x.xxx.xx   80      56m
    ```

2. 설치한 kibana을 웹 브라우저로 접속합니다. nginx ingress controller 로 지정한 주소로 접속합니다.

    - 예, http://138.x.xxx.xx/kibana

3. Welcome to Elastic 화면이 나오면 Explore on my own을 클릭하여 홈으로 이동합니다.

4. 왼쪽 상단 **내비게이션 메뉴**에서 **Analytics** &gt; **Discover** 를 클릭합니다.

    ![Kibana Discover](images/kibana-discover.png)

5. 인덱스 패턴을 만들기 위해 Create data view를 클릭합니다.

6. 인덱스 패턴을 생성합니다.

    오른쪽에서 보듯이 Fluent Bit에서 전송된 로그는 logstash-로 시작합니다.

    - Name: logstash-*
    - Index pattern: logstash-*
    - Timestamp field: @timestamp

    ![Kibana Create Index](images/kibana-create-index.png)

7. 생성한 인덱스 패턴을 통해 수집된 로그를 확인할 수 있습니다.

8. 테스트를 위해 MuShop 웹페이지를 다음과 같이 접속합니다.

    - 예, http://138.xxx.xxx.xxx/?efk-test

9. 로그 확인

    ````
    $ <copy>kubectl logs -lapp=storefront -f --tail=10</copy>
    ...
    10.0.10.61 - - [24/Jan/2024:03:00:25 +0000] "GET /?efk-test HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "10.0.10.43, 10.0.10.201"        
    ...
    ````

10. 테스트 앱의 로그를 확인하기 위해 필터링을 위해 **+** 아이콘을 클릭한후 **kubernetes.namespace_name=mushop** 로 지정합니다.

    ![Kibana Add Filter](images/kibana-add-filter.png)

11. **+** 아이콘을 클릭한후 **kubernetes.container_name=storefront** 도 추가합니다.

12. 아래와 같이 kibana에서 테스트 앱의 로그를 확인할 수 있습니다.

    ![Kibana Logging Search](images/efk-logging-search.png)

13. EFK를 통해 OKE 상의 로그를 수집하는 예시였습니다. EFK에 대한 상세 내용은 제품 관련 홈페이지와 커뮤니티 사이트를 참고하기 바랍니다.


이제 **다음 실습을 진행**하시면 됩니다.

## Task 3: OCI Logging 서비스 (선택사항)

### 실습 비디오

[](youtube:L3gRfDFpesk)

### Worker Node에 대한 Dynamic Group 만들기

*Dynamic Group 생성은 관련 OCI IAM 권한이 필요합니다. 권한이 없는 경우 관리자 또는 워크샵 진행자에게 요청하거나, 제공하는 Dynamic Group을 사용합니다.*

> OKE 클러스터상의 Worker 노드들에 OCI Logging Agent를 설치되고 해당 Agent가 OCI Logging 서비스로 로그를 보내야 합니다. Worker 노드들은 스케일 인/아웃에 따라 동적으로 생성, 삭제 되기 때문에 Dynamic Group을 통해 지정하고, 해당 Dynamic Group에 OCI Logging 서비스에 대한 로그 쓰기 권한을 부여하는 과정입니다.

1. OCI 콘솔에 로그인합니다.

2. 좌측 상단 햄버거 메뉴에서 **Identity & Security** &gt; **Identity** &gt; **Compartments**로 이동합니다.

3. OKE 클러스터가 있는 Compartment의 OCID를 확인하고 복사해 둡니다.

4. 좌측 **Dynamic Group** 메뉴로 이동합니다. 또는 좌측 **Domain** &gt; **Default Domain**으로 이동한 후, **Dynamic Group** 메뉴로 이동합니다.

5. 아래 규칙을 가진 Dynamic Group을 만듭니다.

    - Name: 예) oke-instance-dynamic-group

    ````
    <copy>    
    All {instance.compartment.id = '<compartment-ocid>'}
    </copy>    
    ````

### Dynamic Group에 대한 OCI Logging 서비스 권한 부여하기

1. 좌측 **Policy** 메뉴로 이동하여 아래 규칙을 가진 Policy을 만듭니다. 방금 생성한 Dynamic Group에 대한 Policy를 만듭니다. 

    - Name: 예) oke-logging-policy
    - Description: 예) oke-logging-policy
    - Policy

        ````
        <copy>
        allow dynamic-group <dynamic-group-name> to use log-content in compartment <compartment-name>
        </copy>    
        ````

        * 예시 - Identity Domain을 사용하는 경우
        ````
        <copy>
        allow dynamic-group 'Default'/'oke-instance-dynamic-group' to use log-content in compartment oci-hol-xx
        </copy>    
        ````
    
        * 예시 - Identity Domain을 사용하지 않은 경우
        ````
        <copy>
        allow dynamic-group oke-instance-dynamic-group to use log-content in compartment oci-hol-xx
        </copy>    
        ````    


### Log Group 만들기

Log Group은 로그들을 관리하는 말 그대로 로그의 묶음 단위 입니다. 커스텀 로그를 만들기 위해 먼저 만듭니다.

1. 좌측 상단 햄버거 메뉴에서 **Observability** **&** **Management** &gt; **Logging** &gt; **Log Groups**로 이동합니다.

2. Create Log Group을 클릭하여 로그 그룹을 만듭니다.

    - Name: 예) Default_Group

### Custom Log 만들기

Custom Log는 커스텀 애플리케이션에서 수집하는 로그에 매핑되는 것입니다. Custom Log를 정의하고, 이에 대한 로그 수집기를 정의합니다.

1. **Resources** &gt; **Logs** 메뉴로 이동하여 **Create custom log**를 클릭합니다.

2. 로그 이름을 입력합니다. 필요하면 고급옵션을 클릭하여, 보관 주기 변경합니다.

    - Name: 예) oke-cluster-1-custom-log

3. 다음 단계에 있는 Agent는 이해를 돕고자 별도로 설정합니다. 여기서는 일단 **Add configuration later** 선택

### Agent Configuration 설정

Agent Configuration는 로그를 수집하는 agent를 설정하는 부분입니다.

1. **Logging** &gt; **Agent Configurations** 메뉴로 이동하여 **Create agent config**를 클릭합니다.

2. Name: 예) oke-cluster-1-agent-conf

3. Description: 예) oke-cluster-1-agent-conf

4. 대상 Host Group을 앞서 만든 Dynamic Group으로 지정합니다.

    ![Log Agent Host Groups](images/log-agent-host-groups.png)

5. Agent 설정 부분에서 로그가 위치한 경로 및 수집된 로그의 전달 위치를 지정합니다.

    - log input: 
        * input type: Log path
        * input name: 예) container_log
        * File Paths: **/var/log/containers/*.log**

            - OKE 상에 있는 Pod들은 Worker Node 상에 **/var/log/containers/*.log**에 로그가 쓰여집니다.
            - **입력하고 엔터키를 꼭 칩니다.**

    - log destination: 수집한 로그를 전달한 앞서 생성한 custom log 이름을 지정합니다.

    ![Log Agent Configuration](images/log-agent-configuration.png)


### 로깅 테스트

1. Cloud Shell로 이동합니다.

1. MuShop 앱 접속을 위해 Nginx Ingress Controller의 Load Balancer IP를 다시 확인합니다.

    ````
    <copy>    
    kubectl get svc -n mushop-utilities
    </copy>    
    ````

    결과 예시
    ````
    NAME                                              TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
    ...
    mushop-utils-ingress-nginx-controller             LoadBalancer   10.96.153.161   138.xxx.xxx.xxx   80:30636/TCP,443:30140/TCP   6d22h
    ...    
    ````

1. Mushop UI이 store-front Pod의 로그를 조회합니다. app: storefront 레이블을 기준으로 로그를 조회합니다.

    ````
    <copy>
    kubectl logs -lapp=storefront -f --tail=10
    </copy>
    ````

1. 확인된 IP를 통해 이전에 배포된 MuShop 앱을 접속해 봅니다. 테스트를 위해 URL에 테스트용 값을 추가합니다. 예, /?customlogtest

    MuShop 앱 테스트 URL 한번만 접속할 경우 구간내에 Log Flush가 안될 수도 있으니 테스트를 위해 여러번 반복 접속합니다.

    ![MuShop Custom Log](images/mushop-custom-log.png)

1. 발생한 POD 로그는 다음과 같습니다.

    ````
    $ kubectl logs -lapp=storefront -f --tail=10
    ...
    10.0.10.20 - - [16/Oct/2023:01:50:48 +0000] "GET /?customlogtest HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36" "10.0.10.201, 10.0.10.28"
    ...
    ````


1. OCI 서비스 콘솔에서 **Observability & Management** &gt; **Logging** &gt; **Search** 화면으로 다시 돌아갑니다.

1. Custom filters 항목에서 `data.message = customlogtest` 검색값으로 *입력하고 엔터키를 누릅니다.* data.message는 컨테이너 로그 필드입니다.

    ![Logging Search](images/oci-logging-search-filter-1.png)

1. 같은 방법으로 `subject = *storefront*` 검색값으로 *입력하고 엔터키를 누릅니다.* subject는 대상 로그 파일 전체 경로입니다.

    ![Logging Search](images/oci-logging-search-filter-2.png)

1. 검색된 로그 항목을 펼치면, JSON 포맷 형텨로 로그 데이터를 확인할 수 있습니다.

    - Worker Node에 처음 Agent가 설치되면, 초기 설치 구성시간이 걸립니다. 
    - Log Agent를 통해 수집되는 주기가 있어 조회될때까지 5분 내외가 걸릴 수 있습니다.
    - 앞서 MuShop 앱 테스트 URL 한번만 접속한 경우 구간내에 Log Flush가 안되어 계속 기다려도 로그 조회가 안될 수 있으니, 테스트 URL 여러번 반복 접속합니다.   

    ![Logging Search](images/oci-logging-search-1.png)

1. 검색된 로그 데이터를 확인할 수 있습니다.

    ![Logging Search](images/oci-logging-search-2.png)


## Learn More

## Acknowledgements

- **Author** - DongHee Lee
- **Last Updated By/Date** - DongHee Lee, January 2024
