FROM debian:12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    openssh-client \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/ansible-venv && \
    /opt/ansible-venv/bin/pip install --no-cache-dir "ansible==9.*"

ENV PATH="/opt/ansible-venv/bin:$PATH"

RUN ansible-galaxy collection install ansible.posix

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

WORKDIR /ansible
