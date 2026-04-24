#!/bin/bash

# Iniciar o serviço SSH
/usr/sbin/sshd

# Iniciar o serviço Fail2Ban
# Usar um PID file para o fail2ban no contêiner
/usr/bin/fail2ban-client -D

# Manter o contêiner rodando em primeiro plano
# Isso é importante para que o contêiner não saia após iniciar os serviços
tail -f /var/log/auth.log
