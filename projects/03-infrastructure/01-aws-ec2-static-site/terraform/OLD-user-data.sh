#!/bin/bash
#

# Atualiza o sistema e instala dependências necessárias
sudo apt-get update -y
sudo apt-get upgrade -y

# Instala Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu # Adiciona o usuário 'ubuntu' ao grupo docker

# Cria diretório para o site e docker-compose.yml
mkdir -p /home/ubuntu/static-site
cd /home/ubuntu/static-site

# Cria o index.html (conteúdo simples para user-data)
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Site Estático com Nginx (User Data)</title>
    <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #e0ffe0;
                    color: #222;
                    text-align: center;
                    padding: 50px;
                }
                h1 {
                    color: #007bff;
                }
                p {
                    font-size: 1.1em;
                }
            </style>
</head>
<body>
            <h1>Bem-vindo ao Meu Site Estático (User Data)!</h1>
            <p>Este site foi implantado via user-data e está sendo servido por Nginx em Docker.</p>
            <p>DevOps Master Lab - Projeto AWS EC2 Instance</p>
</body>
</html>
EOF

# Cria o Dockerfile para o Nginx (user-data)
cat <<EOF > Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Cria o docker-compose.yml (user-data)
cat <<EOF > docker-compose.yml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "80:80"
    restart: always
    container_name: static-site-nginx-user-data
    volumes:
      - ./app/index.html:/usr/share/nginx/html/index.html # Monta o arquivo index.html
EOF

# Inicia o serviço Docker Compose
sudo docker compose up -d
