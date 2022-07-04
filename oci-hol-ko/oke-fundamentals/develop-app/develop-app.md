# Develop a Microservice

## Introduction

마이크로 서비스 애플리케이션 만들기 위해 자바에서는 Spring Boot를 많이 사용하고 오라클에서 지원하는 오픈소스 프레임워크인 Helidon도 사용되고 있습니다. 여기에서는 Spring Boot를 통해 마이크로 서비스를 만들고 OKE에 배포하는 과정을 통해 마이크로 서비스 개발, 컨테이너 이미지 생성, 쿠버네티스에서 구동하는 일련의 과정을 간단한 앱을 통해서 이해를 돕고자 합니다.

예상 시간: 20분

### 목표

* Spring Boot로 마이크로 서비스 만들기
* 컨테이너 이미지 만들기
* 컨테이너 이미지 레지스트리인 OCIR 등록하기
* Kubernetes인 OKE에 마이크로 서비스 배포하기

### 전제 조건

아래와 같이 코드 개발을 위한 툴이 필요합니다. 간단한 앱 개발로 여기서는 편의상 사전에 툴들이 설치된 Cloud Shell에서 진행하겠습니다.

* 선호하는 텍스트 편집기 또는 IDE
* JDK 1.8 or later
* Gradle 4+ or Maven 3.2+

### 실습 비디오

[](youtube:8XKd62hwNQg)

## Task 1: Spring Boot 기반 마이크로 서비스 만들기

[Spring Initializr](https://start.spring.io)를 사용하여 기본 프로젝트 소스파일을 기반으로 개발을 하게 됩니다.
    
1. (Option #1) [Spring Initializr](https://start.spring.io)를 사용하여 기본 프로젝트 소스파일을 만듭니다.

    1) 아래 그림과 같이 프로젝트 정보를 입력하고 **Generate**를 클릭하여 소스파일을 생성합니다.
    ![Spring Initializr](images/spring-initializr.png)

    2) 다운로드 받은 파일을 Cloud Shell에 업로드 합니다.
    ![File Upload](images/cloud-shell-upload-1.png =30%x*)

    ![File Upload](images/cloud-shell-upload-2.png =50%x*)        

    3) Cloud Shell에서 업로드된 파일을 unzip으로 압축해제 합니다.


