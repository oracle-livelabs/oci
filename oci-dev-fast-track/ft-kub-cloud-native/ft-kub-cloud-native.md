# Lab 3 - Desenvolver Aplicações Nativas - Parte 2

## Introdução

Esse workshop foi desenvolvido com o intuito de demonstrar as funcionalidades da Oracle Cloud Infrastructure em cenários onde se faz necessário orquestrar sua infraestrutura baseando-se em Eventos.
*Tempo estimado para o Lab:* 30 Minutos

### **Pré requisitos**
Vamos coletar algumas informações na tenancy do OCI que serão utilizadas ao logo do laboratório, recomendamos que as anote em um bloco de nota para ter sempre em mãos de modo fácil. Serão coletadas as seguintes informações:

- Para geração de auth token:
No canto direito superior clique no icone de perfil, e em seguida selecione seu usuário, conforme imagem abaixo:
![icone perfil](images/user-details.png)

- No canto esquerdo inferior, abaixo de Recursos (Resources) selecione Auth Tokens:
![botao generate token](images/authtoken.png)

- Clique em Gerar Token (Generate Token)
![campo descricao](images/generatetoken.png)

- Escreva uma descrição da sua preferência para o token, e clique em Gerar Token (Generate Token)

![botao copy](images/descricaotoken.png)

- [IMPORTANTE] Copie o token gerado para um bloco de notas, esse token não será mostrado novamente.

![botao close](images/copiaauth.png)

6. Clique em Fechar (Close)

### **Objetivos**
Nesse Workshop você vai:
- Aprender sobre Oracle Functions. A Oracle Cloud Infrastructure (OCI) Functions é uma plataforma serverless que permite os desenvolvedores criarem, executarem e escalarem aplicações sem precisar administrar nenhuma infraestrutura.

- Sobre o serviço de Streaming da Oracle Cloud Infrastructure (OCI) é uma plataforma de streaming de eventos em tempo real, serverless e compatível com Apache Kafka para desenvolvedores e cientistas de dados.

- E Events. O Oracle Cloud Infrastructure Events permite que você crie automação com base nas alterações de estado dos recursos em toda a sua locação. Use Eventos para permitir que suas equipes de desenvolvimento respondam automaticamente quando um recurso alterar seu estado.


## Task 1: Criando a Function Application

1. Abra o menu no canto superior esquerdo, em Serviços de Desenvolvimento (Developer Services), selecione Functions
 ![menu developer services](images/function.png)

2. No canto esquerdo inferior verifique se o compartimento que você esta utilizando para esse laboratório esta selecionado.
 ![campo compartment](images/compartimento.png)

3. Clique em Criar Aplicação (Create Application).

4. No Formulario de Nova Aplicação preencha:

- Nome: < Defina um nome pra sua função >
- VCN: Selecione vcn_workshop
- Subnets: Selecione a subnet_workshop

 ![imagem formulario](images/formulario.png)

5. Clique em Criar (Create)

## Task 2: Acessando e configurando a function

1. Na página da aplicação criada, seguiremos o guide gerado pela propria plataforma para configurar o cloud shell.
Para acessar o guide, clique em Conceitos Básicos (Getting Started) no canto inferior esquerdo.

 ![gettins started](images/gettingstart.png)

2. Selecione a opção de Configuração do Cloud Shell (Cloud Shell Setup).
 ![cloud shell setup](images/gettingopcoes.png)

3. Execute os passos 1,2 e 3 do guide sem nenhuma alteração:
![campos um dois tres](images/passos.png)

4. Execute o passo 4 substituindo [OCIR-REPO] por 'workshop' conforme exemplo abaixo:
 ![campo update](images/fnupdate.png)

5. Pularemos o passo 5 visto que já geramos o Auth token anteriormente.

6. Execute o passo 6, e ao ser solicitada a informação de password, insira a informação de Auth Token gerada no passo 3 deste laboratório.
 ![password](images/dockerlogin.png)

7. Execute o passo 7 para validar se a configuração foi realizada com sucesso.
 ![shell execute](images/fnlist.png)

8. Realizando o Deploy da Função
Ainda utilizando o Cloud Shell, clone o repositório da função que vamos utilizar nesse workshop:

 $ git clone https://github.com/gustavogaspar/events-function.git

9. Entre na pasta do projeto
 $ cd events-function

