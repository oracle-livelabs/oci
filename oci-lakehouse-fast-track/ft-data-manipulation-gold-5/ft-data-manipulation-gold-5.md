# Manipulação de Dados - Ouro

## Introdução

Neste laboratório focado na *Camada Ouro*, vamos empregar visualizações temporárias no Spark para efetuar manipulações e análises avançadas de dados.

Inicialmente, as visualizações temporárias são criadas para permitir a execução de consultas SQL sobre os DataFrames. Essas visualizações são *não-persistentes* e existem apenas durante a sessão do Spark, servindo como uma ponte entre o processamento de dados em Spark e técnicas de banco de dados relacional.

Ao usar visualizações temporárias, os cientistas e engenheiros de dados podem aplicar consultas SQL complexas e manipulações de dados sem a necessidade de converter DataFrames em tabelas permanentes. Isso fornece um método poderoso e flexível para analisar grandes volumes de dados, aproveitando a facilidade e familiaridade da linguagem SQL.

Uma vez que as manipulações e análises são concluídas no Spark, os dados podem ser preparados e exportados para sistemas de armazenamentos de dados como nosso OCI Object Storage (Data Store) e depois podemos acessar esses dados de diversas formas

*Tempo estimado para o Lab:* 15 Minutos

### Objetivos

* Utilizar visualizações temporárias no Spark para consultas SQL em DataFrames.
* Converter DataFrames em tabelas externas para análise em ferramentas como DBeaver.
* Analisar relações comerciais do Brasil com outros países, focando em produtos, estados e meios de transporte em 2023.
* Executar joins complexos para enriquecer dados e realizar análises detalhadas.

## Tarefa 1: Organização de Tabelas em Star Schema

### *Porque utilizar Star Schema?*

---

O "Star Schema" (Esquema Estrela) é uma forma de organizar bases de dados especialmente útil para armazéns de dados (data warehouses) e análise de dados. Para explicá-lo de forma intuitiva, vamos usar analogias.

Imagine um supermercado. No centro desse supermercado, você tem uma grande seção de produtos (como frutas, legumes, carnes, etc.), que é o coração do estabelecimento. Essa seção central é como a tabela de fatos no Star Schema. A tabela de fatos contém informações essenciais, como vendas, transações ou eventos. No caso do supermercado, seriam as vendas diárias dos produtos.

Agora, ao redor dessa seção central, existem várias outras seções menores - como uma para utensílios domésticos, outra para produtos de limpeza, etc. Estas seções são como as tabelas de dimensões no Star Schema. Cada tabela de dimensão contém detalhes sobre um aspecto particular dos dados na tabela de fatos. Por exemplo, uma tabela de dimensão pode detalhar informações sobre os clientes, outra sobre os produtos, outra sobre o tempo (data e hora), e assim por diante.

O motivo pelo qual se utiliza o Star Schema é sua simplicidade e eficiência. Assim como é mais fácil para você encontrar produtos em um supermercado bem organizado, com seções claramente definidas, também é mais fácil para os analistas de dados extrair e analisar informações de um banco de dados organizado em Star Schema. Este formato facilita a visualização das relações entre diferentes tipos de dados e melhora o desempenho das consultas, o que é crucial para a análise rápida e eficaz de grandes volumes de dados.

![Star Schema](.\images\1-star-schema.png)


Inicialmente, iremos obter as tabelas da camada prata salvas no bucket para prosseguir com nossas análises.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Leitura Parquet Prata](.\images\2-read-parquet-silver.png)

2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

No código abaixo, criamos uma de uma nova coluna denominada *`CO_NCM_2_DIG`*. Esta nova coluna é criada pela extração dos dois primeiros caracteres da coluna *`CO_NCM`* e será utilizada para a união do dataset principal *`df_exp`* e o dataset *`df_ncm`* que apresenta o nome dos produtos que estão codificados.

![Criar Coluna](.\images\3-create-columns.png)

Em seguida, criamos as tabelas através da organização em Star Schema. Inicialmente, temos a tabela fato. Ela contém informações chave como ano, mês, unidade, estado, quantidade estatística, peso líquido, valor FOB e os códigos das tabelas dimensionais. A tabela fato é o núcleo do Star Schema, armazenando dados transacionais ou métricas de desempenho.

