# Manipulação de Dados - Bronze

## Introdução

Neste laboratório, você irá aprender a manipular um conjunto de dados seguindo o modelo da estrutura medalhão (bronze, prata e ouro) através do Data Flow Studio, que foi configurado anteriormente dentro do OCI Data Science.

Ao final de cada etapa desta arquitetura medalhão, será importante armazenar as tabelas modificadas em buckets. Isso é necessário devido à natureza do processamento em memória do Data Flow, onde os dados são temporários e se perdem após o encerramento da sessão, tornando essencial a persistência dos dados processados em um armazenamento durável como os buckets.

### *Compreendendo o Processamento e Armazenamento de Dados no Data Flow*

---

O funcionamento do Data Flow pode ser entendido de forma intuitiva como um processo que ocorre em uma "memória" temporária. Aqui está uma explicação simplificada:

**Processamento Temporário:**
   - Quando você inicia um Data Flow, ele cria um cluster temporário na nuvem.
   - Neste cluster, os dados são carregados, processados e manipulados conforme necessário. 
   - Pense nisso como um espaço de trabalho temporário onde seus dados são trazidos para análise e transformação.

**Natureza Efêmera dos Dados no Cluster:**
   - Importante ressaltar que esses dados existem apenas enquanto o cluster está ativo.
   - Assim que você termina sua sessão e o cluster é fechado, todos os dados processados nesse ambiente temporário são perdidos.
   - Isso significa que qualquer processamento ou resultado obtido durante a sessão precisa ser armazenado de forma permanente em outro lugar, caso contrário, será perdido.

**Persistência dos Dados em Buckets:**
   - Para preservar os resultados do seu trabalho no Data Flow, você precisa salvar os dados processados em um local de armazenamento permanente.
   - No contexto do OCI Data Science, isso geralmente é feito salvando os dados em "buckets", que são essencialmente espaços de armazenamento na nuvem.
   - Ao salvar os dados em um bucket, você garante que eles estarão disponíveis para uso futuro, mesmo após o encerramento da sessão do Data Flow.

> Em resumo, o Data Flow permite processar dados de forma poderosa e flexível em um ambiente temporário. No entanto, para reter os resultados desse processamento, é crucial salvar os dados em um local permanente, como um bucket, antes de encerrar a sessão do cluster. Isso garante que você possa acessar e utilizar esses dados processados para análises futuras ou para outras necessidades do projeto.


*Tempo estimado para o Lab:* 10 Minutos

### Objetivos


* Compreender a origem do conjunto de dados e análises que serão realizadas.

* Utilizar comandos interativos para executar Spark em notebooks.

* Configuração da autenticação e das variáveis de ambiente para acessar recursos na OCI.

* Carregamento de dados diretamente de um bucket da OCI para análise.

* Armazenamento inicial de dados processados no formato otimizado Delta.

## Visão Geral do Conjunto de Dados

O conjunto de dados apresentado é originário do Governo Federal Brasileiro e fornece informações detalhadas usadas na construção da balança comercial do Brasil. 

O conjunto inclui dados do sistema *Comex Stat* e está organizado de acordo com a *Nomenclatura Comum do Mercosul (NCM)* ou por municípios de exportadores/importadores. Disponíveis em formato CSV e separados por ponto e vírgula (;), os dados que serão analisados abrangem o período de *2023* e incluem informações como ano, mês, código NCM, unidade estatística, país de origem/destino, UF de origem/destino, rota de transporte, órgão responsável pelo desembaraço (URF), quantidade estatística, peso líquido em quilogramas e valor em dólares FOB (Free on Board). 

O dicionário de dados está disponibilizado abaixo.

