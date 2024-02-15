# Introduction

이 워크샵에서는 OCI(Oracle Cloud Infrastructure) 핵심 서비스인 VCN(가상 클라우드 네트워크), Compute Instance 및 Block Volume 서비스에 대한 기초 내용을 다룹니다.

- [Core Services Concepts](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts-core.htm)

본 실습은 Oracle University에서 제공하는 [OCI Foundations Associate](https://learn.oracle.com/ols/learning-path/become-an-oci-foundations-associate/35644/108448) 자격을 취득하는 데 필요한 기초적인 스킬과 지식을 제공합니다. Oracle Cloud Infrastructure Foundations Associate 인증은 응시자에게 핵심 클라우드 컴퓨팅 개념에 대한 기본 지식과 해당 OCI 서비스에 대한 이해를 제공합니다. 이 인증은 Oracle Cloud Infrastructure에 대한 이해도를 높일 수 있는 하나의 수단이 될 수 있으니, 인증을 획득하는 것을 추천드립니다.

예상 시간: 4시간

### 목표
이 실습에서는 다음을 수행합니다:
- 자원에 대한 유저 권한을 제어하는 Identity and Access Management
- Virtual Cloud Network 생성
- Compute 인스턴스 생성
- SSH 키 생성
- Block Volume 생성 및 Compute 인스턴스에 장착

### 전제조건
- Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account

>**노트:** **Free Trial** 계정이 있는 경우, 무료 평가 기간이 만료되면, 계정이 **Always Free** 계정으로 전환됩니다. **Always Free** 환경이 없는 경우, Oracle Free Tier를 요구하는 워크샵은 진행할 수 없습니다.

**[Oracle Cloud Free Tier FAQ 페이지 보기](https://www.oracle.com/kr/cloud/free/faq/)**

## Oracle Cloud Infrastructure 소개

Oracle Cloud Infrastructure는 고가용성 호스트 환경에서 광범위한 애플리케이션들과 서비스들을 구축하고 실행할 수 있도록 하는 완전한 클라우드 서비스의 집합니다. Oracle Cloud Infrastructure은 여러분이 사용하고 있는 온프레미스 네트워크에서 안전하게 접근할 수 있는, 유연한 오버레이 가상 네트워크에서 고성능 컴퓨팅 기능와 스토리지를 제공합니다.

다음 비디오를 통해 Oracle Cloud Infrastructure의 이점을 알아봅니다.

[](youtube:-OBrKIlSt_Q:medium)

이제 **다음 실습을 진행**하시면 됩니다.

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager, DB Product Management)
- **Korean Translator & Contributors** - DongHee Lee, March 2023
- **Last Updated By/Date** - DongHee Lee, March 2023