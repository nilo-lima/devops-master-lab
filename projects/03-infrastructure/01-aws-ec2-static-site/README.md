# 🚀 Projeto: AWS EC2 Instance com Site Estático Dockerizado

Este projeto demonstra o provisionamento de uma instância EC2 na AWS usando Terraform e a implantação de um site estático simples servido por Nginx em um contêiner Docker. O acesso à instância é configurado via SSH e, para maior segurança e gerenciamento, via AWS Systems Manager (SSM).

## 🎯 Objetivo

O principal objetivo deste projeto é fornecer experiência prática em:
*   Criação de recursos básicos da AWS (EC2, Security Groups, IAM Instance Profiles) usando Infrastructure as Code (IaC) com Terraform.
*   Configuração e bootstrap de instâncias EC2 com scripts `user-data`.
*   Dockerização de aplicações (Nginx servindo conteúdo estático).
*   Gerenciamento de serviços Docker com Docker Compose.
*   Acesso seguro a instâncias Linux via SSH e AWS Systems Manager (SSM).
*   Compreensão de tipos de instância, AMIs e grupos de segurança da AWS.

## 🏛️ Arquitetura

A arquitetura descreve o fluxo de provisionamento e implantação:

```mermaid
graph TD
    subgraph Desenvolvedor Local
        A[AWS CLI Configuradas] --> B{Terraform Apply};
        B --> C[Arquivos Terraform (.tf)];
        C --> D[Conteúdo do Site Estático (HTML)];
        C --> E[Dockerfile/Docker Compose];
    end

    subgraph AWS Cloud
        F[VPC Padrão] --> G[Sub-rede Padrão];
        G --> H[Security Group: bia-dev];
        H --> I[EC2 Instance: t3.micro, Ubuntu];
        I -- Atribui --> J[Elastic IP (ou Public IP)];
        I -- key-pair --> K[test-key];
        I -- iam-role --> L[role-access-ssm];
        L --> M[Instance Profile];
        I -- user-data --> N[Instala Docker, Docker Compose, Implanta Site];
        N -- Docker Compose --> O[Container Nginx];
        O -- Serve --> D;
        J --> P[Acesso HTTP/S para Site];
        K --> Q[Acesso SSH];
        M --> R[Acesso SSM];
    end

    P --> S[Navegador do Usuário];
    Q --> T[Terminal do Usuário];
    R --> T;
```

**Explicação:** A partir do ambiente local do desenvolvedor, os arquivos Terraform orquestram o provisionamento na AWS. Uma instância EC2 `t3.micro` (Ubuntu) é lançada na VPC padrão, associada a um Security Group (`bia-dev`) para tráfego HTTP/SSH e um IAM Instance Profile (`role-access-ssm`) para acesso SSM. Um script `user-data` na EC2 automatiza a instalação do Docker e Docker Compose, e a implantação do site estático via Nginx dockerizado. O site é acessível via IP Público/DNS, e a instância, via SSH ou SSM.

## 🧠 Justificativa das Decisões Técnicas

1.  **Uso de Terraform (IaC):**
    *   **Porquê:** Garante que a infraestrutura seja definida como código, promovendo reprodutibilidade, versionamento, e automação consistente do provisionamento na AWS. Essencial para ambientes profissionais e escaláveis.

2.  **AWS EC2 t3.micro com AMI Ubuntu Server:**
    *   **Porquê:** `t3.micro` é elegível para o nível gratuito da AWS, tornando o aprendizado acessível. Ubuntu Server é uma escolha robusta e amplamente documentada para servidores Linux.

3.  **VPC e Sub-rede Padrão:**
    *   **Porquê:** Para este projeto de aprendizado, simplifica a configuração de rede, permitindo foco nos recursos principais da EC2 e da aplicação. Em produção, uma VPC personalizada seria preferível.

4.  **Security Group Existente (`bia-dev` - `sg-096b9bbbfcadc6254`):**
    *   **Porquê:** Utiliza um recurso de rede já existente, evitando duplicação e garantindo consistência com a infraestrutura do usuário. O Terraform o busca pelo ID e o associa à instância. As regras (SSH na porta 22, HTTP na porta 80, ambos abertos para `0.0.0.0/0`) são para acessibilidade inicial, mas devem ser mais restritivas em produção.

