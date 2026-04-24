# 01-nginx-log-analyser

## Descrição do Projeto
Este projeto tem como objetivo desenvolver um script shell para analisar logs de acesso do Nginx, extraindo e apresentando as 5 principais ocorrências de endereços IP, caminhos requisitados, códigos de status de resposta e user agents.

## Tecnologias Utilizadas
- Shell Scripting (Bash)
- Ferramentas de linha de comando: `awk`, `sort`, `uniq`, `head`, `grep`, `sed`

## Como Executar

### Pré-requisitos
- Um ambiente Linux/Unix com Bash e as ferramentas de linha de comando (`awk`, `sort`, `uniq`, `head`, `grep`, `sed`) instaladas.

### Passos para Execução

1.  **Navegue até o diretório do projeto:**
    ```bash
    cd projects/01-foundations/01-nginx-log-analyser/
    ```
2.  **Baixe o arquivo de log de exemplo (será fornecido nas próximas etapas).**
3.  **Torne o script executável:**
    ```bash
    chmod +x nginx-log-analyser.sh
    ```
4.  **Execute o script:**
    ```bash
    ./nginx-log-analyser.sh <caminho_para_seu_arquivo_de_log>
    ```

## Estrutura do Projeto
```
.
├── nginx-log-analyser.sh
├── README.md
└── .gitignore
```

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
