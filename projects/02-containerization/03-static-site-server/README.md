# 🌐 Servidor de Site Estático com Nginx, Docker e Rsync

## 🚀 Visão Geral do Projeto

Este projeto guia a configuração de um servidor web básico para hospedar um site estático. Utilizando Docker para isolamento do ambiente, Nginx como servidor web de alta performance e Rsync para automação de deployments, este setup visa proporcionar uma compreensão prática dos conceitos fundamentais de web serving e automação em DevOps.

### 🎯 Objetivos de Aprendizado

*   **Containerização:** Criar e configurar um servidor Linux dentro de um container Docker.
*   **Acesso Seguro:** Estabelecer e gerenciar conectividade SSH com o container.
*   **Web Serving:** Instalar e configurar Nginx para servir conteúdo estático.
*   **Conteúdo:** Criar uma página web simples com HTML, CSS e um arquivo de imagem local.
*   **Deployment Automatizado:** Utilizar Rsync para sincronizar arquivos do site estático para o servidor e um script `deploy.sh` para automatizar o processo.
*   **Configuração Nginx:** Configurar o Nginx para servir o site estático a partir do endereço IP do servidor.

## 🏛️ Arquitetura Proposta

O diagrama a seguir ilustra a arquitetura do projeto, mostrando a interação entre a máquina local do desenvolvedor, o ambiente Docker e o servidor Nginx dentro do container.

```mermaid
graph TD
    A[Usuário Local (Máquina Host)] -->|Desenvolve Site Estático & Script deploy.sh| B(Docker Engine no Host)
    B -->|Cria e Gerencia Container| C[Container Docker (Servidor Linux)]
    C -->|Mapeamento de Portas (22 p/ SSH, 80 p/ HTTP)| B
    C -->|Instala Nginx & Configura| D[Servidor Nginx]
    D -->|Serve Conteúdo de| E[Arquivos do Site Estático (HTML, CSS, Imagens)]
    A -->|Rsync via SSH (acionado por deploy.sh)| C
    F[Navegador Cliente] -->|Requisição HTTP (Host IP:80)| B
    B -->|Mapeamento de Porta| C
    C -->|Servido por Nginx| E
```

## 🧠 Justificativa das Decisões Técnicas

1.  **Docker Container para o Servidor Linux:**
    *   **Porquê:** Proporciona um ambiente leve, isolado e consistente para o servidor web. Isso garante que o projeto seja reprodutível em qualquer máquina com Docker, minimizando problemas de "funciona na minha máquina". Facilita a gestão de dependências e a configuração do ambiente, alinhando-se com as práticas modernas de desenvolvimento e operações.
    *   **Benefício de Aprendizado:** Demonstra o poder da containerização para encapsular aplicações e seus ambientes, um conceito fundamental em DevOps.
2.  **Nginx como Servidor Web:**
    *   **Porquê:** Escolhido por sua eficiência, alta performance e baixa utilização de recursos, o Nginx é uma excelente opção para servir conteúdo estático. É amplamente utilizado na indústria e sua configuração é relativamente simples para casos de uso básicos.
    *   **Benefício de Aprendizado:** Permite ao usuário aprender sobre as configurações essenciais de um servidor web, como `server blocks` e roteamento de requisições.
3.  **SSH para Acesso Remoto e Rsync:**
    *   **Porquê:** O SSH (Secure Shell) é o protocolo padrão para acesso seguro a máquinas remotas, essencial para gerenciamento e automação. O Rsync é uma ferramenta robusta para sincronização de arquivos, ideal para deployments incrementais de sites estáticos, pois transfere apenas as diferenças entre os arquivos, tornando o processo rápido e eficiente.
    *   **Benefício de Aprendizado:** Reforça a importância da segurança no acesso remoto e introduz uma ferramenta poderosa para gerenciamento de arquivos em deployments.
4.  **Script `deploy.sh`:**
    *   **Porquê:** Centraliza e automatiza o processo de deployment. Um script shell simples garante que a sincronização seja executada de forma consistente, reduzindo a chance de erros manuais e padronizando o fluxo de trabalho.
    *   **Benefício de Aprendizado:** Introduz o conceito de automação via scripting, uma habilidade crucial para otimizar operações repetitivas em DevOps.
5.  **Site Estático Básico (HTML, CSS, Imagens):**
    *   **Porquê:** Mantém o foco do projeto na infraestrutura e no processo de deployment, sem a complexidade adicional de linguagens de backend, frameworks ou bancos de dados.
    *   **Benefício de Aprendizado:** Permite ao usuário concentrar-se nas ferramentas e conceitos de DevOps, em vez da lógica da aplicação web.

## 🛠️ Pré-requisitos

*   Docker e Docker Compose instalados na sua máquina local.
*   Conhecimento básico de linha de comando Linux.
*   Um editor de texto ou IDE de sua preferência.

## 🚀 Como Executar o Projeto

1.  **Clone o Repositório:** (Se ainda não o fez)

    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd DevOps_Master_Lab/projects/02-containerization/03-static-site-server
    ```

2.  **Crie a Imagem Docker:**

    ```bash
    docker compose build
    ```

3.  **Inicie o Container:**

    ```bash
    docker compose up -d
    ```

4.  **Gere Chaves SSH (Se ainda não as tem):**
    *   Na sua máquina local, gere um par de chaves SSH. Deixe a passphrase em branco para simplificar este exercício, mas **use uma passphrase forte em produção**.

    ```bash
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa_static_server -C "static_site_server_key"
    ```

5.  **Adicione a Chave Pública ao Dockerfile:**
    *   Abra `Dockerfile` e localize a linha que contém `GENERATED_PUBLIC_SSH_KEY_HERE`.
    *   Substitua `GENERATED_PUBLIC_SSH_KEY_HERE` pelo conteúdo da sua chave pública (`~/.ssh/id_rsa_static_server.pub`).

    ```bash
    cat ~/.ssh/id_rsa_static_server.pub
    # Copie a saída e cole no Dockerfile.
    ```

    *   **Reconstrua a Imagem (após adicionar a chave pública):**

    ```bash
    docker compose build
    docker compose up -d
    ```

6.  **Execute o Script de Deployment:**
    *   Certifique-se de que o caminho da chave SSH no `deploy.sh` está correto (ex: `/home/administrador/.ssh/id_rsa_static_server`).
    *   Torne o script executável e execute-o:

    ```bash
    chmod +x deploy.sh
    ./deploy.sh
    ```

7.  **Acesse o Site:**
    *   Abra seu navegador e acesse `http://localhost/`.

## 🧹 Limpeza

Para parar e remover o container e a rede criada pelo Docker Compose:

```bash
docker compose down
```

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