2. (Option #2) Spring Initializr를 브라우저 대신 아래 명령을 통해 Cloud Shell에서 바로 기본 프로젝트 소스파일을 만듭니다.

    ````
    <copy>
    curl https://start.spring.io/starter.tgz -d baseDir=rest-service -d name=rest-service -d artifactId=rest-service -d javaVersion=1.8 -d dependencies=web,actuator | tar -xzvf -
    </copy>
    ````

3. **rest-service** 폴더로 이동합니다.

4. 요청에 대한 응답 메시지를 아래와 같은 JSON 메시지 응답하는 코드를 구현합니다.

    ````
    {
        "id": 1,
        "content": "Hello, World!"
    }
    ````

    아래 코드를 복사하여 자바 클래스파일(src/main/java/com/example/restservice/Greeting.java)을 에 작성합니다.

    ````
    <copy>
    package com.example.restservice;

    public class Greeting {

        private final long id;
        private final String content;

        public Greeting(long id, String content) {
            this.id = id;
            this.content = content;
        }

        public long getId() {
            return id;
        }

        public String getContent() {
            return content;
        }
    }
    </copy>
    ````

5. /greeting URL로 HTTP Get 요청에 대한 처리 결과, 여기서는 응답 메시지 전달을 위한 RestController 코드를 src/main/java/com/example/restservice/GreetingController.java 위치에 작성합니다.

    ````
    <copy>
    package com.example.restservice;

    import java.util.concurrent.atomic.AtomicLong;

    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.RequestParam;
    import org.springframework.web.bind.annotation.RestController;

    @RestController
    public class GreetingController {

        private static final String template = "Hello, %s!";
        private final AtomicLong counter = new AtomicLong();

        @GetMapping("/greeting")
        public Greeting greeting(@RequestParam(value = "name", defaultValue = "World") String name) {
            return new Greeting(counter.incrementAndGet(), String.format(template, name));
        }
    }
    </copy>
    ````

6. Kubernetes에서는 컨테이너 기동후 준비시간(readiness), 헬스체크를(liveness)를 Spring Boot에 활성화하기 src/main/resources/application.properties 파일에 다음 설정을 추가합니다.

    ````
    <copy>    
    management.health.probes.enabled=true
    </copy>
    ````

7. 실행을 위해 코드를 빌드합니다.

    ````
    <copy>
    ./mvnw clean package
    </copy>
    ````

8. 빌드된 JAR 파일을 실행합니다.

    ````
    <copy>
    java -jar target/rest-service-0.0.1-SNAPSHOT.jar
    </copy>
    ````

    아래와 같이 서비스가 빠르게 실행되고, 내장 Tomcat을 통해 8080 포트로 실행되는 것을 빠르게 실행되는 것을 알 수 있습니다.

    ````    
      .   ____          _            __ _ _
     /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
    ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
     \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
      '  |____| .__|_| |_|_| |_\__, | / / / /
     =========|_|==============|___/=/_/_/_/
     :: Spring Boot ::                (v2.6.4)
    
    2022-03-07 00:27:56.538  INFO 2806 --- [           main] c.e.restservice.RestServiceApplication   : Starting RestServiceApplication v0.0.1-SNAPSHOT using Java 1.8.0_322 on 6d0b991bde66 with PID 2806 (/home/winter/rest-service/target/rest-service-0.0.1-SNAPSHOT.jar started by winter in /home/winter/rest-service)
    2022-03-07 00:27:56.544  INFO 2806 --- [           main] c.e.restservice.RestServiceApplication   : No active profile set, falling back to 1 default profile: "default"
    2022-03-07 00:27:59.015  INFO 2806 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
    2022-03-07 00:27:59.037  INFO 2806 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
    2022-03-07 00:27:59.038  INFO 2806 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.58]
    2022-03-07 00:27:59.134  INFO 2806 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
    2022-03-07 00:27:59.134  INFO 2806 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 2409 ms
    2022-03-07 00:28:00.235  INFO 2806 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 1 endpoint(s) beneath base path '/actuator'
    2022-03-07 00:28:00.290  INFO 2806 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
    2022-03-07 00:28:00.327  INFO 2806 --- [           main] c.e.restservice.RestServiceApplication   : Started RestServiceApplication in 4.615 seconds (JVM running for 5.413)    
    ````

9. 테스트를 위해 브라우저 탭을 하나 더 열고 동일한 Oracle Cloud 계정으로 접속하여 Cloud Shell을 실행합니다.

10. 두 번째 Cloud Shell에서 서비스를 테스트합니다.

    ````
    <copy>
    curl http://localhost:8080/greeting; echo
    </copy>    
    ````

    ````
    {"id":1,"content":"Hello, World!"}    
    ````


11. 첫 번째 Cloud Shell에서 실행되는 앱을 중지합니다.

## Task 2: Container Image 만들기

쿠버네티스에서 실행하기 위해서는 구동할 서비스 애플리케이션을 컨테이너화 하여야 합니다. Docker 클라이언트를 통해 컨테이너 이미지를 만듭니다.

