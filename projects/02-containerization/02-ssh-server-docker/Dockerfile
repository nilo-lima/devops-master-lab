# Usar uma imagem base Ubuntu LTS para estabilidade e pacotes atualizados.
FROM ubuntu:latest

# Atualizar o sistema e instalar o OpenSSH server, Fail2Ban e utilitários essenciais.
# A flag -y evita prompts interativos. A flag --no-install-recommends otimiza o tamanho da imagem.
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server fail2ban sudo && \
    rm -rf /var/lib/apt/lists/*

# Configurar o diretório para o serviço SSH.
RUN mkdir /var/run/sshd

# Criar um usuário não-root para conexões SSH e adicionar ao grupo sudo.
# Usar um UID/GID fixo pode ser útil em alguns cenários, mas para este projeto, deixaremos dinâmico.
# A senha é definida aqui, mas a autenticação será feita via chave SSH para segurança.
# O usuário 'devops' será o usuário padrão para acesso SSH.
ARG SSH_USER=devops
ARG SSH_PASSWORD=password
RUN useradd -rm -d /home/${SSH_USER} -s /bin/bash -g root -G sudo ${SSH_USER} && \
    echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# Configurar o SSH para aceitar apenas autenticação por chave e desabilitar login de root.
# Mudar a porta SSH padrão de 22 para 2222 para evitar varreduras comuns.
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
    echo 'Port 2222' >> /etc/ssh/sshd_config && \
    echo 'AllowUsers devops' >> /etc/ssh/sshd_config

# Expor a porta 2222 que configuramos para o SSH.
EXPOSE 2222

# Configurar o Fail2Ban.
# Copiar um arquivo de configuração jail.local personalizado.
# Mais tarde, você precisará criar este arquivo jail.local no seu diretório do projeto.
COPY jail.local /etc/fail2ban/jail.local

# Conceder permissões para que o Fail2Ban possa iniciar.
RUN chmod 644 /etc/fail2ban/jail.local

# Adicionar um script de inicialização para o SSH e Fail2Ban.
# Este script garante que ambos os serviços sejam iniciados quando o contêiner for executado.
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Definir o comando de entrada.
# Ao iniciar o contêiner, o script start.sh será executado.
CMD ["/usr/local/bin/start.sh"]