| Campo                            | Descrição |
|----------------------------------|-----------|
| **CO_ANO**                       | Ano (1997 a 2021) |
| **CO_MES**                       | Códigos de mês (1: janeiro, 12: dezembro) |
| **CO_NCM**                       | Código da Nomenclatura Comum do Mercosul - Utilizado para controlar e identificar mercadorias comercializadas no Brasil e nos demais países do Mercosul (cada NCM representa um produto diferente) |
| **Países do Mercosul**           | O Mercado Comum do Sul, conhecido pelas abreviaturas Mercosul (português) e Mercosur (espanhol), é um bloco comercial sul-americano estabelecido pelo Tratado de Assunção em 1991 e pelo Protocolo de Ouro Preto em 1994, com membros plenos Argentina, Brasil, Paraguai e Uruguai. Fonte: Wikipédia |
| **CO_UNID**                      | Código da Unidade de Medida Estatística, uma unidade de medida padrão para cada NCM, incluindo valores como quilograma, metro, litro, pares, tonelada, entre outros. |
| **CO_PAIS**                      | Código do nome do país com o qual foi realizada a operação comercial (importação ou exportação) |
| **SG\_UF\_NCM**                    | Código da Unidade Federativa (estado) de origem (exportação) ou destino (importação) da mercadoria. |
| **CO_VIA**                       | Código para identificar o meio de transporte utilizado (aéreo, marítimo, rodoviário, ferroviário, etc.). Na exportação, refere-se ao meio de transporte da mercadoria para o exterior; na importação, ao meio de acesso da mercadoria ao território nacional. |
| **CO_URF**                       | Código do órgão responsável pelos trâmites de desembaraço aduaneiro de mercadorias importadas/exportadas |
| **QT_ESTAT**                     | Unidade estatística de cada produto conforme discriminado por NCM, variando entre quilogramas líquidos, número de unidades, pares, dezenas, mil e toneladas. A tabela “NCM_UNIDADE” relaciona cada NCM à sua unidade estatística correspondente. É importante não somar quantidades estatísticas de NCMs com unidades diferentes. |
| **KG_NET**                       | Peso líquido da mercadoria em quilogramas, desconsiderando embalagens ou transportes adicionais, disponível mesmo para produtos com unidades estatísticas diferentes de quilogramas. As informações fornecidas nas operações de comércio exterior são de responsabilidade dos operadores. |
| **VL_FOB**                       | Valor da mercadoria em dólares americanos (USD $) no Incoterm FOB (Free on Board), onde o vendedor é responsável pelo envio da mercadoria e o comprador pelos custos de frete, seguro e outros custos pós-embarque. |

### *Análise de Dados*

---

Durante o laboratório, buscaremos analisar as seguintes questões relacionadas às relações comerciais entre o Brasil e os países do Mercosul:

- *Principais produtos (NCM) exportados e importados no Brasil para os países do Mercosul:* Identificaremos quais foram os produtos mais exportados ou importados pelo Brasil para os membros do Mercosul, utilizando o código NCM como referência para classificar e agrupar os produtos.

- *Estado brasileiro que mais exportou ou importou mercadorias nos últimos 6 meses:* Analisaremos os dados para determinar qual estado brasileiro foi o maior importador ou exportador de mercadorias nos 6 meses mais recentes disponíveis nos dados.


## Tarefa 1: Comando Spark Magic

Para interagirmos com nosso cluster Spark do OCI Data Flow devemos sempre utilizar o magic command *`%%spark`* na célula antes do comando que queremos executar no cluster.

Quando você insere o magic command *`%%spark`* em uma célula do notebook e executa a célula, o código dentro dela não é executado localmente no seu ambiente Jupyter. Em vez disso, o comando indica que o código deve ser enviado para processamento em um ambiente remoto, que no caso é o Data Flow Session.

1. Se você executar o comando como indicado na imagem abaixo, ele será executado localmente no Jupyter Notebook.

   ![Spark Comandos](.\images\1-print-local.png)

2. Agora se você executar o comando como indicado nesta outra imagem abaixo, ele será executado no Cluster Spark do OCI Data Flow.

   ![Spark Comandos](.\images\2-print-flow.png)


Portanto, o comando *`%%spark`* funciona como uma ponte entre o seu notebook Jupyter e o cluster Spark remoto do Data Flow. Ele permite que você escreva código Spark no notebook e tenha esse código executado no cluster Spark.  Uma vez que o código é processado no cluster Spark, os resultados são então enviados de volta e exibidos no seu ambiente OCI Data Science.



