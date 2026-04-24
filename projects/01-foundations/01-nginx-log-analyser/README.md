# 📊 Nginx Log Analyser - Projeto de Fundamentos de Shell Scripting

## ✨ Propósito do Projeto

Este projeto consiste em um script shell simples para analisar logs de acesso do Nginx. O objetivo é extrair e apresentar as informações mais relevantes de forma sumarizada, como os IPs que mais requisitam, os caminhos mais acessados, os códigos de status de resposta mais comuns e os user agents predominantes. Ele serve como um exercício prático para o aprimoramento de habilidades em shell scripting e manipulação de texto via linha de comando.

## 🚀 Funcionalidades Principais

*   **Análise de Logs Nginx:** Processa arquivos de log de acesso do Nginx no formato padrão.
*   **Top 5 IPs:** Identifica os 5 endereços IP que realizaram o maior número de requisições.
*   **Top 5 Caminhos:** Lista os 5 caminhos (URLs) mais solicitados aos servidores.
*   **Top 5 Status Codes:** Apresenta os 5 códigos de status HTTP mais frequentes.
*   **Top 5 User Agents:** Detalha os 5 user agents (navegadores/clientes) mais utilizados.
*   **Saída Formatada:** Gera um relatório claro e fácil de ler, destacando as informações com contagens de requisições.

## 🛠️ Guia de Execução Passo a Passo

Este projeto é desenvolvido e testado em um ambiente Debian 12 provido por Vagrant. Para reproduzir e executar:


### 1. Clonar o Repositório Principal

Se você ainda não clonou o repositório `DevOps_Master_Lab`, comece por aqui:
```bash
git clone https://github.com/nilo-lima/DevOps_Master_Lab.git
cd DevOps_Master_Lab
```

### 2. Navegar até o Projeto

Acesse o diretório do projeto.

```bash
cd projects/01-foundations/01-nginx-log-analyser/app
```


### 4. Obter um Arquivo de Log de Exemplo (Opcional)

Para testar o script, você precisará de um arquivo de log de acesso do Nginx. Você pode gerar um ou baixar um exemplo. Para este projeto, o desafio original sugere um link para download. **Certifique-se de ter um arquivo de log chamado `access.log` no diretório `config/` do seu projeto ou ajuste o caminho ao executar.**

Você pode usar o `wget` para baixar um log de exemplo pelo link real:

```bash
cd ../config/

wget -O access.log https://gist.githubusercontent.com/kamranahmedse/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log

cd ../app/
```

*Dica: Você pode colocar o arquivo `access.log` dentro do diretório `projects/01-foundations/01-nginx-log-analyser/config/` para manter a organização.*


### 5. Executar o Script Analisador de Logs

Execute o script `nginx-log-analyser.sh` fornecendo o caminho para o arquivo de log como argumento.
```bash
./nginx-log-analyser.sh ../config/access.log
```


## 📈 Próximos Passos (Backlog / Evolução Técnica)

Este projeto pode ser expandido de várias maneiras:

*   **Argumentos de Linha de Comando:** Adicionar suporte para mais opções (ex: `-n` para número de resultados, `-o` para saída em JSON/CSV).
*   **Filtragem Avançada:** Implementar filtros por data/hora, status code específico, ou IPs.
*   **Dockerização:** Encapsular o script em um container Docker para maior portabilidade e reprodutibilidade.
*   **Visualização:** Integrar com ferramentas de visualização (ex: `gnuplot`) para gerar gráficos básicos a partir dos dados.
*   **Testes Unitários:** Adicionar testes para validar a saída do script com logs de amostra.

## 🧠 Lições Aprendidas

Durante o desenvolvimento deste projeto, foram reforçados conceitos importantes de shell scripting e manipulação de dados:

*   **Processamento de Texto com `awk`, `sed`, `grep`:** Prática na extração e transformação de dados de texto complexos.
*   **Pipelines Unix:** Utilização eficiente de pipes (`|`) para encadear comandos e processar dados em etapas.
*   **Contagem e Ordenação:** Uso de `sort`, `uniq -c`, e `head -n` para sumarizar e classificar informações.
*   **Validação de Entrada:** Implementação de verificações básicas para garantir a robustez do script (existência e permissão de leitura do arquivo).
*   **Argumentos de Script:** Manejo de argumentos para tornar o script reutilizável.
*   **Organização de Projetos:** Reforço da importância de uma estrutura de diretórios clara e de um `README.md` informativo.

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

This project is part of [roadmap.sh](https://roadmap.sh/projects/nginx-log-analyser) DevOps projects.