![Criar Tabela Fato Exp](.\images\4-exp-fact-table.png)

Então criamos as tabelas dimensionais. Essas tabelas fornecem contexto adicional para os dados na tabela fato.

A primeira tabela dimensional, *`df_pais_dim`*, contém detalhes dos países, como nome e código do país. Esta tabela é criada unindo *`df_exp_ncm`* com *`df_paises_prata`*, selecionando o nome e o código do país e eliminando duplicatas.

![Criar Tabela País Dim](.\images\5-pais-dim-table.png)

A segunda tabela dimensional, *`df_via_dim`*, contém informações sobre as vias, como o nome e código da via. Ela é formada unindo *`df_exp_ncm`* com *`df_via_prata`*, selecionando o nome e o código da via e, novamente, eliminando duplicatas.

![Criar Tabela Via Dim](.\images\6-via-dim-table.png)

A terceira tabela dimensional, *`df_product_dim`*, contém informações sobre as os produtos, como o nome e código dos produtos. Ela é formada unindo *`df_exp_ncm`* com *`df_ncm_prata`*, selecionando o nome e o código do produto e, novamente, eliminando duplicatas.

![Criar Tabela Product Dim](.\images\7-product-dim-table.png)

Posteriormente, salvamos as tabelas Delta para a camada Gold, pois esses dados serão usados para preencher as tabelas externas. Estas tabelas, com suas estruturas definidas, estarão disponíveis no DBeaver para análises futuras.

![Salvar Delta Gold](.\images\8-delta-gold.png)

## Tarefa 2: Leitura Parquet Prata e Criação de Visualização Temporária - SQL

O código abaixo gera uma visualização temporária para cada tabela que iremos utilizar. Essas visualizações temporárias funcionam como tabelas virtuais que permitem a execução de consultas SQL sobre os DataFrames. Elas são úteis para realizar análises de dados e manipulações complexas usando a linguagem SQL, em vez de métodos específicos de DataFrame do Spark.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

![Visualização temporária](.\images\9-temp-view.png)

> Os comandos são prefixados com *`%%spark -c sql`*, indicando que estão sendo executados em um contexto SQL do Apache Spark.

O código em seguida mostra a execução de uma consulta SQL para descrever a estrutura de uma visualização ou DataFrame chamado *`df_exp`*. O comando *`DESCRIBE df_exp`*; é usado para exibir informações sobre as colunas da visualização ou DataFrame, como o nome da coluna (col\_name) e o tipo de dados (data\_type) de cada coluna.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Visualização Estrutura](.\images\10-describe-exp.png)

## Tarefa 3: Criação de Database

No primeiro comando, *`CREATE DATABASE LIVELABS_OURO`*, está sendo criada uma nova base de dados chamada *`LIVELABS_OURO`*. Este é um passo típico no gerenciamento de bancos de dados onde se estabelece um novo contêiner lógico no qual tabelas, vistas, procedimentos armazenados e outros objetos de banco de dados serão armazenados.

No segundo comando, *`USE LIVELABS_OURO`*, o sistema está sendo instruído a utilizar a base de dados *`LIVELABS_OURO`* que acabou de ser criada. Este comando é utilizado para definir o contexto de banco de dados para as operações subsequentes, ou seja, qualquer comando SQL executado após este comando será aplicado dentro da base de dados *`LIVELABS_OURO`*, até que outro comando *`USE`* seja emitido para mudar o contexto para outra base de dados.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Criação de Database](.\images\11-create-database.png)

## Tarefa 4: Criação de Nova Coluna e Join de Tabelas

O código abaixo cria ou atualiza uma visualização temporária chamada *`df_exp_ncm`*. A visualização é definida para incluir todas as colunas do DataFrame original *`df_exp`*, além de uma nova coluna denominada *`CO_NCM_2_DIG`*. Esta nova coluna é criada pela extração dos dois primeiros caracteres da coluna *`CO_NCM`*. Esta nova coluna será utilizada para a união do dataset principal *`df_exp`* e o dataset *`df_ncm`* que apresenta o nome dos produtos que estão codificados.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Criação de Coluna](.\images\12-ncm-substring.png)

