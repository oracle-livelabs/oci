# Manipulação de Dados - Prata

## Introdução

Neste laboratório, estaremos trabalhando com a camada prata do nosso data lake, que é crucial para refinar e transformar os dados brutos importados da camada bronze em um formato mais analítico e pronto para insights. A camada prata serve como um estágio intermédio onde os dados são limpos, deduplicados, padronizados e enriquecidos.

Os principais tratamentos de dados que realizaremos incluem:

- *Leitura dos Arquivos Parquet:* Carregar dados armazenados no formato eficiente Parquet, que já contêm a estrutura e tipos de dados adequados para processamento.

- *Achatamento de JSON:* Converter estruturas JSON complexas e aninhadas em formatos tabulares para facilitar análises e operações de dados.

- *Remoção de Duplicatas:* Identificar e eliminar registros duplicados para garantir a integridade e a confiabilidade dos dados.

- *Padronização de Colunas:* Renomear colunas para remover prefixos desnecessários e padronizar nomes para consistência em todo o conjunto de dados.

- *Tratamento de Valores Nulos:* Preencher ou substituir valores nulos com valores padrão para manter a integridade dos dados durante análises subsequentes.

- *Conversão de Tipos de Dados:* Converter tipos de dados de colunas específicas para formatos apropriados, exceto para colunas que requerem manutenção de formatos numéricos para análises quantitativas.

Cada uma dessas etapas é fundamental para assegurar que os dados estejam prontos para uso em análises mais profundas e para a tomada de decisões baseada em dados na camada ouro, onde o foco está em insights e relatórios


*Tempo estimado para o Lab:* 10 Minutos

### Objetivos

* Processar dados Parquet da camada bronze.
* Aplanar JSON para tabelas.
* Remover duplicatas.
* Padronizar nomes de colunas.
* Tratar valores nulos.
* Converter tipos de dados adequados.
* Salvar como arquivo Delta.

## Tarefa 1: Leitura de arquivo Parquet

Agora vamos avançar para o processamento e análise dos dados que importamos anteriormente, assegurando que eles estejam prontos para uso futuro.

### *Leitura dos Arquivos Parquet no Bucket*

Na etapa anterior, armazenamos nossos DataFrames no formato Parquet. Este script está acessando esses dados de dois locais distintos, correspondendo aos conjuntos de dados originados de arquivos CSV e JSON.

 A opção *`header=True`* indica que a primeira linha dos arquivos Parquet contém os cabeçalhos das colunas, e *`inferSchema=True`* permite que o Spark infira automaticamente o esquema dos dados (tipos de colunas) com base nos dados.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Leitura Parquet Bronze](.\images\1-read-parquet.png)

## Tarefa 2: Achatamento JSON e Padronização de Colunas

### *Função do Achatamento JSON*

---

Este código em Spark contém duas funções definida para lidar com DataFrames que têm colunas estruturadas de forma complexa, como arrays aninhados e estruturas (structs).

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Flatten Function](.\images\2-function-flatten.png)

Em resumo, estas funções estão transformando um DataFrame com colunas complexas e aninhadas em um formato mais simples e tabular, onde cada dado aninhado é trazido para uma coluna própria de nível superior, facilitando a análise e o processamento dos dados.

2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook.

    ![Execução Flatten Function](.\images\3-execute-flatten.png)

### **Porque achatamos o arquivo JSON?**

---

Converter dados aninhados JSON para um formato tabular é útil porque a maioria das ferramentas de análise de dados e bancos de dados trabalham melhor com dados em formato de tabela, onde cada coluna contém valores de um único tipo de dado e cada linha representa um registro único. JSONs aninhados podem ser complexos e difíceis de analisar, pois as estruturas de dados aninhadas não se alinham bem com as estruturas de tabela.

Por exemplo, considere uma parte do JSON que iremos utilizar antes do achatamento:

![Exemplo de arquivo json](.\images\json-print.png)


Este JSON contém dados aninhados sob a chave "data". Após achatá-lo, você terá um formato tabular onde cada campo aninhado se torna uma coluna separada:

| data\_CO\_PAIS | data\_CO\_PAIS\_ISON3 | data\_CO\_PAIS\_ISOA3 | data\_NO\_PAIS       | data\_NO\_PAIS\_ING  | data\_NO\_PAIS\_ESP  |
|---------|---------------|---------------|---------------|--------------|--------------|
| 0       | 898           | ZZZ           | Não Definido  | Not defined  | No definido  |
| 13      | 4             | AFG           | Afeganistão   | Afghanistan  | Afganistan   |
| 15      | 248           | ALA           | Aland         | (empty)      | (empty)      |

