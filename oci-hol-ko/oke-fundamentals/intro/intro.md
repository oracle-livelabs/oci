# Introduction

Oracle Cloud Native 솔루션을 활용하여 클라우드 네이티브 마이크로서비스 애플리케이션을 배포하여 사용하는 방법을 MuShop 이라는 데모 애플리케이션을 통해 알아봅니다. Oracle Container Engine for Kubernetes(OKE)와 Oracle Cloud Infrastructure 구성 요소를 활용하는 확장성이 뛰어난 아키텍처를 지닌 각 구성 요소를 활용하여 다중 언어, 즉 polyglot 형태로 개발된 마이크로서비스 기반의 전자 상거래 애플리케이션을 배포합니다.

예상 시간: 4시간

### 목표

이 실습에서는 다음을 수행합니다:

* OKE에서 쿠버네티스 클러스터 만들기
* [helm](https://helm.sh/)을 통해 Cloud Native 앱(MuShop)을 쿠버네티스 클러스터에 배포
* 배포된 앱 확인 및 접속
* 쿠버네티스 클러스터 및 배포된 앱 모니터링
* CI/CD를 통해 소스 코드 변경 작업에 대한 자동 배포
* 서비스 메쉬를 통한 마이크로 서비스 관리
* 클러스터 버전 업그레이드
* 모든 실습이 끝나고 사용한 자원 정리

### 전제 조건

1. Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
1. [Oracle Cloud Infrastructure 콘솔 익히기](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
1. [Networking 소개](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
1. [Compartments 익히기](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
1. 컨테이너 및 [Kubernetes](https://kubernetes.io/) 에 대한 기본 개념 지식

이제 **다음 실습을 진행**하시면 됩니다.


## Learn More

* [MuShop 샘플을 사용하여 OCI의 Cloud Native 애플리케이션 배포하기](https://oracle-quickstart.github.io/oci-cloudnative/)
* [참조 아키텍처: Kubernetes에서 마이크로서비스 기반 애플리케이션 배포](https://docs.oracle.com/en/solutions/cloud-native-ecommerce/index.html#GUID-CB180453-1F32-4465-8F27-EA7300ECF771)


## Acknowledgements

* **Author** - Adao Junior
* **Contributors** -  Kamryn Vinson, Adao Junior
* **Last Updated By/Date** - Adao Junior, April 2021
* **Korean Translator & Contributors** - DongHee Lee, February 2022
