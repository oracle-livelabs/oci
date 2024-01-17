# Configuração do Data Flow Studio no OCI Data Science

## Introdução

Neste laboratório, você irá aprender como configurar uma sessão no Data Flow Studio, um componente integrado ao OCI Data Science. 

O ambiente que você estará configurando e utilizando é a OCI Data Flow Session. Esta é a plataforma onde você processará os dados, aproveitando os recursos interativos para desenvolver, testar e otimizar fluxos de dados em tempo real.

Ao final deste laboratório, você terá desenvolvido habilidades essenciais para efetivamente criar e gerenciar fluxos de dados, permitindo-lhe trabalhar com mais eficiência em projetos de análise de dados e ciência de dados.


### *O que é o Data Flow?*

---

O OCI Data Flow é um serviço totalmente gerenciado na Oracle Cloud Infrastructure (OCI) destinado a executar scripts Apache Spark sem a necessidade de gerenciar infraestrutura ou instalar software. Este serviço é especialmente vantajoso para empresas e desenvolvedores que necessitam processar grandes volumes de dados de forma eficiente. Com o OCI Data Flow, os usuários podem criar aplicações em Java, Scala, Python ou SQL, que são posteriormente executadas em ambientes Apache Spark. Ele é ideal para tarefas como processamento de dados em lote, operações de ETL (Extract, Transform, Load), e análise de dados complexos. A principal vantagem do OCI Data Flow é sua escalabilidade e facilidade de uso, permitindo aos usuários concentrarem-se na escrita de seus scripts sem se preocuparem com o gerenciamento da infraestrutura subjacente.

### *O que é o Data Flow Studio?*

---

Diferentemente do OCI Data Flow, o Data Flow Studio é uma extensão ou uma camada adicional que oferece um ambiente a partir de uma **ferramenta integrada ao OCI Data Science**, com um conjunto de ferramentas que permite aos usuários aproveitar as funcionalidades de processamento de dados em conjunto com outras ferramentas de ciência de dados. Além disso, o Data Flow Studio é ideal para realizar operações de ETL (Extração, Transformação e Carregamento) através de código.

A capacidade de realizar ETL por meio de código proporciona uma grande flexibilidade, permitindo a criação de processos personalizados para extrair dados de diversas fontes, transformá-los de acordo com as necessidades específicas e, em seguida, carregá-los para destinos apropriados. 

| OCI Data Flow                                    | OCI Data Flow Studio                              |
| ------------------------------------------------- | ------------------------------------------------- |
| - Serviço totalmente gerenciado para executar scripts Apache Spark. | - Extensão ou camada adicional ao OCI Data Flow. |
| - Não requer infraestrutura para gerenciar nem instalar software. | - Oferece um ambiente de desenvolvimento integrado (IDE) na nuvem. |
| - Escalável, permite o processamento de grandes volumes de dados. | - Permite construir, testar e executar aplicações Spark. |
| - Suporta aplicações em Java, Scala, Python ou SQL no Apache Spark. | - Interface gráfica para interação intuitiva com dados e scripts. |
| - Ideal para processamento de dados em lote, ETL, e análise de dados. | - Adequado para uma abordagem mais visual e interativa no desenvolvimento de pipelines de dados. |
|                                                   | - Ferramenta integrada ao OCI Data Science.       |



### *Porque utilizar o Data Flow Studio?*

--- 
O Data Flow Studio é uma ferramenta altamente especializada para tarefas que envolvem **processamento de dados em grande escala**, fornecendo um ambiente otimizado com recursos de escalabilidade automáticos. Isso permite lidar com picos de demanda sem a necessidade de gerenciar a infraestrutura manualmente. Sua interface intuitiva e ferramentas especializadas são ideais para manipular grandes volumes de dados, tornando o processo mais simples e eficiente. 
 
Além disso, o Data Flow Studio proporciona um ambiente integrado e interativo, essencial para o desenvolvimento e teste de fluxos de dados em tempo real. Essa característica é crucial para permitir a rápida iteração e ajuste dos processos de dados.

> *Desta forma, corresponde a escolha ideal se o foco principal do seu projeto está no processamento e manipulação eficientes de grandes volumes de dados. Ele oferece um ambiente específico e otimizado para essa finalidade.*

### *Observação:*

---

Quando você iniciar o notebook *`LiveLabs.ipynb`*, encontrará no sumário uma relação completa dos assuntos que serão explorados durante os laboratórios 2 e 3.

> Para executar o código de qualquer célula no notebook, primeiro selecione a célula que deseja executar. Em seguida, você pode pressionar *`SHIFT + ENTER`* no teclado ou clicar no botão de execução (ícone de 'play') no notebook para realizar a ação.  ![Execução Notebook](.\images\0-execution.png)

*Tempo estimado para o Lab:* 10 Minutos

