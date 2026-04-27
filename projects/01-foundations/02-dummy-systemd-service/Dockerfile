# Uss uma imagem base leve do Debian, que é a mesma base da VM Vagrant
FROM debian:stable-slim

# Metadados do mantenedor da imagem
LABEL maintainer="Nilo Lima Jr <nilo.lima@gmail.com>" \
      description="Imagem Docker para o serviço dummy do Systemd" \
      version="1.0"

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app
#
# Copia o script dummy.sh para o diretório de trabalho do contêiner
COPY app/dummy.sh .
#
# Garante que o script seja executável dentro do contêiner
RUN chmod +x dummy.sh

# Garante que o diretório de log exista, assim como o script dummy.sh faria
# (isso é para compatibilidade, o logging principal será para o stdout do contêiner)
RUN mkdir -p /var/log/

# Define o comando que será executado quando o contêiner iniciar
# Utilizar exec para garantir que o processo bash seja o PID 1 do contêiner
CMD ["./dummy.sh"]
