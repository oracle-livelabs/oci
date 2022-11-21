# Atividades Administrativas

## Introdução

Neste Lab você vai aprender a gerenciar a solução Oracle Analytics Cloud.

*Este Lab só pode ser realizado por usuários que possuam o perfil de Administrador dentro do Oracle Analytics Cloud. Não é o caso dos usuários do Fast Track, portanto, está como Lab opcional para usuários que possuam a solução.*

*Tempo estimado para o Lab:* xx Minutos

### Objetivos

* Criar Backups do ambiente
* Definir o tipo de acesso de usuários
* Gerenciar a utilização de performance da solução
* Criar uma url customizada de acesso a solução

## Task 1: Backup do Ambiente com Snapshots

1.	Na página inicial, clique no hambúrguer na lateral direita e, em seguida, clique em **Console**.

![acesse o menu de administração da solução](./images/1-Acesso_Snapshot.png)

2.	Buscar o botão **Snapshots** e clicar nele.

![acesse o menu de criação de Snapshots](./images/2-Botao_Snapshot.png)

3.  Clicar em **Create Snapshot**, adicionar o nome do arquivo de Backup a sua escolha, nesse tutorial estamos utilizando **Backup Geral**, em content escolher a opção **Everything** e clicar em **Create**

![criar o snapshot](./images/3-Criação_Snapshot.png)

4.  Aguardar alguns segundos para que o processamento finalize, em seguida, clicar nos 3 pontos e clicar em **Export**

![criar o snapshot](./images/4-Menu_Export_Snapshot.png)

5.  Escolher a opção **Local File System**, adicionar uma senha e confirmar essa senha, clicar em **Export**

![criar o snapshot](./images/5-Salvar_Snapshot.png)

O arquivo será baixado para a máquina local, mas caso fosse necessário, poderia ser baixado para um ambiente de Data Lake (Object Storage), para isso, no passo 5, basta escolher a opção **Oracle Cloud Storage** ao invés de **Local File System** e adicionar os detalhes de acesso ao Object Storage.

## Task 2: Adminstração de usuários através de Application Roles

1.	No menu principal, clique em "Networking" e escolha "Virtual Cloud Networks"

## Task 3: Mudança de url de acesso ao Oracle Analytics Cloud (Opcional)

1.	No menu principal, clique em "Networking" e escolha "Virtual Cloud Networks"

![acesse o menu principal](./images/vcn-access-1.png)

![acesse o menu principal](./images/vcn-access-1.png)

## Task 4: Gerenciamento de utilização com Usage Tracking (Opcional)

1.	No menu principal, clique em "Networking" e escolha "Virtual Cloud Networks"

![acesse o menu principal](./images/vcn-access-1.png)

//Fazer até 4/5 tasks
//* simples cria italico
//**duplo cria negrito
//***triplo cria negrito + italico
// se o usuário tiver que clicar em algo, colocar em negrito entre ""

Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a criar uma Virtual Cloud Network (VCN) na prática.

## Autoria

- **Autores** - Breno Comin, Guilherme Galhardo, Isabella Alvarez, Isabelle Dias, Thais Henrique
- **Último Updated Por/Data** - Isabella Alvarez, Nov/2022