# Introduction

Oracle Cloud Native 솔루션 중에 하나인 OCI Functions을 통해 OCI에서 제공하는 함수 서비스를 알아 봅니다. 이 워크샵에는 OCI 네트워킹, 컴퓨터 및 Cloud Shell 등 Oracle Cloud의 여러 구성 요소가 포함됩니다.

예상 시간: 4시간

## OCI Functions

OCI Functions 서비스는 개발자가 하드웨어, 운영 체제, 언어 런타임 또는 컨테이너에 대해 걱정하지 않고 코드를 실행할 수 있는 방법을 제공합니다. Oracle Functions는 서버리스로 인프라 관리가 필요하지 않습니다. 인스턴스나 소프트웨어 패치/업그레이드에 대해 걱정할 필요가 없습니다. OCI Functions를 사용하면 고가용성, 확장성, 보안 및 모니터링 기능을 제공합니다

OCI Functions는 오픈 소스 [Fn 프로젝트](https://fnproject.io/)를 기반으로 합니다. Fn 프로젝트는 이벤트 중심의 FaaS(Function as a Service) 플랫폼입니다. Fn 프로젝트를 로컬에서 설치하여 기능을 개발하고 테스트 할 수도 있습니다. python, java, go, node.js, ruby, C# 등의 언어를 지원합니다. OCI Functions은 Fn 프로젝트를 OCI에서 제공하는 서비스입니다. OCI Functions의 이벤트 기반 특성은 유휴 시간이 아닌 함수가 트리거되어 실행되는 시간 및 자원에 대해서만 고객에게 요금이 부과됨을 의미합니다.

OCI Functions에 기본 소개는 다음 비디오를 참조하세요.

*노트: 스크린샷 및 작업 흐름은 업데이트로 인해 지금과 일부 다를 수 있습니다.*

[](youtube:C4cwkLPxGpc)

### 목표

이 실습에서는 다음을 수행합니다:

* OCI Functions을 사용하여 HelloWorld Function 만들기
* OCI Functions을 사용하는 패턴별 사용사례

    - **Object Storage > Events > Functions > Object Storage** 패턴을 통한 썸네일 이미지 만들기
    - **Logging > Service Connector Hub > Functions > 대상 시스템** 패턴을 통한 로그메시지 전달하기
    - **API Gateway > Functions** 패턴을 통한 API Backend 구현체로써 Functions 사용하기


### 전제 조건

1. Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
1. [Oracle Cloud 기초 익히기](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts.htm)
1. [Oracle Cloud Infrastructure 콘솔 익히기](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/console.htm)
1. [Networking 소개](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/overview.htm)


이제 **다음 실습을 진행**하시면 됩니다.


## Learn More

* [Cloud Shell에서 Functions QuickStart 해보기](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsquickstartcloudshell.htm#functionsquickstart_cloudshell)
* [로컬환경에서 Functions QuickStart 해보기](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsquickstartlocalhost.htm)
* [OCI Compute 인스턴스에서 Functions QuickStart 해보기](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsquickstartocicomputeinstance.htm)


## Acknowledgements

* **Author** - DongHee Lee
* **Last Updated By/Date** - DongHee Lee, January 2023