10. Execute o comando de deploy, substituindo a informação de [APP-NAME] pelo nome da sua aplicação criada no passo 11 deste laboratório. (Você pode utilizar o comando apresentado no passo 10 da guia de Conceitos Basicos (Getting Started). Esse processo pode levar bastante tempo
 $ fn -v deploy --app [APP-NAME]

11. Execute o comando abaixo, para chamar a função e validar se ela foi criada corretamente:
 $ fn invoke [APP-NAME] final-workshop

 O Retorno esperado é: {"message":"No event"}

## Task 3: Criando Regra de Eventos

Criando regra de evento
  1. Acesse o menu no canto superior esquerdo, em Observability & Management, clique em Serviço Events (Events Service).
  ![menu events](images/menuregra.png)

 2. No canto esquerdo inferior verifique se o compartimento que você esta utilizando para esse laboratório esta selecionado.
  ![compartment workshop](images/compartimento.png)

3. Clique em Criar Regra (Create Rule)
  ![botao criar regra](images/regra.png)

Preencha o formulário de regra da seguinte forma:
Nome para Exibição: < Defina um nome para regra >
Descrição: < Defina uma descrição para a regra >
Condições da Regra:
Condição: "Tipo de Evento"
Nome do Serviço: "Object Storage"
Tipo de Evento: "Object Create"

  ![formulario criar regra](images/regrapreenche.png)

Ações:
Tipo de Ação: "Funções"
Compartimento da Função: < Selecione o compartimento da função criada no lab anterior>
Aplicativo de Função: < Selecione o aplicativo de função criado no lab anterior >
Função: "final-workshop"

  ![botao create](images/acoes.png)

4. Clique em Criar (Create)

## Task 4: Testando o funcionamento do fluxo
Agora que temos o fluxo criado, podemos testar sua funcionalidade, para isso abriremos uma nova aba no navegador, onde acessaremos a nossa stream, e na nossa aba principal iremos fazer o teste de criação de um arquivo .txt em nosso bucket.

1. Nova Aba
2. Acesse a console da cloud: https://www.oracle.com/cloud/sign-in.html
3. Insira o nome da sua tenancy no campo de Cloud Account Name
4. Clique no botão Continue para ir para a página de login.
5. Insira seu usuario/senha e clique em Sing In (Se o seu navegador já possui uma sessão ativa, esse passo provavelmente não será necessário)
6. No menu no canto esquerdo superior, em Funções Analíticas e AI (Analytics & AI), selecione Mensagens (Messaging)

  ![menuu messaging](images/menustream.png)

7. No canto esquerdo inferior verifique se o compartimento que você esta utilizando para esse laboratório esta selecionado

  ![compartment workshop](images/compartimento.png)

8. Você observará que um fluxo (stream) já estará criado neste compartimento com o nome de "workshop" . Este fluxo foi criado durante o primeiro laboratório, onde executamos o código de terraform através do resource manager.
  ![stream workshop](images/stream.png)

9. Selecione o fluxo "workshop"
Mantenha a aba aberta, e volte para a aba principal do seu navegador


10. Aba Principal
No menu no canto esquerdo superior, em Armazenamento (Storage), acesse Buckets
  ![menu buckets](images/buckets.png)

11. No canto esquerdo inferior verifique se o compartimento que você esta utilizando para esse laboratório esta selecionado.
  ![compartment workshop](images/compartimento.png)

12. Você observará que um Bucket já estará criado neste compartimento com o nome de "workshop_bucket".
  ![workshop bucket](images/verbucket.png)

13. Selecione o bucket "workshop_bucket".
A emissão de eventos a partir de um bucket é opcional, podendo ser habilitada ou desabilitada a qualquer momento.Valide se a emissão de eventos (Emit Object Events) está habilitada para este bucket.
  ![objec events habilitado](images/objectemite.png)

14. Estamos prontos para realizar o teste, mantenha a aba principal aberta.

## Task 5: Teste
1. Crie um arquivo de formato .txt em seu computador local, com o conteúdo de sua preferência.
   (O formato .txt utf-8 não é      obrigatório,porém todos os testes realizados nesse workshop foram considerando esse formato)
  ![bloco de notas](images/testestream.png)

2. Na sua aba principal ( Onde temos a página do Bucket "workshop_bucket" aberta ) clique em Upload.
  ![botao upload](images/upload.png)

3. No formulário de upload de objetos, clique em selecionar arquivos (select files)
  ![icone select files](images/selectfiles.png)

4. Selecione o arquivo .txt criado para este teste
   Clique em Upload
  ![arquivo texto](images/testeworkshop.png)

5. Aguarde o upload do arquivo, e clique em Fechar(Close)
   Na nova aba ( Onde temos a página do fluxo "workshop" aberta) clique em Carregar Mensagens(Load Messages).
 ![botao carregar mensagens](images/mensagensrecentes.png)

6. Não se preocupe caso nenhum item tenha sido encontrado, este processo pode levar algum tempo visto qu
   é a primeira execução da função.Aguarde alguns segundos e tente carregar as mensagens novamente se for necessário.
  ![campo carregar mensagens](images/mensagensfinal.png)


## Conclusão

### Parabéns!!!Nesta sessão você aprendeu a criar uma aplicação baseada em eventos que coleta informações e envia á uma fila de ingestão de dados! Você terminou esse laboratório pode seguir para o próximo Lab.


## Autoria

- **Autores** - Andressa Siqueira, Debora Silva, Thais Henrique
- **Último Update Por/Date** - Andressa Siqueira Agosto/2023
