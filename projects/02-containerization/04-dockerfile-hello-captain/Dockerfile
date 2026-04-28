# Usa a imagem oficial do Alpine Linux como base
FROM alpine:latest

# Define um argumento de build para o nome do usuário.
# O valor padrão é "Capitão" se nenhum for fornecido durante a construção.
ARG USER_NAME="Capitão"

# Define uma variável de ambiente no contêiner com o valor do argumento USER_NAME.
# Isso torna o nome acessível para o comando CMD.
ENV GREETING_NAME=${USER_NAME}

# Define o comando a ser executado quando o contêiner iniciar.
# Agora, ele usa a variável de ambiente GREETING_NAME.
CMD ["sh", "-c", "echo Olá, ${GREETING_NAME}!"]
