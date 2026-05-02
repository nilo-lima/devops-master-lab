#!/bin/bash
#

# Atualiza o sistema e instala dependências
sudo apt-get update -y
sudo apt-get upgrade -y

# Instala Docker
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu # Adiciona o usuário 'ubuntu' ao grupo docker

# Baixa e instala o Docker Compose diretamente
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Cria o diretório raiz do projeto e um subdiretório para o conteúdo estático
mkdir -p /home/ubuntu/static-site/app
cd /home/ubuntu/static-site

sudo chown -R ubuntu:ubuntu /home/ubuntu/static-site

# Cria o index.html dentro do novo diretório de conteúdo
cat <<EOF > app/index.html
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

# Cria o Dockerfile para o Nginx na raiz do projeto
cat <<EOF > Dockerfile
FROM nginx:alpine
# Copia todo o conteúdo do diretório 'app' para o diretório de serviço do Nginx
COPY app/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Cria o docker-compose.yml na raiz do projeto
cat <<EOF > docker-compose.yml
services:
  web:
    build: .
    ports:
      - "80:80"
    restart: always
    container_name: static-site-nginx
    volumes:
      - ./app/index.html:/usr/share/nginx/html/index.html # Monta o arquivo index.html
EOF

# Inicia o serviço Docker Compose
sudo docker-compose up -d
