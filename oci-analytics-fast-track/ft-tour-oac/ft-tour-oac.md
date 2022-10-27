# Tour pelo OAC

## Introdução

Neste Lab você vai aprender a navegar pela interface do Oracle Analytics Cloud

***Overview***

O Oracle Analytics Cloud é um serviço de nuvem pública escalável e seguro que fornece um conjunto completo de recursos para explorar e executar análises colaborativas para você, seu grupo de trabalho e sua empresa. Com o Oracle Analytics Cloud, você também tem recursos flexíveis de gerenciamento de serviços, incluindo configuração rápida, dimensionamento e patches fáceis.

*Tempo estimado para o Lab:* NN Minutos

### Objetivos

Neste Laboratório você vai:
* Explorar os recursos disponíveis de forma nativa dentro do OAC (Oracle Analytics Cloud)



## Task 1: Página Inicial

Assim que logar com seu ID de Usuário e Senha, você será direcionado para a página inicial da ferramenta. Esta tela inicial é a **HOME**, sempre que quiser retornar à ela:

1.	Clique no Menu Hamburguer no lado superior esquerdo da tela principal, 

![menu do OAC "Hamburguer"](.\images\Menu_Hamburguer.png)   

Assim que a barra lateral se expandir, você verá o ícone correspondente a **HOME**, selecione-o.

![menu do OAC "Hamburguer"](.\images\Home_Analytics.png) 

2.	Para explorar os projetos acessíveis, escolha Catálogo.

![menu do OAC "Catálogo"](.\images\Catalogo_Analytics.png)  

3.	Preencha os campo necessários para a criação do seu Autonomous Database conforme mostrado abaixo:

![preencha os campos do Autonomous Database](./images/autonomous-database-type-3.png)

* Display Name: **ADW_FT**
* Database name: **DBADWFT**
* Choose a workload type : Para este Workshop, por favor selecione **Data Warehouse**
* Choose a deployment type: **Shared Infrastructure**

![configure o Autonomous Database](./images/autonomous-database-config-4.png)

* Choose database version: **19c**
* OCPU count: **1**
* Storage (TB): **1**

*Observação: Você pode escolher entre 1 e 128 OCPUs e 1 e 128 TBs para armazenamento.* 

![configure as credenciais e tipo de acesso](./images/autonomous-database-credentials-5.png)

* Create administrator credentials: **Crie um password para o usuário ADMIN**
* Choose network access: **Secure access from everywhere**

