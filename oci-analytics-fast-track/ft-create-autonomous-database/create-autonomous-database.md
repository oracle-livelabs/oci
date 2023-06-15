# Criar os recursos necessários para o Laboratório

## Introdução
A Oracle Cloud é o provedor de nuvem mais amplo e integrado do setor, com opções de implantação que vão desde a nuvem pública até o seu data center. A Oracle Cloud oferece serviços de alta qualidade em Software como Serviço (SaaS), Plataforma como Serviço (PaaS) e Infraestrutura como Serviço (IaaS).
Nesse Lab você vai aprender a provisionar um Autonomous Database na Oracle Cloud Infrastructure.

***Overview***

Oracle Cloud Infrastructure Autonomous Database é um ambiente de banco de dados totalmente gerenciado e pré-configurado com três tipos de carga de trabalho disponíveis, Autonomous Transaction Processing, Autonomous Data Warehouse e Autonomous JSON. Você não precisa configurar ou gerenciar nenhum hardware ou instalar nenhum software. Após o provisionamento, você pode dimensionar o número de núcleos de CPU ou a capacidade de armazenamento do banco de dados a qualquer momento, sem afetar a disponibilidade ou o desempenho. O Banco de Dados Autônomo cuida da criação do banco de dados, bem como das seguintes tarefas de manutenção:
* Backup do Banco de dados
* Patching do Banco de dados
* Upgrading do Banco de dados
* Tuning do Banco de dados

*Tempo estimado para o Lab:* 25 Minutos

### Objetivos

Neste Laboratório você vai:
* Aprender como fazer login na sua conta Oracle Cloud
* Provisionar um Oracle Autonomous Data Warehouse
* Provisionar um Oracle Analytics Cloud


## Task 1: Fazer Login na Oracle Cloud

1.  Abra seu navegador da Web e acesse [a Oracle Cloud](https://cloud.oracle.com).
Insira o nome da sua conta na nuvem se estiver entrando em uma conta com o Identity Cloud Service. 

![Acessando a cloud](./images/acesso_a_cloud.png) 

Quando a nova página carregar, apenas clique em **Continue**.

![Logando na console do OCI](./images/login_oci.png) 

2.  Na página de login de **Cloud Infrastructure**, insira suas credenciais de login e, em seguida, clique em **Acessar**.

![Acessando a cloud](./images/tela_login.png) 

3. Agora você está conectado à Oracle Cloud!

![OCI Console Home Page](https://oracle-livelabs.github.io/common/images/console/home-page.png " ")

## Task 2: Processo de criação do Autonomous Database

Para iniciar o processo de criação do Autonomous Database:

1.	Clique no menu no lado esquerdo da tela principal, escolha Oracle Database, e depois “Autonomous Database"

![menu do Autonomous Database](./images/autonomous-database-menu-1.png)

2.	Clique em "Create Autonomous Database" e você será redirecionado para a criação do Autonomous Database.

![clique em "Create Autonomous Database"](./images/autonomous-database-create-2.png)

3.	Preencha os campos necessários para a criação do seu Autonomous Database conforme mostrado abaixo:

![preencha os campos do Autonomous Database](./images/autonomous-database-type-3.png)

* Display Name: **Escolha um Display Name para seu banco**
* Database name: **Escolha um Database Name para seu banco**
* Choose a workload type : Para este Workshop, por favor selecione **Data Warehouse**
* Choose a deployment type: **Shared Infrastructure**

![configure o Autonomous Database](./images/autonomous-database-config-4.png)

* Choose database version: **19c**
* OCPU count: **1**
* Storage (TB): **1**

![configure as credenciais e tipo de acesso](./images/autonomous-database-credentials-5.png)

* Create administrator credentials: **Crie um password para o usuário ADMIN**
* Choose network access: **Secure access from everywhere**


![escolha a licença e clique em "Create Autonomous Database"](./images/autonomous-database-license-6.png)

* Choose License and Oracle Database Edition: **License Included**
* Agora finalize a criação clicando no  botão **"Create Autonomous Database"**

4. Agora basta aguardar alguns minutos e em seguida você verá a tela:

![veja o banco de dados disponível](./images/autonomous-database-available-7.png)
*Seu Banco de Dado Autonomous foi provisionado com sucesso!*

## Task 3: Processo de criação do Oracle Analytics Cloud

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

## Task 4: Carregando os dados do laboratório no Autonomous

1. Acesse o seu Autonomous Database e clique no botão **Database Connection**.
![veja o banco de dados disponível](./images/image1.png)

2. Faça o download do arquivo de Wallet disponibilizado pelo banco.

![veja o banco de dados disponível](./images/image2.png)

3. Será solicitada a criação de um password no momento do Download.

![veja o banco de dados disponível](./images/image3.png)

4. Acesse o Cloud Shell a partir das Developer Tools disponíveis na região superior direita da Console.

![veja o banco de dados disponível](./images/image4.png)

5. Clique na Engrenagem e selecione a opção Upload.

![veja o banco de dados disponível](./images/image5.png)

6. Suba o arquivo da Wallet que acabou de ser baixado, assim como o script SETUP\_MIAU\_CORP.sql (disponível [aqui](https://objectstorage.us-ashburn-1.oraclecloud.com/p/WTbbTR3qL-sAT_BU6yKuJV-OEbwj97v2mxlQcbIY5q0s7auhcIZdbTVBN77Ib2Po/n/id3kyspkytmr/b/ArquivosPublicos/o/SETUP_MIAU_CORP.sql) para download

![veja o banco de dados disponível](./images/image6.png)

7. Valide que os arquivos foram carregados corretamente

![veja o banco de dados disponível](./images/image7.png)

8. Descompacte a wallet utilizando o comando
```
unzip nomedawallet.zip
```
![veja o banco de dados disponível](./images/image8.png)

9. Utilize o comando abaixo para editar o arquivo, e altere o campo DIRECTORY para o caminho até o seu arquivo Wallet. Para sair de edição do vi, clique ESC, depois ':wq' e logo após ENTER.
```
vi sqlnet.ora
```

![veja o banco de dados disponível](./images/image9.png)

10. Defina o mesmo caminho para a variável TNS_ADMIN.

![veja o banco de dados disponível](./images/image10.png)

11. Valide a variável com o comando echo $TNS_ADMIN

![veja o banco de dados disponível](./images/image11.png)

12. Conecte-se ao ADW através do comando
```
sqlplus admin@<nomedoadw>_high
```

![veja o banco de dados disponível](./images/image12.png)

13. Chame o script através do
```
@caminho_para_o_arquivo/SETUP_MIAU_CORP.sql
```

![veja o banco de dados disponível](./images/image13.png)

14. O script criará o Schema MIAU_CORP, assim como 2 tabelas populadas com 9000 linhas cada.
Ao finalizar, você verá a última mensagem como Commit Complete.

![veja o banco de dados disponível](./images/image14.png)

15. Caso queira, valide a quantidade de linhas nas 2 tabelas geradas.

![veja o banco de dados disponível](./images/image15.png)

Parabéns, você concluiu esse laboratório!

## Conclusão

Nesta sessão você provisionou um Oracle Autonomous Data Warehouse e um Oracle Analytics Cloud, que serão utilizados durante todo o laboratório. Também foram criados os schemas e carregados os dados para popular as tabelas no banco.

## Autoria

- **Autores** - Breno Comin, Thais Henrique, Isabella Alvarez, Isabelle Dias
- **Último Update Por/Data** - Isabelle Dias, Maio/2023
