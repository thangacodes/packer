packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.4"
      source  = "github.com/hashicorp/amazon"
    }
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "amazon-ebs" "aml3" {
  ami_name             = "my-custom-packer-image"
  instance_type        = "t2.micro"
  region               = "ap-south-1"
  source_ami           = "ami-0c50b6f7dc3701ddd"
  ssh_username         = "ec2-user"
  iam_instance_profile = "ec2-admin-role"
  tags = {
    "Name"           = "Packer-builder-instance"
    "Environment"    = "dev"
    "Owner"          = "Image_Team"
    "CreatedDate"    = "11/07/2025"
    "Packer_Version" = "Packer v1.13.1"
  }

  ami_tags = {
    "Name"        = "my-custom-packer-image-{{timestamp}}"
    "Environment" = "dev"
    "Owner"       = "admin@try-devops.xyz"
    "CreatedBy"   = "packer"
    "CreatedDate" = "11/07/2025"
  }
}

build {
  name    = "my-custom-image"
  sources = ["source.amazon-ebs.aml3"]

  provisioner "shell" {
    inline = [
      "echo Sleeping for 120 seconds to ensure the EC2 machine is available...",
      "sleep 120",
      "echo Updating yum repository...",
      "sudo yum update -y",
      "sudo dnf install -y tree awscli",
      "echo Installing Trivy...",
      "sudo curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin",
      "timestamp=$(date '+%Y-%m-%d_%H-%M-%S')",
      "report_file=\"/tmp/trivy-report-${timestamp}.txt\"",
      "echo Running Trivy filesystem vulnerability scan...",
      "sudo trivy fs --scanners vuln --skip-dirs /proc,/sys,/dev --exit-code 0 --format table --output $report_file /",
      "echo Trivy scan complete: $report_file",
      "echo Uploading the Trivy report to S3 bucket...",
      "aws s3 cp \"$report_file\" s3://gitops-demo-bucket-tf/scan_reports/ || { echo 'Upload failed'; exit 1; }",
      "echo Cross-checking whether the scan file is uploaded or not...",
      "aws s3 ls s3://gitops-demo-bucket-tf/scan_reports/ || { echo 'List failed'; exit 1; }",
      "echo Cleaning up the scan report stored in /tmp directory",
      "rm -rf \"$report_file\"",
      "echo Sleeping for 10 seconds before cleanup...",
      "sleep 10"
    ]
  }
  post-processor "vagrant" {}
  post-processor "compress" {}
}