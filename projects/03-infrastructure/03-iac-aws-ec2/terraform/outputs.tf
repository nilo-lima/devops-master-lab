output "instance_ip" {
  description = "Endereço IP público da instância EC2"
  value       = aws_eip.main.public_ip
}

output "private_key_path" {
  description = "Caminho local para a chave SSH privada"
  value       = local_sensitive_file.private_key.filename
}

output "ssh_command" {
  description = "Comando SSH pronto para uso"
  value       = "ssh -i ${local_sensitive_file.private_key.filename} ubuntu@${aws_eip.main.public_ip}"
}
