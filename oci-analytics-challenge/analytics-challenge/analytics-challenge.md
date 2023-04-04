# Oracle Analytics Racing Challenge

## Introdução

Bem-vindo ao Oracle Analytics Racing Challenge! Esse laboratório tem como objetivo compartilhar o conhecimento básico para atender aos requisitos do nosso desafio, que consiste em compartilhar uma análise sobre quais aspectos você considera mais impactantes nos resultados das corridas da Fórmula 1 (na forma de um arquivo .dva), acompanhado de um vídeo curto (até 2 minutos) explicando essas análises.

***Overview***

O Oracle Analytics Cloud é um serviço de nuvem pública escalável e seguro que fornece um conjunto completo de recursos para explorar e executar análises colaborativas para você, seu grupo de trabalho e sua empresa. Com o Oracle Analytics Cloud, você também tem recursos flexíveis de gerenciamento de serviços, tratamento dos dados e criação de análises visuais.


*Tempo estimado para o Lab:* 1 hora

### Objetivos

Neste Laboratório você vai:
* Se conectar com o Oracle Analytics Cloud
* Criar um conjunto de dados
* Gerar uma análise de exemplo
* Aprender a compartilhar o resultado do seu projeto


## Tarefa 1: Acessar a instância do Oracle Analytics Cloud

O Oracle Analytics Cloud é um dos serviços disponível dentro de OCI (Oracle Cloud Infrastructure). Você poderia acessá-lo diretamente através da sua URL. Porém nessa tarefa você vai aprender como acessar o OAC usando a console em OCI e navegando pelo menu de serviços até a instância do Oracle Analytics Cloud que vamos usar nesse Workshop.

Após fazer o login no ambiente fornecido para você com suas credenciais exclusivas (Ver Lab "Pré-requisitos")

1. Você verá a console OCI. Verifique se você está na Região correta *US East (Ashburn)*, em seguida clique no menu de hamburger na lateral superior esquerda.

    ![verifique a região e clique no menu](.\images\check-region-menu.png)

2. Selecione **Analytics & AI** e clique em **Analytics Cloud**.

    ![Navegue até Analytics Cloud](.\images\click-analytics-cloud.png)

3. Verifique se você está no Compartimento **ANALYTICS** (como indicado na imagem) e clique na instância **ANALYTICSLAB**.

    ![Verifique o compartimento e clique na instância](.\images\check-comp-click-analytics.png) 

4. Agora basta clicar no botão **ANALYTICS HOME PAGE** .

    ![Clique em Home Page](.\images\click-home-page.png)

Uma nova aba será aberta e você será direcionado para a Página Inicial do OAC.

   ![Home Page](.\images\analytics-home-page.png)

## Tarefa 2: Criando um Conjunto de Dados

Dentro do Oracle Analytics, grande parte da navegação é feita pelo **Menu Hambúrger**. Sempre que quiser retornar à Home page, você deve:

1.	Clicar no Menu Hambúrger no lado superior esquerdo da tela principal,

    ![menu do OAC "Hambúrger"](.\images\menu_hamburguer.png)

Assim que a barra lateral se expandir, você verá o ícone correspondente a **Home**, selecione-o.

   ![menu do OAC "Hambúrger"](.\images\home_analytics.png)

