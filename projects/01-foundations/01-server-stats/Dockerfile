FROM alpine:3.19

# Instalação do Bash e procps para métricas precisas
RUN apk add --no-cache bash procps

WORKDIR /app

COPY server-stats.sh .

RUN chmod +x server-stats.sh

CMD ["/bin/bash", "./server-stats.sh"]
