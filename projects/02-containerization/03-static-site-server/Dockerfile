# Use uma imagem base Debian leve
FROM debian:stable-slim

# Metadados opcionais para descrever a imagem
LABEL maintainer="Nilo Lima Jr <nilo.lima@gmail.com>"
LABEL description="Servidor Linux com Nginx e SSH para site estático."

# Atualiza a lista de pacotes e instala Nginx, OpenSSH e Rsync
RUN apt-get update && \
    apt-get install -y nginx openssh-server rsync net-tools iproute2 && \
    rm -rf /var/lib/apt/lists/*

# --- Configuração do Nginx ---
# Remove a configuração padrão do Nginx
RUN rm /etc/nginx/sites-enabled/default
# Cria o diretório para o site estático
RUN mkdir -p /var/www/html
# Copia a configuração personalizada do Nginx para o local correto
COPY config/nginx.conf /etc/nginx/sites-available/default
# Cria um link simbólico para ativar a configuração
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# --- Configuração do OpenSSH ---
# Cria o diretório necessário para o sshd
RUN mkdir -p /var/run/sshd
# Permite login root para simplificar (NÃO recomendado para produção)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Desabilita o PAM para SSH (NÃO recomendado para produção)
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
# Cria um diretório .ssh para o usuário root e define permissões
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
# Adiciona a chave pública SSH do host ao authorized_keys do root
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCPjtXrs7j/YPHPJNw+2e3n8KtrRCwtBHmzH1/bzp6XvSXd8dm/sQyuMtW6VBQ60h3GucdeHw/x38qEew4efuK3LorPlVw2hT3tbPpuJF44xty9DAS/NOPZDSa2i5tE4a3NLyaEGESQYyLrc4L0tX02TgW5ko7f+n51AkAJAZC2oz/eU/gAUL6qApTO7FWwdq1xLh/rZWb0GrZAeaGXKOXoC6QSLMML8EUndRY9ZloulcQ2ijeYcBUMiAD6KSSva69WVxbe1Qw5/2OV9wanfLGBQAjqgQt0Kf9ENCKAjdb8bUKwGPIkB+HevQ7yuTS+SF9BcVdn+7eT8vsh2H2wqURR5PO8JvKq+vbotgzpykPWoUZ14DOJ3BL9DHn2BEmFrjJ79SWATuvgwdsmTzJ6/PF11++tnLkftIj/KkH1xmct990Oz3JaYJhfmRLJubUQ/7btvPkIbcn4rpZOpGSX7ofNoYthbpmVm14arOOLW+ae/REjiu3/SKDMSGUTHynLkXDPB6Y47nG2C9eKkQaSbJgJ3uailSsqVwS2awbmvh4Wu8KENR+a2W8x8lfhPopcDJb90JPcdpaM2J0wQCcEp6JIHa6TP12g5Vr/aqaBdCw1TVfW2AEStw3OC2LK0kc9i6XKw+b6IP4qMwpqKnsXirh6hpaRc7Xevs4WPRL3S+xuEQ== static_site_server_key" >> /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# A porta 22 é para SSH, a porta 80 é para HTTP
EXPOSE 22
EXPOSE 80

# Comando para iniciar SSH e Nginx quando o container é iniciado
CMD service ssh start && nginx -g "daemon off;"
