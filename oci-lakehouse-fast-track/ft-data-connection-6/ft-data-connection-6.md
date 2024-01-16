# Conexão DBeaver e Consultas SQL

## Introdução

Esta etapa final do laboratório permitirá que você conecte sua camada de ouro, que foi gerada no laboratório anterior, ao DBeaver e ao SQL Endpoint do Data Flow para conduzir análises avançadas em seus dados. Vamos aos detalhes:

### *DBeaver:*

---

O DBeaver é uma ferramenta open source para o gerenciamento de banco de dados diversos em um mesmo lugar. Ele proporciona uma interface amigável para se conectar a uma variedade de sistemas de gerenciamento de bancos de dados, como MySQL, PostgreSQL, Oracle, SQL Server e muitos outros. No contexto deste laboratório, você usará o DBeaver para estabelecer uma conexão com sua camada de ouro através do SQL Endpoint do OCI Data Flow, o que será essencial para acessar e analisar os dados contidos nela.

### *SQL Endpoint do Data Flow:*

---

O SQL Endpoint do Data Flow é uma ferramenta muito útil para acessarmos dados que estão no OCI Object Storage. Ele oferece um ponto de acesso para executar consultas SQL diretamente em seus conjuntos de dados. Isso significa que você poderá realizar consultas SQL, aplicar transformações, executar análises e obter insights valiosos de seus dados.

Neste laboratório, você explorará o SQL Endpoint do Data Flow que criamos no Lab 0 e como configura o DBeaver para realizar consultas SQL específicas em sua camada de ouro. Isso permitirá que você aplique filtros, agregações e análises para extrair informações significativas de seus dados e tomar decisões informadas. 

*Tempo estimado para o Lab:* 15 Minutos

### Objetivos

* Estabelecer uma conexão entre a camada de ouro do laboratório anterior e o DBeaver para análise de dados.
* Aprender a configurar e utilizar o SQL Endpoint do Data Flow para executar consultas SQL.
* Realizar a instalação e configuração do DBeaver em sua máquina local.
* Explorar e analisar os dados da camada de ouro utilizando as ferramentas fornecidas pelo DBeaver.

[Oracle Video Hub video scaled to Large size](videohub:1_be5sglo6:large)

## Tarefa 1: Verificar o SQL Endpoint

1. Clique no **nome do notebook** na área superior esquerda da página para retornar para o ambiente da Oracle Cloud.

    ![Retornar Oracle Cloud](.\images\1-return-cloud.png)

2. Na página das informações do notebook, clique no menu na área superior esquerda da página.

    ![Acessar menu Cloud](.\images\2-select-menu-cloud.png)


3. Use o menu suspenso do console web OCI para acessar **Analytics & AI** e, em seguida, **Data Flow**.

    ![Selecionar Data Flow](.\images\3-acess-data-flow-oci.png)

4. Na página inicial do Data Flow, selecione *`SQL Endpoints`* na região esquerda.

    ![Selecionar SQL Endpoints](.\images\4-sql-endpoints.png)


5. Certifique-se de que estamos usando o compartimento **LiveLabs-DataEng** para o bucket que iremos acessar. Use o menu suspenso **Compartments** no lado esquerdo da página para selecionar o compartmento *LiveLabs-DataEng*.

    ![Certificar Compartment](.\images\5-verify-compartment.png)

6. Nesta página você verá o SQL Endpoint **SQLEndpoint\_Livelabs** com o Status **Active**. Agora clique em **SQLEndpoint\_Livelabs**.

    ![Criar SQL Endpoint](.\images\6-sqlendpoint-check.png)

Agora vamos fazer o download dos drivers necessários para configurarmos o DBeaver

7.  Desça a página principal e selecione a aba *Drivers*.

    ![Selecione Drivers](.\images\11-selection-drivers.png)

8. Faça o download do driver *JDBC*.

    ![Clique para fazer o download](.\images\12-download-jdbc.png)

9. Descompacte o driver baixado em sua máquina.

    ![Unzip o arquivo zip](.\images\13-unzip-folder.png)

10.  Acesse o folder descompactado, dentro dele você encontrará outro arquivo zip e uma pasta chamada **docs**. Agora descompacte essa outro aquivo zip.

    ![Unzip do segundo arquivo zip](.\images\14-unzip-second-folder.png)

## Tarefa 2: Instalação e Configuração DBeaver

