# Primeiros passos no OAC

## Introdução

Neste Lab você vai aprender a navegar pela interface do Oracle Analytics Cloud e, conectar o OAC a dados. 

***Overview***

O Oracle Analytics Cloud é um serviço de nuvem pública escalável e seguro que fornece um conjunto completo de recursos para explorar e executar análises colaborativas para você, seu grupo de trabalho e sua empresa. Com o Oracle Analytics Cloud, você também tem recursos flexíveis de gerenciamento de serviços, incluindo configuração rápida, dimensionamento e patches fáceis.
Como usuário do Oracle Analytics com acesso de Autor de Conteúdo do DV, você poderá estabelecer conexão com as origens de dados usadas por sua organização. Por exemplo, você pode criar um conjunto de dados que inclua tabelas de uma conexão do Autonomous Data Warehouse , tabelas de uma conexão Spark e tabelas de uma área de assunto local.

*Tempo estimado para o Lab:* NN Minutos

### Objetivos

Neste Laboratório você vai:
* Explorar os recursos disponíveis de forma nativa dentro do OAC (Oracle Analytics Cloud)
* Estabelecer uma conexão.
* Testar sua conexão. 

## Task 1: Página Inicial

Assim que logar com seu ID de Usuário e Senha, você será direcionado para a página inicial da ferramenta. 
Quando você acessar pela primeira vez, o Oracle Analytics Cloud exibe um tour pelo produto. 
Esta tela inicial é a **Home page**.
![Home page"](.\images\homepage.png)  

Sempre que quiser retornar à ela:

1.	Clique no Menu Hamburguer no lado superior esquerdo da tela principal, 

![menu do OAC "Hamburguer"](.\images\Menu_Hamburguer.png)   

Assim que a barra lateral se expandir, você verá o ícone correspondente a **Home**, selecione-o.

![menu do OAC "Hamburguer"](.\images\Home_Analytics.png) 

2.	Para explorar os projetos acessíveis, clique no Menu Hamburguer e escolha **Catálogo**. Você será direcionado para a seguinte tela:

![menu do OAC "Catálogo"](.\images\Catalogo_Analytics.png)  

3.	Seguindo o mesmo passo de clicar no Menu Haburguer, ao clicar em **Dados**, será exibidos em **Conjunto de Dados**, dados disponíveis para serem usados, quando você upar uma tabela, planilha ou arquivo, eles ficarão salvos para serem consumidos imediatamente ou reaproveitados em outras ocasiões.

![Dados](./images/Dados_Analytics.png)

Ainda nesta aba, você poderá verificar **Conexões**:

![Dados](./images/conexoes.png)

À direita de **Conexões**, você pode acessar **Fluxos de Dados** clicando em cima dele.
Os fluxos de dados permitem que você organize e integre seus dados para produzir conjuntos de dados que seus usuários podem visualizar.

Por exemplo, você pode usar um fluxo de dados para:

* Criar um conjunto de dados.
* Combinar dados de diferentes fontes.
* Treinar modelos de aprendizado de máquina ou aplicar um modelo de aprendizado de máquina aos seus dados.

![Fluxo de Dados](./images/Fluxodedados.png)

Seguindo, teremos **Sequências**. 
Uma sequência é definida como uma coleção de fluxos de dados que você executa juntos. Eles são úteis quando você quiser executar vários fluxos de dados como uma única transação. 

![Sequence](./images/Sequencias.png)

Por fim, **Replicações de Dados**. 
Use-o para copiar dados de uma origem para análise no Oracle Analytics Cloud. 

![Replicações](./images/Replicacaodedados.png)

4.	O Oracle Analytics permite que você registre e use modelos de machine leaning Oracle do Oracle Database ou Oracle Autonomous Data Warehouse, volte mais uma vez no Menu Hamburguer e clique em **Aprendizagem Por Máquina** para acessar uma lista de modelos e scripts registrados:

![Machine Learning](./images/Aprendizadopormaquina_Analytics.png)

5.	Abaixo de Aprendizagem Por Máquina, clique em **Modelos Semânticos** para acessar uma lista de modelos e scripts registrados:

![Modelos Semanticos](./images/Semantica.png)

O modelo de dados semânticos é uma abordagem que se baseia em princípios semânticos que resultam em um conjunto de dados com estruturas de dados especificadas inerentemente. 

6.	Para rastrear o status de seus jobs e gerenciá-los, continue navegando no Menu Hamburguer e clique em **Jobs**. Você pode monitorar o número de jobs filtrando por **Tipo de Objeto** e o **Status** do mesmo.
![Jobs](./images/jobs.png)

7.	Ao clicar em **Console** você encontrará opções para gerenciar permissões de usuário, configurar vários aspectos do Oracle Analytics Cloud e executar outras tarefas administrativas.

![Visualizações_console](./images/Console.png)
![Visualizações_console](./images/Console_config.png)

## Task 2: Opções de ID

1. Para ter acesso ao Help Center, editar seu perfil, mudar a senha ou efetuar, verficar a versão atual do OAC ou fazer logout da sua conta, basta clicar em cima do círculo com as iniciais da sua credencial.

![ID](./images/ID.png)

## Task 3: Barra de Pesquisa

1. Através da **Barra de pesquisa** em sua Home Page, você pode pesquisar todos os tópicos apresentados aqui e todas as funcionalidades que existem dentro do OAC, desde as opções dentro do **Menu Hamburguer** até funções do **Criar**.

![pesquisar_tudo](./images/Pesquisa_Homepage.png)

## Task 4: Criar uma Conexão

Você pode se conectar a vários tipos de fonte de dados, como bancos de dados em nuvem (públicas e privadas), bancos de dados locais (incluindo JDBC - Conectividade de Banco de Dados Java) e muitos aplicativos comumente usados, como Dropbox, Google Drive e Amazon Hive.

1.  Na página inicial, no canto superior esquerdo, clique em **Criar** e, em seguida, clique em **Conexão**.

![Create](./images/Conexão.png)

2. Será exibido uma nova janela, na qual mostrará os ícones dos conectores disponíveis.
Você pode pesquisar pelo nome ou rolar a barra para encontrar mais opções. Bastar clicar no ícone correspondente à conexão desejada para começar a configurá-la.

![Conectores](./images/Conectores.png)

Você cria uma conexão para cada fonte de dados que deseja acessar no Oracle Analytics. Uma vez conectado, você pode visualizar seus dados para criar insights.

## Task 5: Teste Sua Conexão (OPCIONAL)

Para ter certeza que sua conexão está ativa e funcionando, visualize-a através da lista de conexões.
Tal lista contém as conexões que você criou e as conexões que você tem permissão para acessar e usar para criar conjuntos de dados.
Existem algumas formas de fazer essa verificação:

1.	No Menu Hamburguer da página inicial, clique em **Dados** e, em seguida, na guia **Conexões** para acessar a lista. Se a conexão foi feita de maneira correta, você será capaz de visualizá-la, bem como os detalhes da mesma.

![Conexão com banco](./images/Conexaofeita.png)

2. Ao clicar em **Criar** e posteriormente em **Conjunto de Dados** para dar início à criação do seu conjunto, você será direcionado para uma guia onde imediatamente, conseguirá visualizar sua conexão. 

![Criando o conjunto](./images/conjuntodedados.png)

![Acessando o conjunto](./images/ConjuntodedadosADW.png)

Pronto!

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a explorar os principais recursos e definições do sistema  para localizar pastas de trabalho, dados e conexões, jobs e principais abas para configurar o sistema.
Além disso, você aprendeu quais fontes de dados você pode usar em conjuntos de dados, como acessá-los e averiguar se a conexão está apta a ser usada.


## Autoria

- **Autores** - Isabelle Dias
- **Último Update Por/Data** - Isabelle Dias, Novembro/2022