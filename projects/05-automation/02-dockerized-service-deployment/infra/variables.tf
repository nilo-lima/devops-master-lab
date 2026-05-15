variable "aws_region" {
  description = "Região AWS para criação dos recursos"
  type        = string
  default     = "us-east-1"
  }

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Prefixo de nomenclatura para todos os recursos"
  type        = string
  default     = "dockerized-service"
}
