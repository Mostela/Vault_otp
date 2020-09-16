provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

resource "aws_instance" "vault_server" {
  ami = "ami-0edfed9d6e9a4031b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.joaoacer-key.key_name
  security_groups = [aws_security_group.vault_group.name]
  tags = {
      Name = "Vault_Server"
    }
}

resource "aws_instance" "vault_alvo" {
  depends_on = [aws_instance.vault_server]
  ami = "ami-0edfed9d6e9a4031b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.joaoacer-key.key_name
  security_groups = [aws_security_group.vault_group.name]
  tags = {
      Name = "Vault_alvo"
    }
}

resource "aws_key_pair" "joaoacer-key" {
  key_name = "joaoacer_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "vault_group"{
  name = "vault_group"
  ingress {
    description = "SSH Conexao"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Vault Server"
    from_port = 8200
    to_port = 8200
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Nginx Server"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vault_server_public_ip" {
  value = aws_instance.vault_server.public_ip
}

output "vault_alvo_public_ip" {
  value = aws_instance.vault_alvo.public_ip
}