> **Note:** Password must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number. The password cannot contain the double quote (") character or the username "admin".*

![escolha a licença e clique em "Create Autonomous Database"](./images/autonomous-database-license-6.png)

* Choose License and Oracle Database Edition: **Bring Your Own License (BYOL)**
* Choose an Oracle Database Edition: **Oracle Database Enterprise Edition (EE)**
* Agora finalize a criação clicando no  botão **"Create Autonomous Database"**

Agora basta aguardar alguns minutos e em seguida você verá a tela:

![veja o banco de dados disponível](./images/autonomous-database-available-7.png)

*Seu Banco de Dado Autonomous foi provisionado com sucesso!*

## Task 2: Usar os recursos nativos do Autonomous Database

A maioria das operações do banco de dados autônomo podem ser feitas nos botões superiores principais da tela:

![veja as operações que podem ser utilizadas no Autonomous Database](./images/autonomous-database-ops-8.png)

Esta nova versão do Autonomous, traz uma versão já carregada do SQL Developer que pode ser acessada a partir de:

1.	Clique no botão **“Database Actions”**. Você será redirecionado para uma nova aba

![Clque em Database Actions](./images/autonomous-database-console-9.png)

2. Faça login no banco com o usuário ADMIN e a senha que você criou na Task 1

![Clique em Development e em seguida em Database Actions](./images/autonomous-database-login-11.png)

3. Selecione a opção "Catalog"
   
![Clique em Development e em seguida em Database Actions](./images/autonomous-database-catalog-12.png)

Use a página Catalog para obter informações sobre as entidades disponíveis no Oracle Autonomous Database. Você pode ver os dados em uma entidade, as fontes desses dados, os objetos derivados da entidade e o impacto nos objetos derivados das alterações nas fontes.

4. Selecione o schema SH digitando: **owner=SH AND type=TABLE** e selecione a tabela **SALES**

*Atenação: Verifique se a opção **All Local Objects** está selecionada*

![Clique em Development e em seguida em Database Actions](./images/autonomous-database-sales-13.png)

5. Explore os campos de visualização, linhagem, impacto e estatísticas. Quando finalizar a exploração clique no botão **Close**

![ADW - Catalog](./images/autonomous-database-explore-14.png)

## Task 3: Scaling de OCPUs e Monitoramento de SQL Statements

1. Volte para a tela principal clicando no logo Oracle no topo da página e em seguida selecione **SQL**

![SQL](./images/autonomous-database-sql-15.png)

Execute queries e scripts, e crie objetos no Banco de dados através do SQL Worksheet

2. Seleciona o schema SH, copie o comando abaixo e cole no SQL Worksheet e em seguida clique no botão 'Run Script'

```
select count(*) from dba_tables, dba_source;
select a.cust_first_name, count(a.country_id), sum(b.amount_sold) from sh.sales b, sh.customers a, sh.products where a.cust_id = b.cust_id group by a.cust_first_name;
```

![SQL](./images/autonomous-database-sql-16.png)


3.  Volte para a tela de 'Autonomous Database Details', clique no botão **More Actions** e selecione **Managing Scaling**

![clique em "Manage Scaling"](./images/autonomous-database-scaling-17.png)

4. Aumente para **2** OCPUs e clique no botão **Apply**

![clique em "Apply"](./images/autonomous-database-apply-18.png)

5. Após confirmar o scale a figura ADW na console mostrará frase **"SCALING IN PROGRESS"** e o banco continuará online.

![Scaling em progresso](./images/autonomous-database-progress-19.png)

*Observação: Volte a tela do SQL e verifique se as querys continuam em execução, caso queira execute um novo select.*
```
select count(*) from (select * from dba_source, v$sqltext);
```

5. Volte para a tela principal clicando no logo Oracle no topo da página e em seguida selecione **PERFORMANCE HUB**

![clique em "Performance Hub"](./images/autonomous-database-performance-20.png)

Use a ferramenta Performance Hub para analisar e ajustar o desempenho de um Autonomous Database selecionado.
Com esta ferramenta, você pode visualizar dados de desempenho históricos e em tempo real. Ao visualizar dados históricos no Performance Hub, você está visualizando estatísticas coletadas como parte dos instantâneos de hora em hora de seu banco de dados.

6.  Selecione **SQL Monitoring** e você verá a lista dos SQl Statements

![clique em "SQL Monitoring"](./images/autonomous-database-monitoring-21.png)


7. Clique no **SQL ID** da Query que você quer explorar:

![clique no SQL ID](./images/autonomous-database-id-22.png)

8. Explore as outras abas como SQL Text, Atividades e Métricas. Podemos obter informações muito importantes como CPU utilizada ou quanto de memória estamos utilizando para determinada execução.

![explore as outras abas](./images/autonomous-database-explore-23.png)
![explore as outras abas](./images/autonomous-database-explore-24.png)


Outra maneira de consultar as atividades do banco de dados é durante a execução de comandos, você pode mudar para a visualização de atividades em Database Dashboard dentro de Database Actions na console do OCI e acompanhar a atividade do banco de dados.

9.  Volte para a tela de 'Autonomous Database Details' e clique no botão **Database Actions**

![clique em "Database Actions"](./images/autonomous-database-console-9.png)

10.  Selecione **Database Dashboard**

![selecione "Database Dashboard"](./images/autonomous-database-service-25.png) 

11.  Selecione **Monitor**

![selecione "Monitor"](./images/autonomous-database-activity-26.png) 


## Conclusão

Nesta sessão você aprendeu a provisionar um Oracle Autonomous Data Warehouse. Explorou a ferramenta de Catalog nativa desse Autonomous Database e  aprendeu a monitorar o desempenho e os SQL statements que são executados no banco de dados.

## Autoria

- **Autores** - Arthur Vianna, Luiz de Oliveira, Thais Henrique
- **Último Update Por/Data** - Arthur Vianna, Jun/2022