2.	Seguindo o mesmo passo de clicar no **Menu Hambúrguer**, ao clicar em **Dados**, você será direcionado para a área em que são gerenciadas as conexões e os conjuntos de dados. É aqui que os dados mapeados ficam disponíveis para serem usados, sejam eles um banco de dados, uma aplicação, uma planilha ou uma API.

    ![Home Dados"](.\images\home_dados.png)

3.	Navegue até a aba **Conexões**, e busque pela conexão **ADW_ANALYTICS_CHALLENGE**, clique nela para criar um Conjunto de dados a partir dela. Conjuntos de dados são modelos de dados self-service que você cria especificamente para sua visualização de dados e requisitos de análise.

    ![Conexões Challenge"](.\images\conexoes_challenge.png)

4.	Isso abrirá uma tela como a que pode ser vista abaixo. Clique em **ADW_ANALYTICS_CHALLENGE**, logo em seguida em **Esquemas** e depois em **FORMULA1** para abrir as 6 tabelas com dados que poderão ser utilizadas no desafio. Arraste a primeira delas, **DRIVER_STANDINGS** para a área da tela em branco.

    ![Driver Standings Tabela"](.\images\driver_standings_tabela.png)

5. A plataforma identificará a tabela e suas colunas.

    ![Driver Standings Tabela"](.\images\driver_standings_carregada.png)

6. Verifique se alguma coluna está tratada inadequadamente como **Atributo** ou **Métrica**. Nesse caso as 3 primeiras são IDs e deverão ser atualizadas para **Atributo**. Faça isso clicando em cima do **#** e substituindo pelo **A**. Perceba que isso já foi feito para as 2 primeiras colunas no print abaixo.

    ![Medida Atri"](.\images\medida_atri.png)

7. Realize o mesmo processo para a coluna **YEAR**

    ![Ano Atributo](.\images\ano_atributo.png)

8. Clique no botão no superior direito para **Salvar seu Conjunto** e **Dê um nome para ele**

    ![Salvar Conjunto"](.\images\salvar_conjunto.png)

    ![Salvar Conjunto 2"](.\images\salvar_conjunto_2.png)

9. Selecione a opção **Criar Pasta de Trabalho** para avançar para a próxima etapa.

    ![Criar Pasta"](.\images\criar_pasta.png)

10.  Realize exatamente o mesmo processo, do passo 3 até o 9, mas agora substituindo a tabela DRIVER_STANDINGS pela tabela RESULTS. Isso será importante para que possamos relacionar dados de 2 tabelas diferentes. Não se esqueça de atualizar os IDs de **Medidas** para **Atributos**.

    ![Results Tabela"](.\images\results_tabela.png)

Pronto! Seus conjuntos de dados estão preparado para ser utilizados para gerar uma visualização.

## Tarefa 3: Criando Visualizações com os Dados

1. Volte para a página inicial do Oracle Analytics e vá até o **Menu Criar**. Dentro dele, selecione a opção **Pasta de Trabalho**.

    ![Criar Pasta Trabalho](.\images\criar_pasta_trab.png)

2. Adicione os conjuntos de dados **Driver Standings** e **Results** à Pasta de Trabalho.

    ![Add Dados"](.\images\add_dados.png)

3. Navegue até a **Aba Dados** utilizando o botão na região superior da tela, e selecione a área que **Conecta os 2 Conjuntos de Dados**. É aqui que vamos definir o relacionamento entre nossas tabelas. 

    ![Conexão Join"](.\images\conexao_join.png)

4. Clique no botão **Adicionar Correspondência** para criar uma nova Junção. Se já existir alguma, é possível deletá-la clicando no **X** ao lado direito dela.


    ![Add Correspondência"](.\images\adicionar_correspondencia.png)

5. Selecione a coluna **DRIVERID** dos 2 lados. Logo após, selecione a opção **OK** para prosseguir.

    ![Conexão Join"](.\images\driver_id.png)

6. Volte para a aba **Visualizar** e selecione (usando CTRL + clique) a coluna **DRIVERREF** da base Driver Standings e a coluna **POINTS** da base Results.

    ![Análise Um"](.\images\analise_um.png)

7. Arraste os dois valores para a tela e o Oracle Analytics irá automaticamente entender que tipos de dados estão sendo analisados e adequar o melhor tipo de visualização para eles. Nesse caso a sugestão é uma visualização por barras, em que cada barra representa a quantidade de pontos que determinado corredor acumulou no período analisado. Lembre-se de que não possuímos dados das temporadas mais recentes.

    ![Análise Dois"](.\images\analise_dois.png)

8. Vamos criar um filtro para ver apenas os 10 corredores com as maiores pontuações. Para isso, selecione o valor **POINTS** de dentro de Driver Standings e arraste ele para a área de filtro.

    ![Análise Três"](.\images\analise_tres.png)

9. Clique no campo **POINTS** que está no filtro e selecione a opção **N Mais Altos/Mais Baixos**, para filtrar apenas os 10 corredores com mais pontos.

    ![Análise Quatro"](.\images\analise_quatro.png)

10.  Perceba que existe uma grande quantidade de registros sem um piloto associado. Retiraremos essa informação da tela para que ela não prejudique nossa análise. **Clique com o botão direito** na maior coluna e selecione a opção **Remover Selecionado**.

    ![Análise Cinco"](.\images\analise_cinco.png)

11. Selecione a área de **Propriedades da Visualização**, que fica acima da coluna em que selecionamos os dados que incluiremos na tela. Na opção de **Título**, selecione **Personalizado**.

    ![Análise Seis"](.\images\analise_seis.png)

12. Escreva um título como **"10 Pilotos Com Mais Pontos"**. Pronto, você acabou de criar a sua primeira visualização!

    ![Análise Sete"](.\images\analise_sete.png)

## Tarefa 4: O Grande Desafio

1. Utilizando as técnicas apresentadas no evento e mais outras que você pode explorar por sua conta, encontre padrões e curiosidades nos dados compartilhados com vocês. Tente criar uma narrativa e explorar possibilidades, pois deverá ser feita uma apresentação com o resultado final dessa análise, em um vídeo de até 2 minutos ou compartilhando o arquivo .dva e um guia descrevendo qual o resultado das análises. A melhor análise será aquela que explorar melhor as capacidades da plataforma, criar um visual agradável, uma narrativa coesa e conseguir se aprofundar nos detalhes, e será premiada com um brinde surpresa!

2. As submissões deverão ser realizadas no portal PREENCHER AQUI até as 12h do dia 20 de Abril de 2023. O resultado será divulgado no dia 26 de Abril de 2023.

## Conclusão

Nesta sessão você aprendeu a explorar alguns recursos do Analytics, e embarcou em uma aventura que premiará aquelas análises criadas com maior dedicação e criatividade. Boa sorte!


## Autoria

- **Autores** - Isabella Alvarez, Breno Comin, Thais Henrique
- **Último Update Por/Data** - Breno Comin, Abr/2023