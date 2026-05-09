variable "aws_region" {
  description = "Região AWS para criação dos recursos"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Prefixo de nomenclatura para todos os recursos"
  type        = string
  default     = "iac-aws-ec2"
}
