# Provisionar Recursos

## Introdução

Nesta etapa, você irá provisionar recursos dentro da OCI utilizando Terraform com o serviço **Resource Manager**!

- 🌀 [Página oficial do Resource Manager](https://www.oracle.com/br/devops/resource-manager/)
- 🧾 [Documentação do Resource Manager](https://docs.oracle.com/pt-br/iaas/Content/ResourceManager/home.htm)

Os recursos provisionados serão:

- OKE
- Artifact Registry
- Container Registry
- OCI DevOps
- APM
- API Gateway
- Streaming
- Object Storage
- Functions

Juntamente com recursos de Rede e Gerenciamento como:

- VCN
- Subnets
- Dynamic Groups
- Policies
- Compartments

- - -

## Task 1: Criação de compartimento

Como pré-requisito, é uma boa ideia criarmos um compartimento isolado para poder agrupar nossos recursos!

1. Para isso, faça o [login](https://www.oracle.com/cloud/sign-in.html) em sua conta na OCI.

2. No 🍔 menu de hambúrguer, acesse: **Identity & Security** → **Identity** → **Compartments**.

![menu identity security compartments](./images/create-compartments-console.PNG)

3. Na nova janela, clique em **Create Compartment**.

![botao create compartment](./images/create-compartment-button.PNG)

4. Insira um nome para o compartimento e também uma descrição. Feito isto, clique em **Create Compartment**.

![campo nome e descricao compartment](./images/create-compartment-descrition.PNG)

Excelente!!! Podemos agora iniciar com os passos do nosso lab!

- - -

## Task 2: Download do repositório

Como primeiro passo, devemos fazer o download do arquivo (zip) no repositório do github.

 1. Para isso, acesse o [repositório](https://github.com/CeInnovationTeam/terraform-dev-ft) e clique em **Download ZIP**.


![imagem git hub repositorio](./images/github-repository.PNG)

- - -

## Task 3: Upload do terraform no Resource Manager

1. Faça o [login](https://www.oracle.com/cloud/sign-in.html) em sua conta na OCI.

2. No 🍔 menu de hambúrguer, acesse: **Developer Services** → **Resource Manager** → **Stacks**.

![menu developer services stacks](./images/resource-manager-console.PNG)

3. Nesta nova janela, certifique que está no compartment "root" e clique em **Create Stack**.

![imagem compartment botao create stack](./images/create-stack.PNG)

4. Selecione a opção "Zip file", clique em "browse" e arraste o arquivo (.zip), que contém os arquivos .tf. O Resource Manager irá preencher todos os campos.

![imagem stack ](./images/configure-stack-archive-zip.PNG)

5. Clique em **Next**, para podermos configurar alguns parâmetros sobre os recursos a serem provisionados.

6. Nesta nova tela, lembre-se de selecionar o compartment criado, como abaixo.

![tela seleção compartment](./images/configure-stack-compartment.PNG)

7. Clique em **Next**.

8. Criada nossa stack, clique em **Apply** e confirme a ação.

![imagem botao apply](./images/confirm-action-create-stack.PNG)

9. O provisionamento dos recursos deverá durar em torno de 25 minutos.

10. Após finalizar o Apply com sucesso, podemos conferir o provisionamento dos nossos recursos!

### ✔ Ambientes provisionados com sucesso!!! Você provisionou recursos usando Terraform na OCI! 🚀

## Conclusão

Nesta sessão você aprendeu a como provisionar os recursos utilzando Terraform e Resource Manager!

## Reconhecimentos

- **Autores** - Andressa Siqueira, Debora Silva, Thais Henrique
- **Último Update Por/Date** - Andressa Siqueira Agosto/2023

