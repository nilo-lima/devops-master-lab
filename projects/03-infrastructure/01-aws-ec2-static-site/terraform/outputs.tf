output "public_ip" {
  description = "O endereço IP público da instância EC2."
  value       = aws_instance.web_server.public_ip
}
output "public_dns" {
  description = "O DNS público da instância EC2."
  value       = aws_instance.web_server.public_dns
}