O código abaixo é uma instrução para criar ou atualizar uma visualização temporária chamada *`df_exp_enriched`*. Esta visualização é composta pela junção de várias tabelas ou DataFrames: *`df_exp_ncm`*, *`df_paises`*, *`df_via`*, e *`df_ncm`*. A cláusula SELECT DISTINCT é usada para selecionar registros únicos de uma combinação das colunas especificadas de diferentes tabelas.

A seleção obtém o nome do país (*`NO_PAIS`*) de *`df_paises`*, o modo de transporte (*`NO_VIA`*) de *`df_via`*, e o código SH2 (*`NO_SH2_POR`*), renomeado como *`NO_PRODUCT`*, de *`df_ncm`*. Adicionalmente, todas as colunas da visualização *`df_exp_ncm`* são incluídas na seleção (indicado por *`df_exp_ncm.*`*).

As junções entre as tabelas são realizadas da seguinte forma:

- *`df_exp_ncm.CO_PAIS`* é unido com *`df_paises.CO_PAIS`*
- *`df_exp_ncm.CO_VIA`* é unido com *`df_via.CO_VIA`*
- *`df_exp_ncm.CO_NCM_2_DIG`* é unido com *`df_ncm.CO_SH2`*

A visualização resultante *`df_exp_enriched`* proporciona uma visão enriquecida dos dados, combinando informações de múltiplas fontes para análises mais complexas dos dados de exportação.


2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![União de Tabelas](.\images\13-join-tables.png)

Nesta célula, demonstramos o resultado em uma consulta SQL que recupera as primeiras três linhas da visualização *`df_exp_enriched`*. Esta visualização é o produto da união das tabelas ou DataFrames, conforme detalhado em comandos anteriores.

3. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebookS.

    ![Visualizar União](.\images\14-visualize-join.png)

## Tarefa 5: Criação de External Tables

Os códigos abaixo demostram uma série de instruções SQL para criar tabelas externas no metastore e inserir dados nelas a partir de uma visualização enriquecida.

Mas antes vammos entender *`O que é uma tabela externa?`*

Uma tabela externa em arquitetura de lakehouse refere-se a dados armazenados externamente ao sistema de gerenciamento de dados, como em um data lake. Essa abordagem permite a análise de dados heterogêneos sem a necessidade de movê-los para um armazenamento interno, promovendo flexibilidade e eficiência na gestão de grandes volumes de dados.

Este código está configurando variáveis no ambiente Spark para que possam ser utilizadas posteriormente. Ao definir *`bucket_ouro`* e *`namespace`*, você está dizendo ao Spark onde armazenar ou buscar dados e como identificar esse conjunto de dados específico. Pense nisso como definir endereços de armazenamento e etiquetas de identificação que serão usados em consultas SQL dentro do Spark. Isso é necessário para que, quando você executar consultas SQL que referenciam essas configurações, o Spark saiba exatamente onde encontrar os dados que você está pedindo.

![SQL Spark Variáveis](.\images\15-variables-spark-sql.png)

Para a tabela *`Fato_Exportacao`*, é criada uma tabela externa com várias colunas de tipos de dados específicos, como STRING e FLOAT. A localização da tabela é especificada através de um caminho em um bucket, indicando onde os dados da tabela serão armazenados fisicamente.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Tabela Externa Exportação](.\images\16-external-table-fato.png)

O mesmo processo é aplicado para as tabelas *`Dim_Pais`*, *`Dim_Via`* e *`Dim_Product`*, onde cada uma é criada como uma tabela externa com suas respectivas colunas, e em seguida, são populadas com dados da visualização *`df_exp_enriched`*.

> Perceba que estamos utilizando as variáveis *`bucket_ouro`* e *`namespace`*, que foram configuradas na célula anterior.

2. Selecione cada célula e execute-as com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Tabela Externa País](.\images\17-external-table-dim-pais.png)

    ![Tabela Externa Via](.\images\18-external-table-dim-via.png)

    ![Tabela Externa Produto](.\images\19-external-table-dim-product.png)

