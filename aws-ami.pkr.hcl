packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

data "amazon-ami" "az_ami" {
  filters = {
    virtualization-type = "hvm"
    name                = "amzn2-ami-kernel*"
    root-device-type    = "ebs"
  }
  owners      = ["137112412989"]
  most_recent = true
  region      = "${var.region}"
}

source "amazon-ebs" "basic-example" {
  region        = "${var.region}"
  source_ami    = data.amazon-ami.az_ami.id
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "myami_{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.basic-example"]
  provisioner "shell" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "hostname | sudo tee /var/www/html/index.html"
    ]
  }
}
