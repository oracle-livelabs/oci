# Criar Dashboards - Avançado

## Introdução

Neste Lab você vai dar um passo a mais no desenvolvimento de suas análises utilizando funcionalidades avançadas que o Oracle Analytics Cloud (OAC) oferece para você para enriquecer ainda mais seus insights.

[Oracle Video Hub video scaled to Large size](videohub:1_6oeev9ax:large)

*Tempo estimado para o Lab:* 25 Minutos

### Objetivos
* Aprender a adicionar estatísticas em seu gráficos
* Aprender a criar regras de formatação condicional
* Aprender a adicionar filtros no seu dashboard
* Aprender a criar "Ações de dados"
* Aprender a utilizar imagens como filtros para seu dados


## Tarefa 1: Adicionar Estatísticas no Dashboard

O Oracle Analytics Cloud (OAC) te oferece uma forma muito simples de adicionar estatísticas em seus gráficos. Os tipos disponíveis são: *Clusters, Outliers, Linha de Referência, Linha de Tendência, Previsão (Forecast)*

1. Crie uma nova tela no seu arquivo de trabalho clicando no sinal de **+** na parte inferior da tela.

![Criar nova tela](./images/add-canva-1.png)

2. Em seguida vamos renomear essa tela, clique no triangulo ao lado do nome da tela e clique em renomear.

![Clique em renomear](./images/rename-canva-2.png)

3. Digite o nome **"Avançado"** e clique no sinal de check para confirmar.

![Renomear Tela para Avançado](./images/rename-advanced-3.png)

4. Segure a tecla Control (CTRL) e selecione os campos **Vendas** e **Data do pedido (Mês)** dentro da tabela "Vendas", arraste e solte no centro da tela.

![Criar gráfico de vendas por mês](./images/forecast-4.png)

Você vai notar que um gráfico de Linha será criado automaticamente. Aqui nós iremos criar uma previsão de vendas para os próximos 3 meses.

5. Clique com o botão direito do mouse no gráfico, em seguida selecione **"Adicionar Estatísticas"** e selecione **"Previsão"**.

![Adicionar Previsão](./images/add-forecast-5.png)

Após alguns segundo você a previsão de vendas para os próximos 3 meses adicionada ao seu gráfico. A previsão é a área em cinza claro.

![Verificar a previsão](./images/see-forecast-6.png)

Agora nos vamos adicionar um a Linha de Referência no mesmo gráfico que criamos a previsão.

6. Clique com o botão direito do mouse no gráfico, em seguida selecione **"Adicionar Estatísticas"** e selecione **"Linha de Referência"**.

![Adicionar Linha de Referência](./images/reference-line-7.png)

Após alguns segundo você verá a Linha de Referência em seu gráfico

![Ver Linha de Referência](./images/see-reference-line-8.png)

> **Note:** Como mostrado nos passos anteriores podemos combinar mais de um tipo de estatística em um mesmo gráfico.

*DESAFIO:* Crie mais um gráfico com as informações de Vendas por Data do Pedido (Mês) e adicione a estatística de **"Outliers"** nesse gráfico para você identificar os valores que estão fora do padrão de vendas

Esse deve ser seu resultado final:

![Resultado da Linha de Referência](./images/outliers-9.png)

## Tarefa 2: Formatação Condicional

Use a Formatação Condicional para destacar dados importantes em suas visualizações para que você possa tomar melhores decisões.

1. Na aba de Tipos de Gráfico, clique a arraste o tipo "Tabela Dinâmica" e solte na parte inferior da tela quando uma barra verde aparecer.

![selecione tabela dinâmica](./images/chart-type-16.png)

2. Segurando o Control (CTRL) selecione os campos: **Vendas**, **Data do Pedido (Mês)** e **Categoria do Produto**, em seguida arraste os 3 campos para o gráfico de tabela dinâmica que você adicionou no dashboard no passo anterior.

![adicione os campos na tabela dinâmica](./images/din-table-17.png)

3. Verifique se o campo "Categoria do Produto" está em baixo do campo "Data do Pedido (Mês)" na área de linhas da Tabela Dinâmica.

![verificar campos](./images/din-table-18.png)

4. Clique com o botão direito do mouse sobre a tabela dinâmica, selecione "Formatação Condicional" e clique em "Manage Rules".

![adicionar Formatação Condicional](./images/cond-form-19.png)

5. Dê o nome *"Vendas por Periodo"* para a nova regra e em seguida selecione "Vendas" no campo Medida.

![Dê nome para a regra](./images/cond-form-20.png)

