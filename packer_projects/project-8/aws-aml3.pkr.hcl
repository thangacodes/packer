packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.4"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "amazon-ebs" "aml3" {
  profile       = "vault_admin"
  ami_name      = "my-custom-packer-image"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-0c50b6f7dc3701ddd"
  ssh_username  = "ec2-user"
}

build {
  name    = "my-custom-image"
  sources = ["source.amazon-ebs.aml3"]

  provisioner "shell" {
    inline = [
      "echo Sleeping for 120 seconds to ensure the EC2 machine is available/running on the EC2 dashboard..",
      "sleep 120",
      "echo Updating yum repository",
      "sudo yum update -y",
      "echo Installing tree binary...",
      "sudo dnf install -y tree",
      "echo Installing nginx package...",
      "sudo dnf install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo dnf install firewalld -y",
      "sudo systemctl enable --now firewalld",
      "sudo firewall-cmd --zone=public --add-port=80/tcp --permanent",
      "sudo firewall-cmd --zone=public --add-port=443/tcp --permanent",
      "sudo firewall-cmd --reload"
    ]
  }

  post-processor "vagrant" {}
  post-processor "compress" {}
}
