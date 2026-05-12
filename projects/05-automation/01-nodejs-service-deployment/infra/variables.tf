variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto, usado como prefixo nos recursos"
  type        = string
  default     = "nodejs-service"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Nome do Key Pair existente na AWS para acesso SSH"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR autorizado para SSH (use seu IP público)"
  type        = string
  default     = "0.0.0.0/0"
}
