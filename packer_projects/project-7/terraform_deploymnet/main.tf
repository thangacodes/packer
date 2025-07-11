data "aws_ami" "myami" {
  most_recent = true
  owners      = ["282526987315"]

  filter {
    name   = "name"
    values = ["APACHE_AMAZONLINUX2_OS"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.myami.id
}

### VM creation
resource "aws_instance" "web" {
  ami                    = data.aws_ami.myami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0fb1052b659369aa8"]
  key_name               = var.keypair
  tags                   = var.tag_name
}
