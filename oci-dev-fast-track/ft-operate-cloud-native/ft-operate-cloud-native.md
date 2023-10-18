# Lab 5 - Operando Aplicações Nativas em Nuvem

## Introdução

Olá, neste laboratório você aprenderá como registrar, monitorar e analisar os logs da infraestrutura Compute de OCI que você provisionou nos laboratórios anteriotes utilizando a

**Oracle Cloud Observability and Management Platform**


- 🌀 [Página oficial do OCI Observability and Management Platform](https://www.oracle.com/br/manageability/)
- 🧾 [Documentação do OCI Logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm)
- 🧾 [Documentação do OCI Logging Analytics](https://docs.oracle.com/en-us/iaas/logging-analytics/index.html)



**A seguir você aprenderá o passo-a-passo desta configuração:**

Como pré-requisito, faça o [login](https://www.oracle.com/cloud/sign-in.html) em sua conta na OCI!

Execute o Lab 1, caso não o tenha executado anteriormente;

## Task 1:  Ativar o serviço de Logging e habilitar a coleta dos Logs

1. No 🍔 menu de hambúrguer, acesse: **Observability and Management Platform** → **Logging**:
   ![menu logging](images\menu.png)

2. No menu à esquerda **Logging** clique em **Logs** e em seguida no botão à direita **Enable service log**:
![botao enable service logs](images\logs.png)

3. Escolha em **Service** o item *Virtual Cloud Network* e em **Resource** selecione a subnet pública criada anteriormete. Em **Log Category** selecione a opção de *Flow Logs* e em **Log Name** digite o nome *Flowlogs-VCN*. Depois em Log Location clique em **Show Advanced Options** e clique em **Create New Group** para criar um novo grupo:
![formulario enable service log](images\enable-log.png)

4. Na tela de criação de grupo de log em **Name** digite o nome do grupo *LogGroupFlow* e clique no botão **Create**:
![tela criacao log](images\create-log.png)

5. Deixe selecionado o *LogGroupFlow* como **Log Group** e clique no botão **Enable Log** para habilitar a configuração:
![campo configure log](images\enable-log.png)

6. Após a ativação (2-3 min), inicia-se a coleta de logs (5-6 min). Para visualizar no menu à esquerda **Logging** clique em **Logs** e depois clique no Log Name que acabamos de criar **Flowlogs-VCN**:
![menu logging](images\flow-log.png)

7. Você vizualizará o dashboard de coleta de logs da VCN escolhida. Clique em **Explore with Log Search** à direita para:
![dashboard logs](images\explore-log.png)

8. Pronto! A partir de agora você pode modificar as buscas para filtrar o log desejado.

   Dica: Mude a visualização para **Visualize** e divirta-se!


## Task 2:  Ativar o serviço de Logging Analytics e criar um grupo para os Logs

1. No 🍔 menu de hambúrguer, acesse: **Observability and Management Platform** → **Logging Analytics**:
![menu logging analytics](images\menu-analytics.png)

2. Ative o **Logging** clicando o botão **Start Using Logging Analytics**:
![botao satrt using logging analytics](images\start-analytics.png)

3. Após a inicialização, clique no botão **Take me to Log Explorer**:
![botao take me to log explorer](images\explorer-analytics.png)

4. Na console de Log Explorer no menu superior à esquerda clique e selecione **Administration**:
![menu administration](images\create-dash-analytics.png)

5. Agora clique em **Log Groups** no menu **Resources** e em seguida no botão **Create Log Group**, para criarmos um novo grupo de log:
![menu log groups](images\log-groups.png)
![botao create groups](images\create-log-group.png)

6. Na console de criação de grupo de Log em **Name** digite o nome do grupo **LogGroupVCN** e depois clique no botão **Create**:
![campo name](images\log-name.png)

## Task 3: Criar o Service Connector para replicar os logs do Logging para o Logging Analytics

1. No 🍔 menu de hambúrguer, acesse: **Observability and Management Platform** → **Service Connectors**:
![menu service connectors](images\menu-service-connector.png)

2. Na console de **Service Connectors** clique no botão **Create Service Connector**:
![botao create service connector](images\service-connector.png)

3. Em **Connector Name** digite **LogVCNConnector**, em **Configure Source** selecione **Logging** e em **Target** selecione **Logging Analytcs**. Na parte de **Configure Source** selecione em **Log Group** o **LogGroupFlow** e em **Logs** selecione o **FlowLogs-VCN** criados anteriormente:
![configuracao service connector](images\connector-config.png)

4. **Em Configuration Target** selecione o **Log Group LogGroupVCN** e (Muito Importante ⚠️) clique no botão **Create** à direita para criar as políticas para que o conector tenha permissão de escrita. Após isso clique no botão **Create** no canto inferior à esquerda para criar o **conector**:
![formulario botao create](images\config-target.png)


## Task 4: Configurar queries customizadas e criar um dashboard

1. No 🍔 menu de hambúrguer, acesse: **Observability and Management Platform** → **Log Explorer**:
![menu log explorer](images\log-explorer.png)

2. Na console **Log Explorer** substitua a query existente pela query abaixo para buscar os IPs de origem que estão acessando a VCN que configuramos e clique no botão Run:

'Log Source' = 'OCI VCN Flow Unified Schema Logs' | stats count as logrecords by 'Source IP'

![console log explorer](images\dash-log-explorer.png)

Dica: Caso não apareça a mensagem No data has been ingested no Log Explorer, clique no menu à esquerda que está escrito Logging Analytics → Home e clique na imagem VCN Flow Logs.

3. Salvaremos o resultado da query para utilizarmos na criação do nosso dashboard a seguir. Clique em **Actions** no menu à direita e em **Save**, digite **Ips de Entrada** em **Search Name** e clique no botão **Save**:
![image save search](images\save-search.png)

4. Configure outra query customizada para saber o volume do tráfego de saída da VCN. substitua a query existente pela query abaixo, troque a visualização para gráfico de **Line** e clique no botão **Run**:
![query botao run](images\dash-traffic.png)

5. Clique em **Actions** no menu à direita e em **Save as...**, digite **Tráfego de Saída** em **Search Name** e clique no botão **Save**:
![campo saved search compartment](images\save-search.png)

Dica: Utilizar Save as.. ao inverso de Save para conseguir salvar o resultado com um novo nome.

6. No menu ao lado esquerdo superior selecione **Dashboard**:
![menu dashboard](images\dashboard.png)

7. Na console de Dashboard clique no botão **Create Dashboard**:
![botao create dashboard](images\create-dashboard.png)

8. Na console de criação do dashboard, selecione o compartement em **Widget Compartment** e arraste e solte o widget **Ips de Entrada**:
![console dashboard](images\config-widget.png)

9. Após arrastar o widget, será solicitado a criação do filtro. Adicionaremos um novo filtro, deixe a seleção **Log Group Compartment** e clique no botão **Save Changes**:
![add new entity imagem](images\save-dash-entity.png)

10. Para a configuração da **Entity**, deixe a seleção Entity e clique no botão **Save Changes**:
![botao save changes](images\save-dash.png)

11. O widget será adicionado ao dashboard dessa maneira:
![dashboard add widgets](images\show-widget.png)

12. Realize o mesmo processo realizado anterioemnte clicando na aba **Add widget** para o widget **Tráfego de Saída**:
![menu trafego de saida](images\widget.png)

13. Modifique no nome dashboard clicando no ícone **Pencil**, digite **VCN Dashboard** e tecle Enter para salvar o nome. Após isso selecione a aba **About**, selecione um compartment e clique no botão **Save Changes**:
![dashboard botao save changes](images\dash-final.png)



## Conclusão

### Parabéns!!! 👏🏻 Você foi capaz de configurar com sucesso um pipeline completo de **Logging** e **Logging Analytics** em OCI! Você terminou esse laboratório pode seguir para o próximo Lab.



## Autoria

- **Autores** - Andressa Siqueira, Debora Silva, Thais Henrique
- **Último Update Por/Date** - Andressa Siqueira Agosto/2023




