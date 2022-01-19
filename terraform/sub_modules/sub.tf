resource "aws_security_group" "zabbix_trafic" {
  name        = "zabbix_server"
  description = "Allow zabbix server traficc"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom"
    from_port   = 10051
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "zabbix_trafic"
    Creator = "Mp"
  }
}

resource "aws_network_interface" "zabbix_server_nic" {
  subnet_id       = data.terraform_remote_state.networking.outputs.sub_subnet_id
  security_groups = [aws_security_group.zabbix_trafic.id]

  tags = {
    Name    = "zabbix_server_nic"
    Creator = "Mp"
  }
}

resource "aws_instance" "zabbix_server" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  key_name      = var.instance_key
  user_data            = file("zabbix_setup.sh")


  network_interface {
    network_interface_id = aws_network_interface.zabbix_server_nic.id
    device_index         = 0
  }

  tags = {
    Name    = "zabbix_server"
    Creator = "Mp"
  }
}

resource "aws_security_group" "monitoring_trafic" {
  name        = "monitoring_server"
  description = "Allow monitoring server traficc"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id


  ingress {
    description = "Custom"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "monitoring_trafic"
    Creator = "Mp"
  }
}

resource "aws_network_interface" "monitoring_server_nic" {
  subnet_id       = data.terraform_remote_state.networking.outputs.sub_subnet_id
  security_groups = [aws_security_group.monitoring_trafic.id]

  tags = {
    Name    = "monitoring_server_nic"
    Creator = "Mp"
  }
}

resource "aws_instance" "monitoring_server" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  key_name      = var.instance_key


  network_interface {
    network_interface_id = aws_network_interface.monitoring_server_nic.id
    device_index         = 0
  }

  tags = {
    Name    = "monitoring_server"
    Creator = "Mp"
  }
}
