# Criar o Oracle Analytics Cloud (OAC)

## Introdução
A Oracle Cloud é o provedor de nuvem mais amplo e integrado do setor, com opções de implantação que vão desde a nuvem pública até o seu data center. A Oracle Cloud oferece serviços de alta qualidade em Software como Serviço (SaaS), Plataforma como Serviço (PaaS) e Infraestrutura como Serviço (IaaS).
Nesse Lab você vai aprender a provisionar o *Oracle Analytics Cloud*, a ferramenta para visualização e BI da Oracle Cloud.

*Tempo estimado para o Lab:* 10 Minutos

### Objetivos

Neste Laboratório você vai:
* Aprender como fazer login na sua conta Oracle Cloud
* Provisionar um Oracle Analytics Cloud


## Task 1: Fazer Login na Oracle Cloud

  1. Abra seu navegador da Web e acesse [a Oracle Cloud](https://cloud.oracle.com).
Insira o nome da sua conta na nuvem se estiver entrando em uma conta com o Identity Cloud Service.

   ![Acessando a cloud](./images/acesso_a_cloud.png) 

   Quando a nova página carregar, apenas clique em **Continue**.

   ![Logando na console do OCI](./images/login_oci.png) 

2.  Na página de login de **Cloud Infrastructure**, insira suas credenciais de login e, em seguida, clique em **Acessar**.

   ![Acessando a cloud](./images/tela_login.png) 

3. Agora você está conectado à Oracle Cloud!

   ![OCI Console Home Page](https://oracle-livelabs.github.io/common/images/console/home-page.png " ")



## Task 2: Processo de criação do Oracle Analytics Cloud

Nesse tutorial criaremos uma instância da ferramenta Oracle Analytics Cloud.

1. Criar o OAC

   ![veja o banco de dados disponível](./images/analytics_menu.png)

- Clicar no Menu Hambúrguer no lado esquerdo superior;
- Clicar em **Analytics & AI**;
- Clicar em **Analytics Cloud**.

   ![veja o banco de dados disponível](./images/analytics_create_instance.png)


- Verificar se está no compartimento correto;
- Clicar em **Create Instance**.

   ![veja o banco de dados disponível](./images/analytics_creation.png)

2. Preencher as informações:

* Name: nome dado à instância;
* Description: descrição dada à instância – opcional;
* Create in Compartment: Compartimento onde a instância será criada;
* Feature Set: Escolher **Professional Edition**;
* Capacity: Escolher **OCPUs** e digitar **1**;
* License Type: Escolher **License Included**;

- Clicar em **Create** .

3. Acessar o Oracle Analytics Cloud

   Nesse passo mostraremos como acessamos a instância do Oracle Analytics Cloud.
- Clicar no nome da instância criada “Nome Escolhido”;
   ![veja o banco de dados disponível](./images/InstanceOAC.png)

- Clicar em **Analytics Home Page**.
   ![veja o banco de dados disponível](./images/analytics_access.png)

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você provisionou um Oracle Analytics Cloud, ele será utilizado durante todo o laboratório.

## Autoria

- **Autores** - Breno Comin, Thais Henrique, Gabriela Miyazima
- **Último Update Por/Data** - Thais Henrique, Julho/2024
