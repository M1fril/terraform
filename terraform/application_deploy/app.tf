

resource "aws_security_group" "mongo_trafic" {
  name        = "mongo_server"
  description = "Allow mongo server traffic"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "DB"
    from_port   = 27017
    to_port     = 27017
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
    description = "Custom"
    from_port   = 9216
    to_port     = 9216
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
    Name    = "mongo_trafic"
    Creator = "Mp"
  }
}

resource "aws_network_interface" "mongo_server_nic" {
  subnet_id       = data.terraform_remote_state.networking.outputs.public_subnet1_id
  security_groups = [aws_security_group.mongo_trafic.id]

  tags = {
    Name    = "mongo_server_nic"
    Creator = "Mp"
  }
}

resource "aws_instance" "mongo_server" {
  ami                  = var.instance_ami
  iam_instance_profile = "EcrRegistryEC2"
  instance_type        = "t2.micro"
  key_name             = var.instance_key
  user_data            = file("mongo_setup.sh")

  network_interface {
    network_interface_id = aws_network_interface.mongo_server_nic.id
    device_index         = 0
  }
  tags = {
    Name    = "mongo_server"
    Creator = "Mp"
  }
}

resource "aws_security_group" "postgres_trafic" {
  name        = "postgres_server"
  description = "Allow postgres server traffic"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id


  ingress {
    description = "DB"
    from_port   = 5432
    to_port     = 5432
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
    description = "Custom"
    from_port   = 9187
    to_port     = 9187
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
    Name    = "postgres_trafic"
    Creator = "Mp"
  }
}

resource "aws_network_interface" "postgres_server_nic" {
  subnet_id       = data.terraform_remote_state.networking.outputs.public_subnet2_id
  security_groups = [aws_security_group.postgres_trafic.id]

  tags = {
    Name    = "postgres_server_nic"
    Creator = "Mp"
  }
}

resource "aws_instance" "postgres_server" {
  ami           = var.instance_ami
  instance_type = "t2.micro"
  key_name      = var.instance_key
  user_data     = file("postgres_setup.sh")

  network_interface {
    network_interface_id = aws_network_interface.postgres_server_nic.id
    device_index         = 0
  }
  tags = {
    Name    = "postgres_server"
    Creator = "Mp"
  }
}

resource "aws_ecr_repository" "repository" {
  name = "mp_repository"

  tags = {
    Name    = "mp_repository"
    Creator = "Mp"
  }
}