A criação dessas tabelas externas e a inserção de dados são etapas preparatórias para conectar essas tabelas com a ferramenta de visualização de banco de dados que iremos utilizar, o **DBeaver**. Ao criar tabelas no metastore e fornecer um caminho de localização, os dados podem ser acessados e gerenciados pelo DBeaver, permitindo visualizações, consultas e outras operações de banco de dados.

Parabéns, você terminou esse laboratório! 🎉

Você pode **seguir para o próximo Lab**.

## (OPCIONAL) Tarefa 6: Análise de dados em Matplotlib

Para realizar a análise das questões propostas no laboratório 3, agora contamos com nosso dataset tratado e enriquecido, disponível através da visualização *`df_exp_enriched`*. Utilizaremos a biblioteca *`matplotlib`* para responder às perguntas específicas sobre as relações comerciais entre o Brasil e os outros países.

> **Matplotlib** é uma biblioteca do Python usada para criar gráficos e visualizações de dados. É como uma caixa de ferramentas para desenhar gráficos e diagramas, tornando mais fácil entender e apresentar informações de forma visual.

### **Principais produtos (NCM) exportados e importados no Brasil para os países do Mercosul:**

---

Este código em PySpark filtra as exportações do Brasil para os países do Mercosul, agrupa os dados por código NCM (código de classificação de mercadorias), e conta a frequência de cada código. Em seguida, seleciona os 10 códigos mais frequentes e converte o resultado para um DataFrame do Pandas. O objetivo é preparar esses dados para uma visualização gráfica com Matplotlib, destacando os principais produtos exportados e importados pelo Brasil para o Mercosul.

![Contagem de produtos](.\images\20-count-product.png)

O código seleciona os nomes correspondentes aos 10 principais códigos NCM de exportação e importação do Brasil para o Mercosul, filtra esses nomes a partir de um DataFrame do PySpark, e converte o resultado em um DataFrame do Pandas para facilitar a análise e visualização.

![Seleção 10 produtos](.\images\21-select-products.png)

O gráfico representa a contagem total de exportações e importações para os 10 principais produtos, identificados pelos seus códigos NCM de 2 dígitos, exportados e importados pelo Brasil para os países do Mercosul. O código define o tamanho do gráfico, as cores das barras, os rótulos dos eixos, o título e a rotação dos rótulos no eixo X para uma melhor visualização. Além disso, uma grade é adicionada ao eixo Y para facilitar a leitura dos valores.

![Gráfico Tabela Produtos](.\images\22-product-export-table.png)

### **Estado brasileiro que mais exportou mercadorias nos últimos 6 meses:**

---

O código filtra as exportações do ano de 2023 entre março e agosto, agrupa por estado e calcula o valor total das importações por estado. Os estados são então ordenados pelo valor total de importações em ordem decrescente, e o resultado é convertido para um DataFrame do Pandas para análise e visualização dos estados com o maior volume de importações.

![Exportação e Importação por Região](.\images\23-rg-import-export.png)

Este código usa Matplotlib para criar um gráfico de barras do valor total de importações por estado no Brasil, com base nos dados dos últimos seis meses de 2023. Cada estado é representado no eixo X, com o valor total de importações no eixo Y, e o gráfico é formatado para facilitar a leitura, rótulos rotacionados e uma grade no eixo Y. O gráfico é finalizado e exibido usando o comando %matplot plt.

![Gráfico Exportação e Importação](.\images\24-matplot-region.png)


## Conclusão

Neste laboratório, utilizamos visualizações temporárias no Spark para realizar análises avançadas de dados de exportação e importação do Brasil, utilizando SQL e PySpark para manipular e enriquecer os DataFrames. Implementamos o Star Schema para estruturar as tabelas de forma eficiente, permitindo análises complexas e intuitivas. Criamos tabelas Delta na camada Gold para análise em ferramentas de banco de dados, como o DBeaver, e exploramos relações comerciais com países do Mercosul, identificando os principais produtos negociados e os estados brasileiros com o maior volume de exportações nos últimos seis meses de 2023. Finalmente, visualizamos nossos resultados utilizando a biblioteca Matplotlib, criando gráficos claros e informativos para apresentar nossas descobertas.
## Autoria

- **Autores** - Thais Henrique, Heloisa Escobar, Isabelle Anjos
- **Último Update Por/Date** - Isabelle Anjos, Jan/2024