### Objetivos

* Compreender a estrutura e funcionalidades de um notebook Jupyter.
* Aprender os atalhos de teclado e comandos específicos do ambiente OCI Data Science.
* Dominar o processo de autenticação usando o Oracle Accelerated Data Science SDK.
* Entender como configurar e utilizar variáveis de ambiente importantes no notebook.
* Aprender a usar comandos mágicos para interação com o Apache Spark.
* Desenvolver competências para criar, monitorar e verificar o status de sessões do Spark.

## Aprendendo sobre Notebook Jupyter e comandos OCI Data Science

### *Como funciona um Notebook Jupyter:*

---

No último laboratório, fizemos a importação de um notebook Jupyter para utilizá-lo no ambiente Data Science. Mas, você pode se perguntar, **o que exatamente é um notebook Jupyter e como ele funciona?**

Um notebook Jupyter é uma ferramenta interativa muito popular entre cientistas de dados, engenheiros de dados e analistas. Ele combina a execução de código com a adição de notas, gráficos e outros elementos visuais, tudo em um único documento. Vejamos como funciona:

### **Células:**

O coração de um notebook Jupyter são as "células", que são blocos onde você pode escrever código ou texto. Desta forma, existem dois tipos principais de células:


- *Células de Código:* Onde você escreve e executa códigos em linguagens como Python, R, Pyspark, etc. Quando você executa uma célula de código (geralmente usando o comando Shift + Enter), o notebook processa o código e exibe o resultado logo abaixo da célula.

- *Células de Markdown:* Usadas para adicionar texto explicativo, imagens, links e formatação, como títulos e listas, para documentar o que o código está fazendo. Markdown é uma linguagem de marcação leve que permite formatações básicas (como negrito, itálico) e avançadas (como listas, tabelas e código HTML).Essas células não são "executadas" como as células de código, mas sim "renderizadas" para exibir o texto formatado.

### **Execução Interativa**
O que torna os notebooks Jupyter atraentes é a capacidade de executar o código de maneira interativa. Você pode modificar o código, executá-lo e ver os resultados imediatamente. As células podem ser executadas em qualquer ordem, o que permite testar pequenos trechos de código rapidamente sem ter que executar todo o notebook.

### **Versatilidade**
Os notebooks são ideais para uma variedade de tarefas, incluindo análise de dados, visualização, modelagem estatística e machine learning, bem como para criar tutoriais e guias educacionais.

### **Compartilhamento e Colaboração**
Os notebooks podem ser facilmente compartilhados como arquivos (geralmente com a extensão .ipynb) e podem ser visualizados através de plataformas como o GitHub ou executados em ambientes como o OCI Data Science.

<br>

### *Comandos OCI Data Science*

---

Segue uma relação de comandos disponíveis no ambiente do OCI Data Science. Para usar esses atalhos, você precisa estar em modo de comando (pressionando Esc antes do atalho):

| Atalho de Teclado               | Ação                                       |
|---------------------------------|--------------------------------------------|
| `Shift + Enter`                 | Executar a célula atual e ir para a próxima|
| `Ctrl + Enter`                  | Executar a célula atual                    |
| `Alt + Enter`                   | Executar a célula atual e inserir uma nova |
| `Esc` e depois `A`              | Inserir célula acima                       |
| `Esc` e depois `B`              | Inserir célula abaixo                      |
| `Esc` e depois `D`, `D`         | Excluir célula atual                       |
| `Esc` e depois `M`              | Mudar célula atual para tipo Markdown      |
| `Esc` e depois `Y`              | Mudar célula atual para tipo Código        |
| `Esc` e depois `L`              | Alternar números de linha                  |
| `Esc` e depois `C`              | Copiar célula                              |
| `Esc` e depois `X`              | Cortar célula                              |
| `Esc` e depois `V`              | Colar célula abaixo                        |
| `Esc` e depois `I`, `I`         | Interromper a execução da célula           |


## Tarefa 1: Autenticação

Para garantir um processo de análise de dados suave e eficiente no Data Flow Studio, é essencial estabelecer corretamente os métodos de autenticação. Nesta seção focaremos no *Tópico 1*, que é dedicado a este processo.

O Oracle Accelerated Data Science SDK (ADS) controla o mecanismo de autenticação com o cluster Spark em uma Sessão do OCI Data Flow. Para configurar a autenticação, utilizamos *`ads.set_auth("resource_principal")`*

O parâmetro *`resource_principal`* indica que está sendo utilizado um método de autenticação específico, associado a recursos e políticas de segurança dentro da infraestrutura da Oracle Cloud. Assim, o código está preparando o ambiente para que o usuário possa interagir de forma segura com o Spark, garantindo que todas as operações realizadas estejam autenticadas e autorizadas de acordo com as configurações do OCI Data Science.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Realizando Autenticação](.\images\1-authentication.png)

