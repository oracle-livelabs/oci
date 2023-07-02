# Create a Helm Chart

## Introduction

Helm은 복잡한 쿠버네티스 애플리케이션을 배포하기 위한 쿠버네티스 패키지 매니저입니다. 워크샵에 사용하는 MuShop은 마이크로 서비스들로 구성되어 많은 컴포넌트를 가지고 있고 이를 배포관리하기 위해 Helm을 사용하고 있습니다. 이를 이해하기 위해 사전 단계로 진행하는 실습니다.

- [Helm: The package manager for Kubernetes](https://helm.sh/)

예상 시간: 20분

### 목표

* 샘플 Helm Chart 만들기
* Helm CLI로 쿠버네티스에 배포하기

### 전제 조건

아래와 같이 코드 개발을 위한 툴이 필요합니다. 간단한 앱 개발로 여기서는 편의상 사전에 툴들이 설치된 Cloud Shell에서 진행하겠습니다.

* Helm CLI

### 실습 비디오

[](youtube:TUygTkGt_uc)


## Task 1: 샘플 차트 만들기

[Helm Chart Template Guide](https://helm.sh/docs/chart_template_guide/getting_started/) 예제를 따라 만든 샘플 차트을 만들어 OKE 클러스터에 배포하는 과정입니다.

1. Cloud Shell을 실행합니다.

2. 테스트를 위해 차트를 만듭니다.

    ````
    <copy>
    helm create mychart
    </copy>    
    ````

3. mychart 폴더가 만들어지고 차트관련 파일이 생성됩니다.

4. 아래와 같이 Helm Chart를 기본 구성 파일이 만들어 집니다. 생성된 차트는 기본적으로 nginx를 배포하게 구성되어 있습니다.

    - Chart.yaml: 차트 이름, 버전 등 기본 정보가 포함되어 있습니다.
    - values.yaml: templates 폴더 하위의 쿠버네티스 배포 템플릿의 배포 속성 중에서 변수값으로 사용자가 설정할 수 있는 값들이 정의되어 있습니다.
    ````
    .
    ├── Chart.yaml
    ├── charts
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── deployment.yaml
    │   ├── hpa.yaml
    │   ├── ingress.yaml
    │   ├── service.yaml
    │   ├── serviceaccount.yaml
    │   └── tests
    │       └── test-connection.yaml
    └── values.yaml
    ````

5. 개발한 Spring Boot 앱을 위한 차트를 만들기 위해 일부 내용을 수정합니다.

    - mychart/templates/service.yaml 파일을 수정합니다.
        * spec.ports.targetPort 항목을 http(80) 포트가 아닌, 변수에서 가져올 수 있도록 *{{ .Values.service.targetPort }}*로 변경합니다.
    ````
    ...
    spec:
      type: {{ .Values.service.type }}
      ports:
        - port: {{ .Values.service.port }}
          targetPort: {{ .Values.service.targetPort }}
          protocol: TCP
          name: http
      selector:
        {{- include "mychart.selectorLabels" . | nindent 4 }}
    ...
    ````

    - mychart/templates/deployment.yaml 파일을 수정합니다.
        * ports.containerPort: 기본 http 포트인 80 이 아닌, 변수 *{{ .Values.service.targetPort }}* 에서 가져올 수 있도록 변경합니다.
        * livenessProbe: httpGet.path를 /가 아닌, Spring Boot Actuator가 제공하는 경로로 변경합니다.
        * readreadinessProbe: httpGet.path를 /가 아닌, Spring Boot Actuator가 제공하는 경로로 변경합니다.
    ````
    ...
    36           ports:
    37             - name: http
    38               containerPort: {{ .Values.service.targetPort }}
    39               protocol: TCP
    40           livenessProbe:
    41             httpGet:
    42               path: /actuator/health/liveness
    43               port: http
    44           readinessProbe:
    45             httpGet:
    46               path: /actuator/health/readiness
    47               port: http
    ...
    ````

    - mychart/values.yaml 파일을 수정합니다. values.yaml 파일은 차트 내의 여러 파일들에서 사용하는 변수의 기본값을 정의하는 파일입니다.
        * image.repository: *각자에 맞게 수정 필요*, 이전 실습에서 OCIR로 Push한 이미지 주소로 변경, 예시에서는 ap-chuncheon-1.ocir.io/axjowrxaexxx/oci-hol-xx/spring-boot-greeting
        * image.tag: *각자에 맞게 수정 필요*, 예시에서는 "1.0"
        * imagePullSecrets.name: *각자에 맞게 수정 필요*, 예시에서는 ocir-secret
    ````
    ...
     7 image:
     8   repository: ap-chuncheon-1.ocir.io/cn8wdnkejjgq/oci-hol-xx/spring-boot-greeting
     9   pullPolicy: IfNotPresent
    10   # Overrides the image tag whose default is the chart appVersion.
    11   tag: "1.0"
    12 
    13 imagePullSecrets:
    14   - name: ocir-secret
    15 nameOverride: ""   
    ...   
    ````
        * service.targetPort로 8080을 추가합니다. 이 값이 {{ .Values.service.targetPort }}에 해당하게 됩니다. 이전 실습에서 개발한 Spring Boot 앱의 포트가 8080이라 그에 맞게 입력한 사항입니다.
    ````
    ...
    38   # runAsUser: 1000
    39 
    40 service:
    41   type: ClusterIP
    42   port: 80
         targetPort: 8080
    43 
    44 ingress:    
    ... 
    ````

## Task 2: Helm Chart로 OKE 클러스터에 배포하기

1. 작성한 차트로 배포합니다. mychart/values.yaml에 있는 변수값들을 이용해 기본적으로 배포되며, 필요시 아래와 같이 --set을 통해 배포시 변경할 수 있습니다. 앞서 ClusterIP 타입이였는데, 아래와 같이 LoadBalancer로 배포시 변경해 봅니다.

    ````
    <copy>
    helm install mychart ./mychart --set service.type=LoadBalancer
    </copy>
    ````

2. 배포 결과를 확인합니다.

    ````
    <copy>
    helm list
    kubectl get all
    </copy>
    ````

    실행 예시
    ````
    $ helm list
    NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
    mychart default         1               2023-06-26 08:07:41.327055597 +0000 UTC deployed        mychart-0.1.0   1.16.0     
    $ kubectl get all
    NAME                           READY   STATUS    RESTARTS   AGE
    pod/mychart-57c5f84846-xhdd5   1/1     Running   0          47s
    
    NAME                 TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)             AGE
    service/kubernetes   ClusterIP      10.96.0.1     <none>          443/TCP,12250/TCP   64m
    service/mychart      LoadBalancer   10.96.77.21   150.x.xxx.xxx   80:31057/TCP        47s
    
    NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/mychart   1/1     1            1           47s
    
    NAME                                 DESIRED   CURRENT   READY   AGE
    replicaset.apps/mychart-57c5f84846   1         1         1       47s
    ````

3. Pod가 정상적으로 기동하였습니다. service/mychart의 LoadBalancer의 EXTERNAL-IP를 통해 서비스를 요청합니다.

    ````
    <copy>
    curl http://150.xxx.xxx.xxx/greeting; echo
    </copy>
    ````

    ````
    {"id":1,"content":"Hello, World!"}
    ````

4. 테스트가 끝나면 자원을 정리합니다.

    ````
    <copy>
    helm delete mychart --namespace default
    </copy>
    ````

이제 **다음 실습을 진행**하시면 됩니다.

## Learn More

## Acknowledgements

- **Author** - DongHee Lee
- **Last Updated By/Date** - DongHee Lee, June 2023
