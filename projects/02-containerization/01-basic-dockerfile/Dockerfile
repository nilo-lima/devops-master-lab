# Usa a imagem base oficial do Alpine Linux na versão mais recente.
FROM alpine:latest

# Define uma variável de ambiente padrão para o nome
ENV MY_NAME="Captain "

# O comando CMD agora usa a variável de ambiente.
# Usamos "sh -c" para permitir a expansão da variável MY_NAME dentro da string.
CMD ["sh", "-c", "echo \"Hello, ${MY_NAME}!\""]
