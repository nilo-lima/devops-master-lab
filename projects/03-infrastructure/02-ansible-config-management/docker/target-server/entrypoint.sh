#!/bin/bash
set -e

if [ -f /tmp/pub_key ]; then
    mkdir -p /home/ansible/.ssh
    cp /tmp/pub_key /home/ansible/.ssh/authorized_keys
    chown -R ansible:ansible /home/ansible/.ssh
    chmod 700 /home/ansible/.ssh
    chmod 600 /home/ansible/.ssh/authorized_keys
fi

ssh-keygen -A

exec /usr/sbin/sshd -D