5.  **Key Pair Existente (`test-key`):**
    *   **Porquê:** Permite acesso SSH tradicional e seguro à instância, utilizando uma chave já gerenciada pelo usuário.

6.  **Acesso AWS Systems Manager (SSM) com Role (`role-access-ssm`):**
    *   **Porquê:** Aumenta significativamente a segurança e a capacidade de gerenciamento. O SSM permite acesso à instância (via Session Manager) sem a necessidade de abrir a porta 22 no Security Group ou gerenciar chaves SSH diretamente, além de fornecer recursos de automação e auditoria. A `role-access-ssm` (que deve ter as permissões de SSM configuradas) é associada à instância via um IAM Instance Profile.

7.  **User Data para Bootstrap da Instância:**
    *   **Porquê:** Automatiza completamente a instalação de pré-requisitos (Docker, Docker Compose) e a implantação inicial da aplicação durante a inicialização da instância, garantindo um ambiente pronto para uso sem intervenção manual.

8.  **Dockerização do Nginx para Servir o Site Estático:**
    *   **Porquê:** Empacota o servidor web Nginx e o conteúdo do site em um contêiner Docker. Isso oferece portabilidade, isolamento e consistência, garantindo que o ambiente da aplicação seja o mesmo em desenvolvimento e produção.

9.  **Docker Compose para Gerenciamento de Contêineres:**
    *   **Porquê:** Simplifica a definição e o gerenciamento de serviços Docker. O `docker-compose.yml` permite que o Nginx seja construído e executado com um único comando (`docker-compose up -d`), configurando portas e volumes de forma declarativa.

10. **IP Público Atribuído Automaticamente:**
    *   **Porquê:** Essencial para que o site estático seja acessível pela internet e para que o usuário possa se conectar à instância via SSH.

## 🚀 Como Executar o Projeto

Siga estes passos para configurar e executar o projeto na sua conta AWS.

### Pré-requisitos

*   Conta AWS configurada.
*   AWS CLI configurada localmente com credenciais.
*   Terraform instalado localmente (versão 1.0 ou superior).
*   Docker e Docker Compose instalados localmente (para desenvolvimento/teste local, opcional, mas recomendado).
*   Um Key Pair da AWS chamado `test-key` na região de destino.
*   Um Security Group da AWS com ID `sg-096b9bbbfcadc6254` (nome "bia-dev") permitindo acesso SSH (porta 22) e HTTP (porta 80) de `0.0.0.0/0`.
*   Uma Role IAM chamada `role-access-ssm` com as permissões necessárias para o AWS Systems Manager (ex: política gerenciada `AmazonSSMManagedInstanceCore`).

### Estrutura de Pastas

```
projects/03-infrastructure/01-aws-ec2-static-site/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── user-data.sh
├── app/
│   └── index.html
└── Dockerfile         # Dockerfile para o site estático (local)
└── docker-compose.yml # Docker Compose para o site estático (local)
└── .gitignore
```

### 1. Preparação Local dos Arquivos

1.  **Crie a estrutura de pastas e os arquivos:**
    *   Crie o diretório do projeto:
        ```bash
        mkdir -p projects/03-infrastructure/01-aws-ec2-static-site/terraform
        mkdir -p projects/03-infrastructure/01-aws-ec2-static-site/app
        ```
    *   Crie o arquivo `projects/03-infrastructure/01-aws-ec2-static-site/app/index.html` com o conteúdo fornecido no passo a passo anterior.
    *   Crie o arquivo `projects/03-infrastructure/01-aws-ec2-static-site/Dockerfile` com o conteúdo fornecido no passo a passo anterior (Dockerfile local, que será usado para a construção da imagem, se desejar testar localmente).
    *   Crie o arquivo `projects/03-infrastructure/01-aws-ec2-static-site/docker-compose.yml` com o conteúdo fornecido no passo a passo anterior (docker-compose local).
    *   Crie os arquivos `projects/03-infrastructure/01-aws-ec2-static-site/terraform/main.tf`, `variables.tf`, `outputs.tf` e `user-data.sh` com os conteúdos **ATUALIZADOS** fornecidos nos nossos passos anteriores. **É crucial que o `user-data.sh` contenha a versão final corrigida para a instalação do Docker Compose e o layout do conteúdo.**
    *   Crie o arquivo `projects/03-infrastructure/01-aws-ec2-static-site/.gitignore` com o conteúdo fornecido anteriormente.