### *Padronização de Colunas*

A padronização das colunas em um conjunto de dados é uma prática importante que facilita a manipulação, a análise e a integração dos dados, especialmente quando se está trabalhando com várias fontes de dados ou grandes conjuntos de dados.

Neste código, estamos realizando a renomeação de colunas do DataFrame. Cada coluna que tem o prefixo "data\_" no seu nome terá esse prefixo removido. O código percorre todas as colunas do DataFrame e, para cada uma, cria um novo nome sem o prefixo "data\_".

![Padronização de Colunas](.\images\6-padronized-columns.png)

## Tarefa 3: Retirando Duplicatas 

### *Tratamento de Duplicatas*

Primeiro, contamos o número de linhas e colunas para entender o tamanho original do nosso DataFrame chamado *´df´*. Para isso, usamos *´df.count()´* para contar as linhas e *´len(df.columns)´* para contar as colunas. Em seguida, imprimimos esses números para gerar um registro.

![Número de linhas e colunas](.\images\4-number-lines-original.png)

Depois disso, removemos as linhas duplicadas com o método *´dropDuplicates()´*. Por fim, verificamos novamente a contagem de linhas para identificar quantas foram removidas.

![Tratamento Duplicatas](.\images\5-drop-duplicates.png)

## Tarefa 4: Preenchimento de Valores Nulos

### *Preenchimento de Valores Nulos*

Nesta etapa, estamos verificando individualmente cada coluna para verificar se há valores nulos usando *´df.filter(col(col_name).isNull()).count()´*. Se o resultado for maior que zero, isso significa que há valores nulos na coluna e a coluna é adicionada à lista null\_columns, caso existam, imprimimos o número de valores nulos em cada coluna. Caso não existam, a mensagem *"Não há valores nulos em nenhuma coluna do DataFrame."* será exibida.

![Valores Nulos](.\images\7-null-values.png)

Neste trecho de código, está ocorrendo um processo de tratamento de valores nulos (null) em nosso DataFrame chamado df. Para cada coluna, o código verifica se o tipo de dado é booleano (BooleanType). Se for, todos os valores nulos naquela coluna são substituídos por False. Se o tipo de dado não for booleano, os valores nulos são substituídos por 0.

![Retirar Valores Nulos](.\images\8-replace-null-values.png)

Para verificar a presença de valores nulos em todas as colunas após a aplicação do código que substitui os nulos por valores padrão, você pode realizar uma contagem de nulos por coluna. No Apache Spark, você pode fazer isso usando a função *´agg()´* juntamente com a função *´count()´* para contar explicitamente os nulos em cada coluna.

Após a execução deste código, você deve esperar ver zeros em todas as colunas, indicando que não há mais valores nulos no DataFrame, graças ao preenchimento de nulos que foi realizado anteriormente no código.

![Verificar Valores Nulos](.\images\9-verify-null-values.png)

## Tarefa 5: Conversão do Tipo de Dado e Salvar o Dataframe como Delta

### *Conversão de Dados*

Neste código, estamos realizando a conversão do tipo de dados de várias colunas para string (texto), com exceção de duas colunas específicas.
As colunas KG\_LIQUIDO e VL\_FOB não foram convertidas para o tipo string porque elas contêm informações numéricas essenciais que serão utilizadas em cálculos e análises estatísticas.

![Conversão de Dados](.\images\10-convert-type-variable.png)

### *Salvando o Dataframe como Arquivo Delta*

Após realizar todos os tratamentos necessários no nosso DataFrame, estamos prontos para salvá-lo em um formato otimizado Delta Lake em nosso bucket prata. O arquivo Delta que estamos salvando será a base para as próximas etapas de exploração de dados e para responder a questões importantes do negócio.

![Dataframe Delta Prata](.\images\11-delta-silver.png)

Parabéns, você terminou esse laboratório! 🎉

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a aprimorar a qualidade dos dados na camada prata do data lake, garantindo que eles estejam limpos, padronizados e prontos para análises mais detalhadas. Esses passos são fundamentais para construir um pipeline de dados robusto e confiável, permitindo que a tomada de decisões seja feita com base em informações precisas e confiáveis. 

## Autoria

- **Autores** - Thais Henrique, Heloisa Escobar, Isabelle Anjos
- **Último Update Por/Date** - Isabelle Anjos, Jan/2024