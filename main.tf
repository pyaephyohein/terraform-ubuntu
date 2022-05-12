terraform {
  required_providers{
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.27"
      }
  }
  required_version = ">= 0.14.9" 
}

provider "aws" {
    profile = "default"
    region = "ap-southeast-1"
}

resource "aws_instance" "your instance name" {
  ami = "ami-04bdbc2d7a6c7c6dd" ##ubuntu 20.04
  instance_type = "t2.micro"
  key_name = "your-key-name"
  tags = {
  Name = "your instance name"
}
provisioner "remote-exec" {
    inline = [
      "sudo apt install apache2 -y" ##apache2 install
    ]
  }
connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("your_private_key")
      timeout     = "4m"
   }
}

resource "aws_key_pair" "your_key_name" {
  key_name   = "your_key_name"
  public_key = "your_public_key"
}