O código abaixo realiza a autenticação para usar serviços da Oracle Cloud Infrastructure, especialmente o Data Flow Studio. Ele importa bibliotecas necessárias, incluindo o SDK da OCI, e configura um assinante de princípios de recursos, que permite fazer solicitações autenticadas aos serviços da OCI sem gerenciar manualmente as credenciais.

2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Realizando Autenticação](.\images\2-authentication-df.png)


## Tarefa 2: Criação de Variáveis

Este código está configurando algumas variáveis importantes para serem utilizadas durante a *criação da sessão Spark*. 

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Variáveies Notebook](.\images\2-variables.png)

### *Informação sobre o compartment ID*

Primeiramente, ele importa a biblioteca *`os`*, que permite trabalhar com variáveis de ambiente do sistema operacional. Com isso, ele obtém o valor da variável de ambiente *`NB_SESSION_COMPARTMENT_OCID`*, que é usada para identificar o compartimento específico na Oracle Cloud Infrastructure (OCI) onde o notebook está armazenado. Esse valor é então armazenado na variável *`compartment_id`*.

### *Informação sobre o bucket namespace*

Esse código configura um cliente para acessar o serviço de armazenamento de objetos da Oracle Cloud Infrastructure (OCI) e obtém o namespace do bucket de armazenamento. O cliente é inicializado com configurações padrão e autenticação baseada no assinante configurado anteriormente. Em seguida, ele chama o método para obter o *namespace do bucket*, que é um identificador único usado na OCI para organizar e separar recursos de armazenamento.

### *Informação sobre o nome dos buckets*

O código lista todos os buckets em um namespace e compartimento específicos da Oracle Cloud Infrastructure. Em seguida, ele procura e armazena os nomes dos primeiros buckets encontrados que contêm 'logs' e 'conda' em seus nomes, respectivamente, em duas variáveis diferentes.

### *Informação sobre o Metastore ID*

Esta etapa do código configura um cliente para o Data Catalog da OCI, lista os metastores em um compartimento especificado e extrai o ID do primeiro metastore encontrado, armazenando-o em uma variável.

## Tarefa 3: Data Flow Spark Magic

### *Apache Spark e Data Flow*

---

O Apache Spark é uma plataforma open source (código aberto) para processamento de grandes volumes de dados. Uma das suas principais vantagens é ser livremente acessível e modificável por qualquer pessoa, o que fomenta uma comunidade ativa de desenvolvedores e usuários que contribuem para sua evolução e aprimoramento contínuos.

No contexto do OCI Data Flow, que é um serviço oferecido pela Oracle Cloud Infrastructure, o Apache Spark desempenha um papel fundamental por trás dos panos. O OCI Data Flow utiliza o Apache Spark como seu motor de processamento de dados. Isso significa que, quando você executa tarefas de análise de dados, processamento de big data, ou qualquer operação relacionada a dados no OCI Data Flow, está utilizando a poderosa capacidade de processamento do Spark.

O Apache Spark é especialmente conhecido por sua capacidade de processar rapidamente grandes conjuntos de dados, distribuindo tarefas de processamento em clusters de computadores. Isso o torna ideal para ambientes de nuvem como o OCI, onde escalabilidade e eficiência são cruciais. Ao ser integrado ao OCI Data Flow, o Spark permite que os usuários executem tarefas complexas de processamento de dados, análises estatísticas e algoritmos de machine learning de maneira eficiente e escalável, aproveitando a infraestrutura robusta da Oracle Cloud.

### *Helpers*

---

O código apresentado define uma função auxiliar chamada `prepare_command`. uma ferramenta de conveniência para transformar argumentos que são armazenados em variáveis Python ou estruturas de dados em uma forma que pode ser utilizada pelos comandos mágicos do Spark, que muitas vezes esperam argumentos em formato de string.

1. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Código Helpers](.\images\3-helpers.png)

Esses comandos mágicos permitem interagir de maneira eficiente com o Spark, facilitando a execução de operações complexas de processamento de dados de forma mais simplificada e integrada dentro do ambiente do notebook Jupyter. 

### *Data Flow Spark Magic*

---

O Data Flow Spark Magic refere-se a uma coleção de "comandos mágicos" especializados no Jupyter Notebook que facilitam a interação com *Apache Spark*. Esses comandos são possíveis graças à integração com a API REST do Apache Livy, um serviço que permite a submissão de trabalhos Spark de forma remota.

> O código Spark escrito nos notebooks Jupyter é executado em clusters Spark hospedados remotamente, permitindo lidar com grandes conjuntos de dados e tarefas de processamento intensivo.

Você precisa ativar o  Data Flow Spark Magic em seu notebook usando o comando mágico *`%load_ext dataflow.magics.`*

2. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Código Data Flow Magic](.\images\4-load-spark-magic.png)