Agora vamos adicionar cores especificas de acordo com a variação do valor de vendas:

6. Preencha os campos de acordo com as informações abaixo e clique em salvar

* ***VENDAS >  60.000 - Cor: Verde Escuro***
* ***VENDAS <= 60.000 - Cor: Verde Claro***
* ***VENDAS <  40.000 - Cor: Amarelo***
* ***VENDAS <  35.000 - Cor: Vermelho***

![Regras da Formatação Condicional](./images/rules-form-21.png)

Você vai notar que cada valor de venda possui uma cor associada e dessa forma você consegue visualizar as informações de forma mais agradável e facilmente identificar informações como, por exemplo, os valores em vermelho que indicam valores de vendas abaixo do esperado.

![Resultado das regras da Formatação Condicional](./images/cond-form-22.png)


## Tarefa 3: Adicionar Filtros

Temos algumas formas de adicionar filtros no Oracle Analytics Cloud. Nessa tarefa vamos adicionar filtros através da barra de filtros e vamos aprender a tornar esse filtro disponível em todas as telas do nosso Dashboard.

A barra de filtro fica na parte superior da tela, todos os filtros criados ficaram disponíveis nesse local.

![Barra de Filtro](./images/filter-bar-23.png)

1. Clique no sinal de + na barra de filtro e selecione o campo "DATA DO PEDIDO" na tabela de Vendas.

![Cline sinal de 'Mais' adicione DATA DO PEDIDO](./images/filter-date-24.png)

2. Clique novamente no sinal de + e agora selecione o campo "EMBALAGEM DO PRODUTO" na tabela de Vendas.

![Cline sinal de 'Mais' adicione EMBALAGEM DO PRODUTO](./images/filter-package-25.png)

Você pode adicionar os filtros de acordo com suas necessidade de analisar as informações nessa tela.

![Verifique os filtros](./images/check-filter-37.png)

Agora vamos tornar o filtro visível e aplicado em todas as Telas do seu Arquivo de Trabalho.

3. Descanse o cursor do mouse sobre o filtro "DATA DO PEDIDO" até que você veja o ícone de "fixar" ser destacado e clique sobre ele.

![Localize o ícone de fixar](./images/pin-filter-36.png)

Você pode navegar para qualquer aba do seu Dashboard e o filtro "DATA DO PEDIDO" estará fixado.

![Verifique o filtro fixado em todos as telas](./images/pin-filter-37.png)


## Tarefa 4: Ações de Dados (Data Actions)

Você pode usar Ações de Dados (Data Actions) para se conectar a outras telas no OAC e aplicar o dado selecionado como filtro, URLs externas, relatórios do Oracle Analytics Publisher e usar em contêineres externos.

Vamos utilizar as Ações de Dados para analisar mais profundamente os dados de vendas onde a localização é "Bahia".

1. Clique nos 3 pontinho na parte superior direita da tela e selecione "Ações de Dados"

![Selecione Data Actions](./images/data-actions-31.png)

2. Em seguida clique no sinal de + para criar uma nova Ações de Dados

![Crie uma Data Actions](./images/data-actions-32.png)

3. Preencha os campos com as informações abaixo e depois clique em **OK**:

**Nome:** *Detalhes*
**Tipo:** *Link de Análise*
**Destino:** *Esta Pasta de Trabalho*
**Link para Tela:** *Detalhe*
**Informar valores:** *Tudo*
**Suportar Várias Seleções:** *Ativado*

![Preencha os campos - Data Actions](./images/data-actions-33.png)

Agora toda vez que você clicar com o botão direito do mouse sobre algum dado que você queria explorar mais (em seu Dashboard atual) você verá a Ações de Dados que acabamos de criar pronta para ser usada.

5. Clique com o botão direito sobre o ponto referente a **Novembro de 2014** no gráfico "Vendas por Data do Pedido (Mês), Outliers", localize a Ações de Dados "Detalhes" que acabamos de criar e clique nela.

![Use a Data Actions](./images/data-actions-34.png)

Você será direcionado para a Tela **Detalhe** onde você poderá facilmente explorar outras informações associadas ao ponto "Novembro de 2014" que havíamos selecionado anteriormente. Tudo isso porque a "Ações de Dados" além de ter te redirecionado para essa nova tela também criou um filtro com o parâmetro "Novembro 2014" já selecionado

![Entendendo Data Actions](./images/data-actions-35.png)

Esse deve ser o seu resultado final:

![Mudando de tela - Data Actions](./images/data-actions-36.png)

