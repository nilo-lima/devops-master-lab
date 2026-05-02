variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1" # Altere para sua região preferida
}

variable "instance_type" {
  description = "O tipo de instância EC2 a ser usado."
  type        = string
  default     = "t3.micro" # Tipo de instância elegível para o nível gratuito, ajuste conforme necessário
}

variable "key_pair_name" {
  description = "O nome do Key Pair da AWS para acesso SSH."
  type        = string
  default     = "test-key" # Altere para sua key-pair existente
}

variable "security_group_name" {
  description = "O nome do Security Group (apenas para referência/tags)."
  type        = string
  default     = "bia-dev" # Nome do seu Security Group, se existir
}

variable "security_group_id" {
  description = "O ID do Security Group existente a ser utilizado."
  type        = string
  default     = "sg-096b9bbbfcadc6254" # ID do seu Security Group, certifique-se de que este SG permite tráfego HTTP (porta 80) e SSH (porta 22) para a instância EC2
}

variable "ssm_iam_role_name" {
  description = "O nome da Role IAM existente para acesso SSM."
  type        = string
  default     = "role-acesso-ssm" # Nome da sua Role IAM para SSM
}