## Tarefa 2: Autenticação e Criação de Variáveis do Ambiente

### *Autenticação Spark*

---

Conforme o código no laboratório anterior, a autenticação é realizada para obter automaticamente as variáveis que serão utilizadas durante o processo. Isso é feito utilizando o Resource Principal, um método de autenticação que permite que os serviços da Oracle Cloud Infrastructure (OCI) autentiquem chamadas a outros serviços OCI sem a necessidade de gerenciar credenciais explícitas.

Além de preparar o ambiente para trabalhar com Apache Spark na Oracle Cloud Infrastructure (OCI) e configura a autenticação necessária para acessar outros serviços da OCI, como buckets do Object Storage. Ele também garante que versões mais recentes e seguras de bibliotecas de criptografia sejam utilizadas.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Autenticação Spark](.\images\2-authentication-spark.png)

### *Criação de Variáveis do Ambiente*

---

O código abaixo tem como objetivo buscar o ID do compartimento na Oracle Cloud Infrastructure (OCI). No entanto, ao contrário do que foi feito no laboratório 2, onde uma variável de ambiente disponível no ambiente do Data Science da OCI foi utilizada para obter essa informação, neste contexto atual não temos acesso a essa variável de ambiente para realizar a mesma operação. Portanto, o código precisa de um método alternativo para obter o ID do compartimento, que neste caso é feito através da listagem de todos os compartimentos acessíveis e buscando Data Flows em cada um para encontrar o ID desejado.

2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Criação Variáveis Identificadores](.\images\3-compartment-id.png)

> **Porque devo declarar novamente as variáveis?** Como mencionado anteriormente, existe uma distinção importante entre as células executadas com `%%spark` e aquelas sem ele no nosso ambiente. As células com `%%spark` são processadas dentro do Data Flow Studio, ao passo que as células sem ele são executadas no OCI Data Science. Essa é a razão pela qual precisamos declarar a informação do namespace do bucket mais uma vez – pois nosso contexto mudou do Data Science para o Data Flow Studio, onde a informação será utilizada novamente.

Em seguida, executaremos o código abaixo, que apresenta como objetivo buscar o namespace do Object Storage da OCI e identificar os nomes específicos dos buckets categorizados como 'bronze', 'prata', 'ouro' e 'metastore'. Ele autentica usando Resource Principals, obtém o namespace, lista os buckets no compartimento designado e filtra essa lista para obter os nomes dos buckets de acordo com os critérios definidos.

Os buckets obtidos serão utilizados para armazenamento dos dados na arquitetura medalhão em cada etapa durante o processo.

3. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Spark Variáveis](.\images\4-spark-variables.png)

## Tarefa 3: Importando Dados do Bucket 

Neste passo, estamos definindo a variável *`csv_file_path`* para armazenar o caminho do arquivo CSV e a variável *`json_file_path_paises` para o caminho do arquivo JSON que queremos importar. 

Estamos buscando os arquivo em um bucket BRONZE, chamado *`oci://+bucket_bronze+@+namespace+`*, cujas variáveis foram definidas acima. Em seguida, estamos utilizando o Spark para ler o arquivo CSV e em seguida, JSON. 

1. Selecione A célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Importanto Bucket CSV](.\images\5-import-csv.png)

O primeiro arquivo, identificado como *`EXPORTACAO_BRASIL_LIVELABS`* será nosso dataset principal, com as informações listadas em "Visão Geral do Conjunto de Dados", primeira etapa deste laboratório. O segundo arquivo *`CODIGO_PAISES_LIVELABS.json`* contém informações sobre códigos de países, incluindo os nomes dos países codificados numericamente em nosso dataset original. O terceiro e quarto arquivos, *`CODIGO_NCM.xlsx`* e *`CODIGO_VIA.csv`*, contém códigos NCM, que são usados para classificar mercadorias em categorias para fins de comércio e tarifação, e o nome das vias de exportação (marítima, fluvial, etc.), informação esta que está codificada no dataset original.

