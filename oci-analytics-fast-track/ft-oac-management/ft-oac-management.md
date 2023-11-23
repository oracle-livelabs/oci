# Atividades Administrativas

## Introdução

Neste Lab você vai aprender a gerenciar a solução Oracle Analytics Cloud.

[Oracle Video Hub video scaled to Large size](videohub:1_k00wf9ol:large)

*Este Lab só pode ser realizado por usuários que possuam o perfil de Administrador dentro do Oracle Analytics Cloud. Não é o caso dos usuários do Fast Track, portanto, está como Lab opcional para usuários que possuam a solução.*

*Tempo estimado para o Lab:* 30 Minutos

### Objetivos

* Criar Backups do ambiente
* Definir o tipo de acesso de usuários
* Customizar uma url customizada de acesso a solução

## Tarefa 1: Backup do Ambiente com Snapshots

1.	Na página inicial, clique no hambúrguer na lateral esquerda e, em seguida, clique em **"Console"**.

![acesse o menu de administração da solução](./images/1-acesso_snapshot.png)

2.	Buscar o botão **"Snapshots"** e clicar nele.

![acesse o menu de criação de Snapshots](./images/2-botao_snapshot.png)

3.  Clicar em **"Create Snapshot"**, adicionar o nome do arquivo de Backup a sua escolha, nesse tutorial estamos utilizando **"Backup Geral"**, em content escolher a opção **"Everything"** e clicar em **"Create"**.

![criar o snapshot](./images/3-criacao_snapshot.png)

4.  Aguardar alguns segundos para que o processamento finalize, em seguida, clicar nos 3 pontos e clicar em **"Export"**.

![entrar no menu para exportar o snapshot](./images/4-menu_export_snapshot.png)

5.  Escolher a opção **"Local File System"**, adicionar uma senha e confirmar essa senha, clicar em **"Export"**.

![exportar o arquivo do snapshot](./images/5-salvar_snapshot.png)

O arquivo será baixado para a máquina local, mas caso fosse necessário, poderia ser baixado para um ambiente de Data Lake (Object Storage), para isso, no passo 5, basta escolher a opção **"Oracle Cloud Storage"** ao invés de **"Local File System"** e adicionar os detalhes de acesso ao Object Storage.

## Tarefa 2: Administração de usuários através de Application Roles

Nessa Task iremos realizar o gerenciamento do tipo de acesso dos usuários dentro do Oracle Analytics Cloud.

1.	Na página inicial, clique no hambúrguer na lateral esquerda e, em seguida, clique em **"Console"**.

![acesse o menu de administração da solução](./images/6-acesso_console_admin.png)

2.	Buscar o botão **"Users and Roles"** e clicar nele.

![acesse o menu de gerenciamento de usuários](./images/7-acesso_usersroles.png)

3.  Clicar em **"Application Roles"**, escolher em qual role irá adicionar usuários, nesse exemplo, adicionaremos na opção **"DVConsumer"**, então basta clicar na opção.

![acessando a opção de role de usuário escolhida](./images/8-escolha_role.png)

4.  Para adicionar usuários no grupo desejado, basta clicar na opção **"Users"** e em seguida em **"Add Users"**.

![adicionando usuários a role desejada](./images/9-adicionar_usuario.png)

5.  No campo de busca, digitar o nome do usuário desejado seguido por um asterisco (*), clicar em Enter no teclado, selecionar o usuário escolhido e clicar em **"Add"**.

![incluir usuários na role desejada](./images/10-selecionar_usuario.png)

Para entender em mais detalhes quais são as roles e suas permissões, basta verificar na documentação: https://docs.oracle.com/en/cloud/paas/analytics-cloud/acabi/application-roles.html

## Tarefa 3: Customização de url de acesso ao Oracle Analytics Cloud (Opcional)

Nessa Task iremos personalizar a url de acesso ao Oracle Analytics Cloud. Porém, para esse caso, é necessário possuir um certificado X.509 com extensão .pem, .cer ou .crt para que seja possível utilizar o domínio desejado na url.

1.	Na console inicial do Oracle Cloud Infrastructure, dentro da tela do Oracle Analytics Cloud, após URL Personalizado, clicar em **"Criar"**.

![dentro da console do OCI, acesse o botão criar](./images/11-criar_urlpersonalizado.png)

2.	Na nova tela, digitar o nome do host desejado para a url, incluir o certificado X.509 com o domínio a ser utilizado, incluir uma chave privada no formato .pem ou .key e clicar em **"Criar"**.

![preencher as informações necessárias e clicar em criar](./images/12-inclusao_informacoescertificado.png)

3. A instância será atualizada, portanto, ficará indisponível por alguns minutos, em seguida voltará a ficar disponível quando o símbolo do OAC voltar a ficar na cor verde.

![atualização OAC](./images/13-disponibilidade_oac.png)

Parabéns, você terminou esse laboratório!
Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a realizar tarefas de gerenciamento do Oracle Analytics Cloud, desde definir a permissão de usuários, realizar backups, customizar a url de acesso a solução e verificar a performance de utilização da solução.

## Autoria

- **Autores** - Breno Comin, Guilherme Galhardo, Isabella Alvarez, Isabelle Dias, Thais Henrique
- **Último Updated Por/Data** - Gabriela Miyazima, Mar/2023