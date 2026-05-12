output "public_ip" {
  description = "IP público da EC2 (Elastic IP)"
  value       = aws_eip.nodejs.public_ip
}

output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.nodejs.id
}

output "ssh_command" {
  description = "Comando SSH para acesso direto ao servidor"
  value       = "ssh -i ~/.ssh/<sua-chave>.pem ubuntu@${aws_eip.nodejs.public_ip}"
}
