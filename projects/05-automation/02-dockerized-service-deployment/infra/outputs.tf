output "instance_public_ip" {
  description = "IP público da EC2 (Elastic IP)"
  value       = aws_eip.main.public_ip
}

output "ssh_command" {
  description = "Comando SSH para acessar a instância"
  value       = "ssh -i ../${var.project_name}.pem ubuntu@${aws_eip.main.public_ip}"
}

output "app_url" {
  description = "URL da aplicação"
  value       = "http://${aws_eip.main.public_ip}:3000"
}