> O comando *`printSchema()`* é usado para detalhar as colunas, tipos de dados e se as colunas aceitam valores nulos em cada DataFrame. 

2. Selecione cada célula e execute-as com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Importanto Bucket JSON Código Paises](.\images\6-country-code.png)

   ![Importanto Bucket CSV VIA](.\images\7-import-csv-via.png)

   ![Importanto Bucket CSV NCM](.\images\8-ncm-code.png)

O primeiro arquivo, identificado como *`CODIGO_PAISES_LIVELABS.json`*, contém informações sobre códigos de países, incluindo os nomes dos países codificados numericamente em nosso dataframe original. O segundo arquivo, *`CODIGO_NCM.xlsx`*, contém códigos NCM, que são usados para classificar mercadorias em categorias para fins de comércio e tarifação.

Na camada ouro, planejamos unir esses conjuntos de dados ao nosso dataset principal. Essa união nos permitirá realizar análises mais ricas, correlacionando os códigos numéricos dos países e os códigos de classificação de mercadorias (NCM) com as informações correspondentes no dataset principal. 

### *A busca de arquivos no Object Storage (Bucket)*

---

Na estrutura *`oci://"+bucket_bronze+"@"+namespace+"/EXPORTACAO_BRASIL_LIVELABS.csv`*, podemos identificar os seguintes componentes:

**Nome do Bucket**: Conteúdo da variável "+bucket_bronze+"

Isso representa o nome do bucket de armazenamento.

**Namespace**: Conteúdo da variável "+namespace+"

O namespace é um identificador único do OCI Object Storage, cada conta na Oracle Cloud recebe o seu.

**Nome do Arquivo**: BRASIL\_EXPORTACAO\_LIVELABS.csv

Este é o nome do arquivo específico localizado dentro do bucket bronze. No contexto desse código, é o arquivo CSV que está sendo lido e processado pelo Spark.


## Tarefa 4: Salvando um DataFrame como um Arquivo Delta

Neste código, estamos utilizando o Apache Spark para salvar um DataFrame derivado de um arquivo CSV e outros de arquivos JSON no formato *Delta Lake* em um bucket, usando caminhos específicos para cada tipo de dado.

   1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

   ![Save Delta Bronze](.\images\9-save-delta-bronze.png)

### *O que é um Arquivo Delta?*

---

Pense num arquivo Delta Lake como um álbum de fotos digital onde você pode facilmente adicionar, editar ou deletar fotos. Se você cometer um erro, é fácil desfazer a ação e recuperar a foto como estava antes. Assim como um álbum mantém um registro das suas fotos, o Delta Lake mantém um registro das alterações nos seus dados, tornando o acesso e a gestão deles simples e seguros.

Desta forma, corresponde a um tipo de formato de armazenamento que oferece várias vantagens para o processamento e análise de grandes volumes de dados. Ele é construído em cima do Apache Spark e otimiza operações de leitura e gravação, mantendo a integridade dos dados através de transações ACID, que são mecanismos usados para garantir que todas as operações de dados sejam realizadas com segurança e sem erros.

Salvar dados neste formato é útil porque permite:

- *Gerenciamento de Metadados:* Facilita o rastreamento das alterações feitas nos dados.
- *Escala:* Lida eficientemente com grandes quantidades de dados.
- *Desempenho:* Melhora a velocidade de leitura e escrita dos dados.
- *Confiabilidade:* Garante que os dados não sejam corrompidos, mesmo com várias operações simultâneas.

Parabéns, você terminou esse laboratório! 🎉

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão, você aprendeu a manipular dados nas camadas bronze, prata e ouro de um data lake na Oracle Cloud Infrastructure (OCI), começando pela importação de conjuntos de dados brutos do Object Storage, passando pela autenticação segura com Resource Principals, até o refinamento e armazenamento de dados em formatos otimizados para análises aprofundadas.

## Autoria

- **Autores** - Thais Henrique, Heloisa Escobar, Isabelle Anjos
- **Último Update Por/Date** - Isabelle Anjos, Jan/2024