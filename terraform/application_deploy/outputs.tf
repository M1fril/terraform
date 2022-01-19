output "mpngo_ip" {
  value = aws_instance.mongo_server.public_ip
}

output "posrgers_ip" {
  value = aws_instance.postgres_server.public_ip
}
