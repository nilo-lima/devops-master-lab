# Define o provedor AWS e a região
provider "aws" {
  region = var.aws_region
}
# Carrega o script user-data
data "local_file" "user_data_script" {
  filename = "${path.module}/user-data.sh"
}

# Procura a AMI do Ubuntu mais recente
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # Pode ser necessário ajustar a versão do Ubuntu
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Busca o Security Group existente pelo ID fornecido
data "aws_security_group" "existing_web_access_sg" {
  id = var.security_group_id
}

# Define a VPC padrão (ainda necessário para buscar informações, mesmo que não seja usado para criar o SG)
data "aws_vpc" "default" {
  default = true
}

# Busca a Role IAM existente para SSM
data "aws_iam_role" "ssm_role" {
  name = var.ssm_iam_role_name
}

# Cria um Instance Profile para associar a Role SSM à instância EC2
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm-ec2-instance-profile"
  role = data.aws_iam_role.ssm_role.name
}


# Cria a instância EC2
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  vpc_security_group_ids = [data.aws_security_group.existing_web_access_sg.id] # Usa o SG existente
  user_data              = data.local_file.user_data_script.content
  tags = {
    Name = "Web-Server-Static-Site"
  }

  # Adiciona o Instance Profile à instância EC2
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
}