## Tarefa 5: Utilizar Imagens como Filtro (Opcional)

Existe um outra maneira de se criar filtros no Oracle Analytics Cloud (OAC): ***Criar Filtros através de Imagens***

> **Nota:** É necessário ter a permissão: BI Service Administrator para executar essa tarefa.

1. Faça download desse imagem: [Imagem para criar o Filtro](https://objectstorage.us-ashburn-1.oraclecloud.com/p/k4myBTiFdp22kJ_7rJw6kbZa7YLfqrh8nKVzPnrnn-dOAZuxKIB8RKDWTYAmt8eU/n/id3kyspkytmr/b/bucket-fast-track/o/ModoEnviocomTexto.png).

2. Clique no Menu do lateral superior esquerda e acesse **"Console"**.

![Navegue até console](./images/image-filter-26.png)

3. Acesse a opção "Mapas".

![Clique em Mapas](./images/image-filter-27.png)

4. Clique na aba "Planos de Fundo", expanda a opção "Planos de Fundo de Imagem" e clique em **"Adicionar Imagem"**.

![Clique em Adicionar imagem](./images/image-filter-28.png)

5. Localize a imagem que você acabou de fazer o upload, clique nos 3 pontinhos do lado esquerdo da linha e clique em **"Inspecionar"**

![Clique nos 3 pontinho e selecione Inspecionar](./images/image-filter-42.png)

6. Preencha os campos com as informações abaixo e clique em **Salvar**:

**Nome:** *Modos de Envio*
**Descrição:** *Imagem representando os modos de envio disponíveis*

![Preencha as informações](./images/image-filter-29.png)

6. Localize a imagem que você acabou de fazer o upload, clique nos 3 pontinhos do lado esquerdo da linha e clique em **"Criar Camada de Mapas"**

![Clique em criar camada de mapa](./images/image-filter-30.png)

Agora será necessário mapear as áreas de imagem e vincular cada mapeamento a cada termos usado para os modos de envio disponíveis em nossos dados.

7. Selecione o tipo de desenho para "Retângulo". Faça 1 quadrado em volta da imagem do Avião (Voô Regular) e escreva o termo "Vôo Regular"

![Desenhe um retângulo em volta da imagem do primeiro Avião](./images/image-filter-38.png)

8. Faça 1 quadrado em volta da imagem do caminhão (Caminhão de Entrega) e escreva o termo "Caminhão de Entrega"

![Desenhe um retângulo em volta da imagem do caminhão](./images/image-filter-39.png)

9. Faça 1 quadrado em volta da imagem do Avião (Voô Regular) e escreva o termo "Vôo Expresso"

![Desenhe um retângulo em volta da imagem do segundo Avião](./images/image-filter-40.png)

10.  Quando toda imagem estiver mapeada clique em salvar (Ícone de disquete no canto superior direito da tela).

![Salve o mapeamento](./images/image-filter-41.png)

Volte para seu "Arquivo de Trabalho" para adicionar o imagem mapeada para ela atuar como filtro. No nosso exemplo vamos adicionar a imagem a uma das tela do projeto atual da Miau Corp.

11. Navegue até a aba de Tipos de Gráficos, localize o gráfico de Mapa e arraste ele até a parte superior do seu canvas. (Abaixo do Campo de Texto)

![Selecione o tipo de gráfico de Mapa](./images/image-filter-43.png)

12. Em seguida adicione o campo "MODO DE ENVIO" que está na tabela "Pedidos".

![Adicione a coluna Modo de Envio](./images/image-filter-44.png)

Você verá a imagem que mapeamos anteriormente. Agora vamos utilizar a imagem com um filtro dentro dessa tela do nosso dashboard.

13. Descanse o cursor do mouse sobre o nome do gráfica até um ícone de funil aparecer na tela e clique sobre ele.

![Clique no ícone de funil](./images/image-filter-45.png)

Pronto! Toda vez que você quiser ver seus dados de vendas com base no método de envio basta clicar sobre a área correspondente na imagem.

![Clique na imagem e veja o filtro aplicado](./images/image-filter-46.gif)

Parabéns, você terminou esse laboratório!
Você pode **seguir para o próximo Lab**.

## Conclusão

Nesta sessão você aprendeu a utilizar recursos avançados para criação de Dashboards no Oracle Analytics Cloud (OAC)

## Autoria

- **Autores** - Thais Henrique, Isabella Alvarez, Breno Comin, Isabelle Dias, Guilherme Galhardo
- **Último Update Por/Date** - Guilherme Galhardo, Mar/2023