Após a ativação da extensão, o comando *`%help`* pode ser usado para obter a lista de todos os comandos disponíveis, juntamente com uma lista de seus argumentos e exemplos de chamadas.

3. Selecione a célula e execute-a com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Código Helpers](.\images\5-help.png)

> **[OPCIONAL] Doctring**: Para entender o propósito e os argumentos de um comando mágico no Jupyter Notebook, você pode adicionar um *`?`* ao final do comando, o que exibirá a docstring, um texto explicativo incorporado no código que fornece detalhes sobre sua funcionalidade. ![Código Docstring](.\images\1-callout-docstring.png)

## Tarefa 4: Criando uma Sessão

Neste momento do tutorial, vamos reutilizar algumas variáveis que foram criadas anteriormente na **Tarefa 3**. Vamos integrá-las na criação da sessão do Data Flow Studio.

Para criar uma nova sessão de cluster do Data Flow, vamos utilizar o comando mágico *`%create_session`*.
De forma geral, este comando está configurando e iniciando uma nova sessão de cluster do Data Flow no OCI Data Science, especificando detalhes como o tipo de máquina virtual, configurações de CPU e memória, versão do Spark, e onde armazenar os logs. 

1. Selecione cada uma das células e execute-as com o comando SHIFT + ENTER, ou clique no botão de execução (ícone de 'play') no notebook**.

    ![Criando sessão](.\images\6-create-session.png)

    ![Criando sessão comando](.\images\7-create-session-command.png)

Vamos decompor cada parte para uma explicação mais simples:

### *Comando Mágico %create_session:*

---

Este é um comando especial Data Flow Magic usado no Jupyter Notebook para iniciar uma nova sessão do Data Flow.

Opções do Comando:

- *-l python:* Especifica a linguagem de programação a ser usada, neste caso, Python.
- *-c '{...}':* Contém a configuração em formato JSON para a sessão do Data Flow.

#### *Configurações da Sessão:*

---

- *"compartmentId":* Identificador do compartimento na OCI onde a sessão será criada.
- *"displayName":* Nome da sessão para identificação. Pode ser alterado livremente.
- *"language":* Define a linguagem de programação (Python).
- *"sparkVersion":* Especifica a versão do Spark a ser usada.
- *"numExecutors":* Número de executores para o Spark. Os executores são processos que executam tarefas e armazenam dados para o aplicativo Spark.
- *"driverShape" e "executorShape":* Especificam o tipo de máquina virtual (VM.Standard.E4.Flex) usada para o driver e os executores, respectivamente. O driver é o processo central que coordena as tarefas do Spark.
- *"driverShapeConfig" e "executorShapeConfig":* Configurações detalhadas para o driver e os executores, incluindo o número de CPUs (OCPUs) e a quantidade de memória (em GBs).
- *"logsBucketUri":* Endereço do bucket (contêiner de armazenamento) na OCI onde os logs da sessão serão armazenados.
- *"configuration":* Configurações adicionais, como a localização do ambiente do Spark e outras opções de configuração.
- *"metastoreId":* Um identificador para o metastore de dados usado. Um metastore é um repositório central para armazenar metadados sobre as estruturas de dados, como tabelas e esquemas, dentro do ambiente Spark.

2. Depois de executar a célula que contém o comando mágico, aguarde a criação da sessão Spark.**

    ![Progresso Cluster](.\images\8-progress-cluster.png)

    A sessão do Spark estará pronta para ser utilizada assim que a seguinte mensagem for exibida.

    Cada vez que você cria uma nova sessão, um novo "Session ID" é atribuído a essa sessão, permitindo que o ambiente de cluster diferencie entre múltiplas sessões que podem estar ocorrendo simultaneamente. Esse ID pode ser utilizado para retomar, gerenciar ou encerrar a sessão específica a qualquer momento.

    ![Cluster Pronto](.\images\9-cluster-ready.png)

3. Utilize o comando mágico *`%status`* para verificar o status da sessão atual.**

    ![Status Cluster](.\images\10-status-cluster.png)

> **Nota:** Os clusters da Sessão do OCI Data Flow ficam ativos por 24 horas (1440 minutos) por padrão, porém você pode customizar esse período para criar sessões que permanecerão ativas por até 7 dias (10,080 minutos)(maxDurationInMinutes).

Parabéns, você terminou esse laboratório! 🎉

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta laboratório, você aprendeu como utilizar notebooks Jupyter no OCI Data Science para criar e gerenciar sessões do Data Flow com Apache Spark, abrangendo desde autenticação e configuração de variáveis até a execução interativa de código e monitoramento do status do cluster.

## Autoria

- **Autores** - Thais Henrique, Heloisa Escobar, Isabelle Anjos
- **Último Update Por/Date** - Isabelle Anjos, Jan/2024