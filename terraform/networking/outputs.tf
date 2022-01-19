output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-a.id
}

output "public_subnet2_id" {
  value = aws_subnet.public-b.id
}


output "sub_subnet_id" {
  value = aws_subnet.public_sub.id
}
