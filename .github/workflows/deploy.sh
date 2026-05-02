name: Deploy Static Site to EC2

on:
  push:
    branches:
      - main # O workflow será acionado em pushes para a branch main
    paths: # <--- FILTRO DE CAMINHO ADICIONADO AQUI!
      - 'projects/03-infrastructure/01-aws-ec2-static-site/**' # Aciona apenas se houver mudanças dentro deste diretório
      - '.github/workflows/deploy.yml' # Também aciona se o próprio arquivo de workflow for modificado

jobs:
  deploy:
    runs-on: ubuntu-latest # O job será executado em um runner do Ubuntu

    steps:
    - name: Checkout repository code
      uses: actions/checkout@v4 # Faz o checkout do código do seu repositório

    - name: Set up SSH agent
      uses: webfactory/ssh-agent@v0.8.0
      with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }} # Usa a chave privada que você armazenou no GitHub Secrets

    - name: Install AWS CLI (if not present)
      run: |
        sudo apt-get update && sudo apt-get install -y awscli

    - name: Get EC2 Instance Public IP
      id: get_ip
      run: |
        aws configure set region ${{ vars.AWS_REGION || 'us-east-1' }} # Configura a região AWS
        # Usa o AWS CLI para obter o IP público da instância pelo nome da tag
        EC2_IP=$(aws ec2 describe-instances \
          --filters "Name=tag:Name,Values=Web-Server-Static-Site" \
          "Name=instance-state-name,Values=running" \
          --query 'Reservations[0].Instances[0].PublicIpAddress' \
          --output text)

        if [ -z "$EC2_IP" ]; then
          echo "Error: Could not retrieve EC2 instance IP. Ensure instance is running and tagged correctly."
          exit 1
        fi
        echo "EC2_IP=$EC2_IP" >> "$GITHUB_ENV"
        echo "EC2 Instance IP: $EC2_IP"
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
     }

    - name: Deploy to EC2
      run: |
        # Adiciona a chave SSH do host para evitar prompts de confirmação
        ssh-keyscan -H ${{ env.EC2_IP }} >> ~/.ssh/known_hosts
        chmod 600 ~/.ssh/known_hosts

        # Conecta via SSH e executa os comandos de deploy
        ssh -o StrictHostKeyChecking=no ubuntu@${{ env.EC2_IP }} << 'EOF'
          cd /home/ubuntu/static-site || exit 1 # Garante que o diretório exista
          git pull origin main # Puxa as últimas alterações do repositório
          sudo docker-compose build # Reconstrói a imagem Docker
          sudo docker-compose up -d # Reinicia o serviço
          echo "Deploy concluído na EC2."
        EOF
