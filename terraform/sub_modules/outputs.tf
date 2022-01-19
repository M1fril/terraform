output "zabbix_ip" {
  value = aws_instance.zabbix_server.public_ip
}

output "monitoring_ip" {
  value = aws_instance.monitoring_server.public_ip
}