1. 프로젝트 폴더에 Dockerfile을 아래와 같이 만듭니다. openjdk:8-jdk-alpine 베이스 이미지를 사용하여 빌드된 JAR 파일을 이미지 내부로 복사하고 java -jar로 실행하게 하는 예시입니다.

    ````
    <copy>
    FROM openjdk:8-jdk-alpine
    ARG JAR_FILE=target/*.jar
    COPY ${JAR_FILE} app.jar
    ENTRYPOINT ["java","-jar","/app.jar"]
    </copy>
    ````

2. 이미지를 빌드합니다.

    ````
    <copy>
    docker build -t spring-boot-greeting:1.0 .
    </copy>
    ````

    ````
    Sending build context to Docker daemon   19.8MB
    Step 1/4 : FROM openjdk:8-jdk-alpine
    Trying to pull repository docker.io/library/openjdk ... 
    8-jdk-alpine: Pulling from docker.io/library/openjdk
    e7c96db7181b: Pull complete 
    f910a506b6cb: Pull complete 
    c2274a1a0e27: Pull complete 
    Digest: sha256:94792824df2df33402f201713f932b58cb9de94a0cd524164a0f2283343547b3
    Status: Downloaded newer image for openjdk:8-jdk-alpine
     ---> a3562aa0b991
    Step 2/4 : ARG JAR_FILE=target/*.jar
     ---> Running in b537a4693e0b
    Removing intermediate container b537a4693e0b
     ---> 6643c18270a3
    Step 3/4 : COPY ${JAR_FILE} app.jar
     ---> 41e641b21316
    Step 4/4 : ENTRYPOINT ["java","-jar","/app.jar"]
     ---> Running in 51971b230f60
    Removing intermediate container 51971b230f60
     ---> a80b8a33c501
    Successfully built a80b8a33c501
    Successfully tagged spring-boot-greeting:1.0
    ````    

3. 현재 로컬(여기서는 Cloud Shell)에 있는 이미지를 조회합니다.

    ````
    <copy>
    docker images
    </copy>
    ````

    ````
    REPOSITORY             TAG                 IMAGE ID            CREATED              SIZE
    spring-boot-greeting   1.0                 a80b8a33c501        About a minute ago   124MB
    openjdk                8-jdk-alpine        a3562aa0b991        2 years ago          105MB
    ````    

## Task 3: OCIR에 이미지 등록하기

1. OCIR에 컨테이너 이미지를 푸시하기 위해서는 다음과 같은 이미지 태그 네이밍 규칙을 따라야 합니다. 아래 정보를 확인합니다.

    > ````<region-key or region-identifier>.ocir.io/<tenancy-namespace>/<repo-name>:<tag>````

    - region-key: 지금은 Region Key, Region Identifier 둘다 지원하므로, 서울은 icn, ap-seoul-1, 춘천은 yny, ap-chuncheon-1을 쓰면 됩니다. 전체 주소 정보는 [OCIR Available Endpoint](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm#regional-availability)에서 확인하세요.
    - tenancy-namespace: OCI 콘솔 Tenancy 상세 정보에서 Object Storage Namespace로 확인하거나, Cloud Shell에서 **oci os ns get**으로 확인합니다.
    - repo-name: 이미지 이름, 경로가 있는 경우 경로를 포함한 이름

    ````
    winter@cloudshell:rest-service (ap-chuncheon-1)$ oci os ns get
    {
      "data": "axjowrxaexxx"
    }
    winter@cloudshell:rest-service (ap-chuncheon-1)$ TENANCY_NAMESPACE=`oci os ns get --query 'data' --raw-output`
    winter@cloudshell:rest-service (ap-chuncheon-1)$ echo $TENANCY_NAMESPACE 
    axjowrxaexxx
    winter@cloudshell:rest-service (ap-chuncheon-1)$ echo $OCI_REGION 
    ap-chuncheon-1    
    ````

2. OCIR 등록을 위해 기존 이미지에 추가로 태그를 답니다.
    - Tenancy를 혼자 사용하는 경우
        * OCI_REGION: *각자에 맞게 수정 필요*, 예시에서는 ap-chuncheon-1
        * TENANCY_NAMESPACE: *각자에 맞게 수정 필요*, 예시에서는 axjowrxaexxx
        * REPO_NAME: *각자에 맞게 수정 필요*, 예시에서는 spring-boot-greeting
        * TAG: *각자에 맞게 수정 필요*, 예시에서는 1.0


    ````
    <copy>
    docker tag spring-boot-greeting:1.0 $OCI_REGION.ocir.io/$TENANCY_NAMESPACE/spring-boot-greeting:1.0
    </copy>    
    ```` 

    - 실행예시, 동일한 이미지에 태그가 추가된 것을 알 수 있습니다.

    ````
    winter@cloudshell:rest-service (ap-chuncheon-1)$ docker tag spring-boot-greeting:1.0 ap-chuncheon-1.ocir.io/axjowrxaexxx/spring-boot-greeting:1.0
    winter@cloudshell:rest-service (ap-chuncheon-1)$ docker images
    REPOSITORY                                                 TAG                 IMAGE ID            CREATED             SIZE
    ap-chuncheon-1.ocir.io/axjowrxaexxx/spring-boot-greeting   1.0                 a80b8a33c501        6 minutes ago       124MB
    spring-boot-greeting                                       1.0                 a80b8a33c501        6 minutes ago       124MB
    openjdk                                                    8-jdk-alpine        a3562aa0b991        2 years ago         105MB
    ````    

3. OCIR에 이미지를 Push 하기 위해서는 Docker CLI로 OCIR에 로그인이 필요합니다. Username 및 Password는 다음과 같습니다.
    - Username: `<tenancy-namespace>/<user-name>` 형식으로 `<user-name>`은 OCI 서비스 콘솔에서 유저 Profile에서 보이는 유저명을 사용합니다. oracleidentitycloudservice/로 시작하는 경우 oracleidentitycloudservice/ 포함하여 보이는 전체가 유저명입니다.
    - Password: 사용자의 Auth Token을 사용합니다. **My Profile** > **Auth tokens** > **Generate token** 을 통해 생성합니다. Auth Token은 생성시점에만 확인이 가능하므로 복사해서 기록해 둡니다.

        ![Auth Token](images/auth-token-1.png =30%x*) 
        ![Auth Token](images/auth-token-2.png =30%x*) 
        ![Auth Token](images/auth-token-3.png =50%x*) 

    - 아래와 같이 Docker CLI로 로그인합니다.
        * OCI_REGION: *각자에 맞게 수정 필요*, 예시에서는 ap-chuncheon-1
        * TENANCY_NAMESPACE: *각자에 맞게 수정 필요*, 예시에서는 axjowrxaexxx
        * USER_NAME: *각자에 맞게 수정 필요*, 예시에서는 winter

    ````
    docker login $OCI_REGION.ocir.io -u $TENANCY_NAMESPACE/$USER_NAME
    ````

    - 실행예시

    ````
    winter@cloudshell:~ (ap-chuncheon-1)$ docker login ap-chuncheon-1.ocir.io -u axjowrxaexxx/winter
    Password: 
    WARNING! Your password will be stored unencrypted in /home/winter/.docker/config.json.
    Configure a credential helper to remove this warning. See
    https://docs.docker.com/engine/reference/commandline/login/#credentials-store
    
    Login Succeeded
    ````    

4. OCIR를 위해 단 이미지 태그를 사용하여 이미지를 Push합니다.
    ````
    <copy>
    docker push $OCI_REGION.ocir.io/$TENANCY_NAMESPACE/spring-boot-greeting:1.0
    </copy>   
    ````

    - 실행예시

    ````
    docker push ap-chuncheon-1.ocir.io/axjowrxaexxx/spring-boot-greeting:1.0
    ````

5. OCI 콘솔에서 왼쪽 상단의 **Navigation Menu**를 클릭하고 **Developer Services**로 이동한 다음 **Container Registry**를 선택 합니다.

6. Root compartment에 Push한 이미지가 등록된 것을 볼 수 있습니다.

    > 특정 Compartment에 이미지를 Push 하기 위해서는 Push 되기 전에 OCIR에 Repository가 만들어져 있어야 합니다. 없는 경우 Root Commpartment에 자동으로 Private Repository가 생성되도록 기본 설정되어 있습니다.

    ![OCIR Image](images/ocir-spring-boot-greeting.png)     

## Task 4: OKE에 마이크로 서비스 배포하기

1. OCIR에 이미지를 사용하여 OKE에 컨테이너를 기동하기 위해서는 OKE에서 OCIR 이미지에 접근하는 권한이 필요합니다. OCIR Private Repository로 등록했기 때문에 OKE에 접속을 위한 secret를 생성합니다. 이미 Cloud Shell에서 Docker CLI로 OCI에 로그인 했으므로 해당 정보를 이용하여 생성합니다.

    ````
    <copy>
    kubectl create secret generic ocir-secret \
    --from-file=.dockerconfigjson=$HOME/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson    
    </copy>
    ````

2. 다음 YAML 파일을 이용해 OKE에 배포합니다. Load Balancer 사용도 함께 진행하기 위해 Service 자원도 함께 배포합니다.

    - 배포 파일 생성합니다. 예, 파일명: spring-boot-greeting.yaml
        * `IMAGE_REGISTRY_PATH`: *각자에 맞게 수정 필요*, 예시에서는 `ap-chuncheon-1.ocir.io/axjowrxaexxx/spring-boot-greeting:1.0`

    ````
    <copy>
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: spring-boot-greeting
      name: spring-boot-greeting-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: spring-boot-greeting
      template:
        metadata:
          labels:
            app: spring-boot-greeting
        spec:
          containers:
          - name: spring-boot-greeting
            image: $IMAGE_REGISTRY_PATH
          imagePullSecrets:
          - name: ocir-secret
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: spring-boot-greeting-service
    spec:
      selector:
        app: spring-boot-greeting
      ports:
        - protocol: TCP
          port: 80
          targetPort: 8080
      type: LoadBalancer
    </copy>
    ````

3. 작성한 yaml 파일을 통해 개발한 Spring Boot 앱을 배포합니다.

    ````
    <copy>
    kubectl apply -f spring-boot-greeting.yaml
    </copy>
    ````


4. kubectl get all 명령으로 배포된 자원을 확인합니다.

    ````
    <copy>
    kubectl get all
    </copy>
    ````

    ````
    NAME                                                   READY   STATUS    RESTARTS   AGE
    pod/spring-boot-greeting-deployment-84c4865b98-7rmrp   1/1     Running   0          34s
    
    NAME                                   TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)        AGE
    service/kubernetes                     ClusterIP      10.96.0.1      <none>            443/TCP        10h
    service/spring-boot-greeting-service   LoadBalancer   10.96.75.242   150.xxx.xxx.xxx   80:32418/TCP   35s
    
    NAME                                              READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/spring-boot-greeting-deployment   1/1     1            1           35s
    
    NAME                                                         DESIRED   CURRENT   READY   AGE
    replicaset.apps/spring-boot-greeting-deployment-84c4865b98   1         1         1       35s
    ````

5. Pod가 정상적으로 기동하였습니다. LoadBalancer의 EXTERNAL-IP를 통해 서비스를 요청합니다.

    ```
    <copy>
    curl http://150.xxx.xxx.xxx/greeting; echo
    </copy>
    ```

    ````
    {"id":1,"content":"Hello, World!"}    
    ````

6. 테스트가 끝나면 자원을 정리합니다.

    ````
    <copy>
    kubectl delete deploy spring-boot-greeting-deployment
    kubectl delete svc spring-boot-greeting-service
    </copy>
    ````

이제 **다음 실습을 진행**하시면 됩니다.

## Learn More

* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Spring Boot with Docker](https://spring.io/guides/gs/spring-boot-docker/)

## Acknowledgements

* **Author** - DongHee Lee, February 2022
