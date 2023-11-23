# Preparar um Conjunto de dados

## Introdução

Após a conexão com o banco e seleção das tabelas, neste lab você vai aprender a preparar seu Conjunto de Dados (Dataset) no Oracle Analytics Cloud, trazendo dados externos, enriquecendo a análise e realizando transformações preliminares à criação dos gráficos e visualizações

[Oracle Video Hub video scaled to Large size](videohub:1_87a9ge7u:large)

*Tempo estimado para o Lab:* 45 Minutos

### Objetivos
* Complementar os dados com arquivos externos
* Configurar localizações geográficas nos dados
* Ajustar colunas para nossas análises
* Criar novos campos a partir de cálculos

## Task 1: Trazer um arquivo .xlsx externo

1. Faça o download do arquivo excel necessário para esse laboratório através [deste link](https://objectstorage.us-ashburn-1.oraclecloud.com/n/id3kyspkytmr/b/ArquivosPublicos/o/Tabela%20Clientes%20-%20v2.xlsx)

2. Abra o conjunto de dados **DADOS\_MIAU\_CORP**, que acabou de ser criado. Ele pode ser encontrado na página inicial do Analytics, conforme na imagem abaixo.

![Homepage Analytics](./images/homepage.png)

3. Uma vez no canvas de criação de visualizações, clique no **botão '+'** (que está localizado no lado direito da tela, próximo às fontes de dados), e selecione **Adicionar Dados...**

![Adicionar Dados](./images/adicionar-dados.png)

3. Clique em **Criar Conjunto de Dados**. Perceba que ao fazer isso será criada uma nova aba no seu navegador. Realizaremos os passos 4 a 7 nela e depois voltaremos para a aba original em que estávamos trabalhando.

![Criar Conjunto de Dados](./images/criar-conjunto.png)

4. Arraste o arquivo **Tabela Clientes - v2.xlsx** para a janela que foi aberta ou clique no ícone indicado e indique a localização do arquivo no seu computador.

![Arrastar Arquivo Excel](./images/arquivo-excel.png)

5. O Analytics carregará e processará seu arquivo, trazendo um preview de quais as colunas presentes nele. Neste passo não é necessário realizar alterações. Clique em **OK**.

![Preview Arquivo Excel](./images/preview-arquivo.png)

6. **Salve** seu progresso através do ícone do disquete e **dê um nome** para seu novo conjunto de dados.
![Salvar Progresso](./images/renomear-arquivo.png)
![Renomear Arquivo](./images/salvar-arquivo.png)

7. Garanta que o novo conjunto do dados está salvo e **feche a aba em que estamos trabalhando** (que foi criada no passo 3). Volte para a aba anterior e você verá que o conjunto de dados recém-criado já está em evidência. Selecione-o e clique em **Adicionar à Pasta de Trabalho**

![Adicionar à Pasta de Trabalho](./images/adicionar-pasta.png)

8. Agora já temos os dados do excel disponíveis em nosso projeto, mas a barra horizontal entre os conjuntos de dados indica que não há nenhuma junção entre os dados do banco e os do excel, o que nos impede de cruzá-los. Para resolver isso, navegue até a aba **Dados**.

![Alterar Aba Dados](./images/aba-dados.png)

9. Leve o seu mouse até a região entre as duas fontes de dados e você verá uma linha tracejada conectando os dois, com o valor 0. **Clique nessa conexão**.

![Conexão 2 Datasets](./images/clique-conexao.png)

10. Selecione **Adicionar Outra Correspondência**.

![Adicionar Correspondência](./images/adicionar-correspondencia.png)

11. Relacione os dois arquivos através da chave comum entre eles (ID Cliente & ID DO CLIENTE). Após fazê-lo, clique no botão **OK**.

![Fazer Join Pelo ID](./images/join-cliente.png)

12. Você deverá ver que agora o numeral 1 surgiu entre as bases. Isso indica que elas estão unidas através de um Join que leva em consideração uma coluna em cada base.

![Join Realizado](./images/join-realizado.png)

13. Volte para a aba **Visualizar** e valide se a barra horizontal entre os conjuntos de dados desapareceu. Se isso aconteceu, essa tarefa está pronta. Não se esqueça de salvar o seu projeto para não perder o seu progresso.

![Alterar Aba Visualizar](./images/aba-visualizar.png)

## Task 2: Configurar as Localizações no Conjunto de Dados

Em nossa segunda tarefa realizaremos a configuração das colunas que referenciam localizações geográficas para que tragam informações mais detalhadas e possam ser utilizadas na construção dos nossos mapas posteriormente.

1. Navegue até a aba **Dados** e selecione o botão para **Editar** o arquivo **Clientes**, que acabamos de carregar.

![Editar Cliente](./images/dados-editar-cliente.png)

2. Todas as colunas estão corretamente identificadas como Atributos, portanto não será necessária qualquer alteração nesse aspecto. Selecione e coluna **Cidade** e note que do lado direito há uma série de sugestões de melhorias para ela. Clique na opção **Enriquecer Cidade com Province**.

![Enriquecer Cidade](./images/enriquecer-cidade.png)

3. O Analytics irá se utilizar de suas bibliotecas internas para trazer o estado de cada uma das cidades indicadas, criando uma nova coluna chamada Cidade_Province.

![Cidade e Estado](./images/cidade-province.png)

4. Na coluna Cidade_Province clique nos três pontos e selecione a opção **Renomear...**

![Renomear Cidade](./images/renomear-cidade.png)

5. Dê o nome **Estado** para essa coluna e salve essa alteração. Também é possível renomear uma coluna realizando um **duplo-clique** no nome dela e escrevendo o novo nome desejado para ela.

![Renomear Estado](./images/estado-edit.png)

6. Selecione mais uma vez a coluna **Cidade** e agora clique nas recomendações **Enriquecer Cidade com Lat e Long**. Renomeie-as para **Latitude e Longitude**.

![Enriquecer com Latitude e Longitude](./images/lat-long.png)

7. Clique no três pontos nas novas colunas (Latitude e Longitude) e selecione **Detalhes do Local...**

![Detalhes do Local](./images/detalhes-local.png)

8. Escolha o **Tipo do Local** adequado e clique em **OK**

![Tipo do Local](./images/tipo-local.png)

9. Valide que as novas colunas estão identificadas como localizações.

![Colunas de localização](./images/localizacoes.png)

10. Selecione mais uma vez a coluna **Cidade** e agora clique na recomendação **Enriquecer Cidade com Population**.

![Enriquecer Cidade com População](./images/enriq-cidade.png)

11. Valide que a coluna **População da Cidade** foi criada. Se isso aconteceu corretamente, a segunda tarefa foi concluída com sucesso.

![População da Cidade](./images/populacao-cidade.png)

## Task 3: Realizando alterações nas colunas

Agora realizaremos mais algumas adequações que simplificarão a maneira como vamos interagir com os dados na criação da nossa dashboard.

1. Na aba **Dados**, clique no botão para editar os dados da conexão com o banco.

![Alterar para Aba Dados](./images/aba-dados-2.png)

2. Navegue até **PEDIDOS** na aba inferior. No campo MODO DE ENVIO podemos notar que está faltando um acento nas modalidades 'Voo Regular' e 'Voo Expresso'. Vamos atualizar esses valores. Clique nos três pontos, e logo depois em **Substituir...**

![Substituir String](./images/substituir.png)

3. Preencha os formulários String para substituir com o valor **Voo** e Nova string com o valor **Vôo**. Isso incluirá o acento nos casos em que o valor Voo apareceu. Clique em **Adicionar Etapa** para que esse passo da transformação seja de fato realizado.

![Alterar String Voo para Vôo](./images/voo.png)

4. Salve para propagar essa mudança para todo o conjunto de dados.

![Salvar Mudanças](./images/salvar-propagar.png)

5. Agora realizaremos um agrupamento utilizando a interface do Analytics. Mude a aba inferior para a tabela de **VENDAS**, selecione a coluna **EMBALAGEM DO PRODUTO**, clique nos três pontos e escolha a opção **Agrupar**.

![Preparação de Dados - Agrupar](./images/agrupar.png)

6. Crie duas categorias:
  - Embalagens Grandes: terá dentro de si os valores Caixa Grande, Caixa Jumbo e Valor Jumbo;
  - Embalagens Pequenas: terá dentro de si os valores Caixa Média, Caixa Pequena, Pacote Pequeno e Saco de Embrulho.
  Após criados os grupos, certifique-se que você deu o nome **Tipos de Embalagem** para a nova coluna que será criada e clique em **Adicionar Etapa**.

![Tipos de Embalagem](./images/tipos-embalagem.png)

7. Para a próxima alteração criaremos um campo que será originado a partir de uma regra escrita na camada de preparação do OAC. Ainda na aba VENDAS, selecione a coluna LUCRO, clique nos três pontos e selecione **Criar**. Isso fará com que criemos uma nova coluna a partir da coluna Lucro.

![Criar Coluna Lucro](./images/criar-coluna-lucro.png)

8. Nomeie a nova coluna como **Lucro/Prejuízo** e escreva o código abaixo:
```
CASE WHEN LUCRO >= 0 THEN 'Lucro' ELSE 'Prejuízo' END
```
Não se esqueça de mapear a coluna Lucro (apenas o texto não irá se referenciar a ela).
Clique em **Adicionar Etapa** para salvar esse passo. Reproduza o processo no GIF abaixo para garantir que o processo será um sucesso.

![Criando Cálculo OAC](./images/gifft.gif)

Nossas colunas já estão com a classificação correta (Atributo/Métrica), mas as métricas podem ter diferentes formas de agregação (Soma, Média, Contagem...). Também é possível criar uma formatação para indicar que uma coluna é um valor de moeda em reais (R$), por exemplo.

9. Seleciona a coluna **VENDAS**, clique na área inferior esquerda no **#** e dentro do Formato do Número, selecione **Moeda**.

![Alterar Moeda](./images/moeda.png)

10. Escolha a opção que representa o real **(BRL/R$)**.

![Selecionar Real](./images/brl-rs.png)

11. Realize o mesmo processo para as colunas **LUCRO**, **DESCONTO** e **PREÇO BRUTO**.

![Repetir Processo para Lucro, Desconto e Preço Bruto](./images/lucro-desconto.png)

12. Selecione a coluna DESCONTO e desça até a **Agregação**. Selecione **Média**.  Agora a agregação dessa coluna foi alterada.

![Definir Agregação como Média](./images/agreg-media.png)

13. Salve mais uma vez o projeto para não perder seu progresso.

![Salvar o Projeto](./images/salve-novamente.png)

Parabéns, você terminou esse laboratório!
Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a preparar um Conjunto de Dados no Oracle Analytics Cloud, realizando uma série de transformações nos dados e complementando-os com informações externas disponíveis em um arquivo excel.

## Autoria

- **Autores** - Thais Henrique, Isabela Alvarez, Breno Comin, Isabelle Dias e Guilherme Galhardo
- **Último Update Por/Date** - Breno Comin, Mar/2023