1. Faça o [download do cliente DBeaver](https://dbeaver.io/download/)  em seu site de download e em seguida, *instale-o*. Você pode utilizar tanto as versões Community quanto Enterprise, mas elas devem ser no mínimo da versão 22.x.

> **Atenção:** O DBeaver está apenas disponível para Windows, Mac OS X, Eclipse Plugin, e Linux.

2. Abra o software através do ícone do DBeaver.

    ![Abrir DBeaver](.\images\13-icon-dbeaver.png)

3. Acesse Database e selecione Driver Manager

    ![Selecionar Driver Manager](.\images\15-driver-manager.png)

4. Clique em **New**.

    ![Selecionar New](.\images\16-new-driver.png)

5. Dê o nome "Data Flow Livelabs" no campo Driver Name. EM seguida clique em Libraries

    ![Driver Name](.\images\17-libraries.png)

6. Clique em Add Folder.

    ![Adicionar Pasta](.\images\18-add-folder.png)

7. Navegue até o local onde você salvou o arquivo do Driver que você baixou e descompactou na tarefa anterior. Em seguida clique em **OK**.

    ![Descompactar Arquivo](.\images\19-find-class.png)

8. Em seguida busque pelo drive na barra de buscas, como indicado na imagem abaixo

    ![Buscar Driver](.\images\20-search-driver.png)

9. Selecione o driver e clique no botão **Edit**.

    ![Edição driver](.\images\21-edit-driver.png)

10. Acesse a aba Libraries.

    ![Acesso Libraries](.\images\22-go-libraries.png)

11. Agora clique no botão **Find Class**.

    ![Encontrar clases](.\images\23-find-class.png)

12. Você deve ver a classe: *com.simba.spark.jdbc.Driver*, como indicado abaixo.

    ![Classe Simba Spark](.\images\24-class-selection.png)

13. Clique na aba Setting e verifique se a classe está sendo indicada no campo **Class Name**, em seguida clique em OK para salvar

    ![Salvar informação](.\images\25-verify-class.png)

14.  Agora clique em **Close**.

    ![Driver Manager](.\images\26-close-driver-manager.png)

## Tarefa 3: Criar a conexão do DBeaver com o SQL Endpoint

1.  Acesse Database e clique em **New Database Connection**.

    ![Novo Database](.\images\28-new-database.png)

2. Busque por **Data Flow Livelabs**, clique na Conexão e em seguida clique me **Next**

    ![Driver conexão](.\images\30-next-database.png)

3. Nesta etapa devemos preencher o campo JDBC URL, esta informação está no próprio SQL Endpoint em OCI.

    ![JDBC Url](.\images\31-database-jdbc-url.png)

4. Volte para OCI, na página do SQL Endpoint acesse a Aba **Drivers** e clique em **Show details**.

    ![Retornar OCI](.\images\31-details-jdbc.png)

5. Na janela de Detalhes você encontrará um campo chamado **JDBC URL**, basta copiar essa URL.

    ![JDBC Url](.\images\32-jdbc-url.png)

6. Cole a URL no DBeaver e em seguida clique em **Test Connection**

    ![Testar Conexão](.\images\33-test-connection.png)

7. Você será direcionado para seu navegador padrão para fazer login novamente na Oracle Cloud, para autenticar a conexão com o SQL Endpoint

    ![Login OCI](.\images\35-login-oci.png)

8. Após fazer o login você receberá uma mensagem de sucesso no navegador. Retorne ao DBeaver e veja que o teste da conexão está concluído, basta clique em OK e depois clicar em **Finish** para salvar a configuração.

    ![Mensagem de Sucesso](.\images\36-sucess.png)
    ![Salvar configuração](.\images\37-save-conn.png)


## Tarefa 4: Análise e Exploração de Dados

Após finalizar a configuração do DBeaver com o SQL Endpoint vamos nos conectar a base de dados no Bucket Ouro e iniciar nossa exploração nos dados usando SQL

1. Clique na conexão Data Flow para expandir as opções e fazer uma nova autenticação para a exploração dos dados de fato

    ![Abrir DBeaver](.\images\38-click-conn.png)

> **Nota:**  Você será redirecionado ao navegador para uma nova autenticação. Como será nosso primeiro acesso provavelmente será necessário fazer login mais de uma vez.

2. Você receberá a notificação de sucesso no navegador. Você pode acompanhar o progresso da autenticação na parte inferior do DBeaver também.

    ![Sucesso na Conexão](.\images\36-sucess.png)
    ![Clicar no Database](.\images\38-conn-click.png)

3. Agora você verá um Database chamado Spark no seu DBeaver. Você pode expandir e explorar os objetos presentes.

    ![Databa Spark](.\images\39-spark-db.png)

4. Clique em 'Livelabs\_Ouro' e em seguida, clique na aba Tables.

    ![Navegação DBeaver](.\images\40-tables-navigator.png)

5. Clique na tabela fato\_exportacao, que está dentro de um catálogo chamado livelabs\_ouro, indicando que ela faz parte de um conjunto de tabelas para análise.

    ![Explorar DBeaver](.\images\41-explore-table.png)

Com essa estrutura, é possível realizar uma variedade de análises, como tendências sazonais nas exportações, exportações por estado, valor total das exportações por categoria de produto (usando CO\_NCM\_2\_DIG), e outras análises de dados de comércio exterior.

![Explorar Informações Tabela](.\images\42-explore-information.png)

6. Na barra de tarefas na região superior a direita, abra o SQL para realizar Querys e analisar os dados com maiores detalhes.

    ![Abrir SQL](.\images\43-sql-open.png)

7. Uma consulta SQL foi utilizada para contar o número total de registros na tabela dim\_product. A consulta SELECT COUNT(*) AS Total\_Registros\_Produtos FROM livelabs\_ouro.dim\_product; foi executada, e o resultado apresentado indica que existem 52 registros únicos nesta tabela, sugerindo que o banco de dados contém 52 diferentes tipos de produtos catalogados. A interface exibe o resultado de forma clara e permite ao usuário realizar várias outras operações, como a atualização dos dados, a exportação dos resultados, ou a modificação da consulta.

    ![Query DBeaver](.\images\44-query-dbeaver.png)

```sql
<copy>
SELECT COUNT(*) AS Total_Registros_Produtos
FROM livelabs_ouro.dim_product;
</copy>
```

## Conclusão

Durante este laboratório, foi estabelecida uma conexão entre a camada de ouro e o DBeaver, um ambiente de gerenciamento de banco de dados, usando o SQL Endpoint do Data Flow da OCI. Após configurar o DBeaver com o driver JDBC necessário, realizamos a autenticação e exploramos a estrutura do banco de dados, focando na tabela de exportações para executar consultas SQL. Isso permitiu a análise e interpretação dos dados de exportação armazenados, demonstrando a eficácia do DBeaver para manipular e analisar grandes conjuntos de dados em um ambiente de nuvem.

## Autoria

- **Autores** - Thais Henrique, Heloisa Escobar, Isabelle Anjos
- **Último Update Por/Date** - Isabelle Anjos, Jan/2024