2.  **Revise `terraform/variables.tf`:** Verifique se a `aws_region`, `key_pair_name`, `security_group_id` e `ssm_iam_role_name` estão configuradas corretamente para o seu ambiente AWS.

### 2. Implantação com Terraform

1.  **Navegue até o diretório Terraform:**
    ```bash
    cd projects/03-infrastructure/01-aws-ec2-static-site/terraform
    ```
2.  **Inicialize o Terraform:**
    ```bash
    terraform init
    ```
3.  **Visualize o plano de execução:**
    ```bash
    terraform plan
    ```
    *   Revise cuidadosamente as mudanças propostas.

4.  **Aplique as mudanças:**
    ```bash
    terraform apply
    # Digite 'yes' quando solicitado para confirmar.
    ```

### 3. Verificação

1.  **Acesse o Site:** Após o `terraform apply` ser concluído, copie o `public_ip` (ou `public_dns`) do output e cole no seu navegador. Você deverá ver o site estático servido pelo Nginx em Docker.
2.  **Conecte via SSH:**
    ```bash
    ssh -i "path/to/test-key.pem" ubuntu@<SEU_IP_PUBLICO>
    ```
    *   Substitua `<SEU_IP_PUBLICO>` pelo IP fornecido pelo Terraform.
    *   Certifique-se de que `test-key.pem` tenha as permissões corretas (`chmod 400 test-key.pem`).
3.  **Conecte via AWS Systems Manager (SSM Session Manager):**
    *   No Console da AWS, navegue até **EC2 > Instâncias**.
    *   Selecione a instância `Web-Server-Static-Site`.
    *   Clique em **Conectar** e selecione a aba **Session Manager**.
    *   Clique em **Conectar**. Você deverá ser capaz de acessar um terminal na instância sem usar SSH Key Pair.

### 4. Limpeza de Recursos

Para evitar custos indesejados, é fundamental destruir os recursos da AWS após o uso:

1.  **Navegue até o diretório Terraform:**
    ```bash
    cd projects/03-infrastructure/01-aws-ec2-static-site/terraform
    ```
2.  **Destrua os recursos:**
    ```bash
    terraform destroy
    # Digite 'yes' quando solicitado para confirmar.
    ```

---

## 🎯 Metas ambiciosas FASE 02

*   Criar um pipeline de CI/CD simples usando GitHub Actions para implantar automaticamente as alterações em seu site.

## 📚 Resultados de Aprendizagem

Ao concluir este projeto, você terá adquirido experiência prática em:
*   Criação de recursos básicos da AWS (EC2, Security Groups, IAM Roles/Profiles).
*   Compreensão sobre instâncias da AWS, seus tipos e diferenças.
*   Iniciando e configurando instâncias EC2 com `user-data`.
*   Conectando-se a servidores Linux usando SSH e SSM.
*   Administração básica de servidores e configuração de servidores web com Docker/Nginx.
*   Implantação de sites estáticos em infraestrutura de nuvem usando Terraform e Docker Compose.

---

## 💖 Apoie este Projeto Open Source

Se você gosta dos meus projetos, considere:
- 🏆 Me indicar para o GitHub Stars [Indicar Aqui](https://stars.github.com/nominate/)
- ⭐ Dar uma estrela nos repositórios
- 🐛 Reportar bugs ou melhorias
- 🤝 Contribuir com código

---

## ⚖️ Licença

Distribuído sob a licença **Apache 2.0**. Esta licença oferece permissão para uso, modificação e distribuição, além de garantir proteção contra disputas de patentes para colaboradores e usuários. Veja o arquivo [LICENSE](LICENSE) para mais informações.

---

This project is part of [roadmap.sh](https://roadmap.sh/devops) DevOps projects.
