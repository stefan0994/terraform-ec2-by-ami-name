provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami           = data.aws_ami.packer.id
  
  tags = {
    Name = "${var.environment}-instance"
  }
}
