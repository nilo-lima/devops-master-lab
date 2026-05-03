# 🗂️ Contexto do Projeto: Log Integrity Checker

## 📌 Informações do Projeto

| Campo           | Valor                                                                                         |
| :-------------- | :-------------------------------------------------------------------------------------------- |
| **Pilar**       | `01-foundations`                                                                              |
| **Nome**        | `03-log-integrity-checker`                                                                    |
| **Status**      | `concluído`                                                                                   |
| **Fonte**       | [roadmap.sh — File Integrity Checker](https://roadmap.sh/projects/file-integrity-checker)    |
| **Tecnologias** | Python 3.13, Docker, SHA-256, JSON                                                            |

## 🎯 Objetivo

Ferramenta CLI para detectar adulterações em arquivos de log via hashing SHA-256.
Comandos: `init` (baseline) | `check` (verifica) | `update` (legitima alteração).

## 📁 Estrutura

```text
03-log-integrity-checker/
├── app/integrity_checker.py   # CLI principal
├── config/hashes.json         # Gerado em runtime (gitignored)
├── logs/                      # Logs de demonstração
├── Dockerfile                 # Python 3.13-slim, user não-root
├── docker-compose.yml         # Volumes: logs (ro) + config (rw)
├── Makefile                   # init | check | update | reset | test | clean
├── .gitignore
└── README.md
```

## ✅ Fases

- [x] Fase 1: Estratégia & Design — APROVADA
- [x] Fase 2: Execução
- [x] Fase 3: Dockerização
- [x] Fase 4: Documentação & Publicação

## 🚀 Comandos Rápidos

```bash
make build    # Constrói a imagem
make init     # Cria baseline de hashes
make check    # Verifica integridade
make update   # Atualiza hash de arquivo legítimo
make reset    # Reinicializa (apaga hashes)
make test     # Demo completo automatizado
make clean    # Remove imagem e hashes
```
