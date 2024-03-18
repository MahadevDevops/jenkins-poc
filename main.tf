provider "aws" {
  region = "us-west-1" // Specify the AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-05c969369880fa2c2" // Specify the Linux AMI ID
  instance_type = "t2.micro" // Specify the instance type

  tags = {
    Name = "windows-instance"
  }

  // Specify the key pair name for SSH access
  key_name = "poc"

  // Specify the subnet ID where you want to launch the instance
  subnet_id = "subnet-944b93f2"

  // Specify the security group ID for the instance
  security_groups = ["sg-09a617aa4f6b5cccb"]

  // Optionally, you can specify the user data for customization
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello, Linux!"
    # Add Docker's official GPG key:
    sudo apt-get update -y
    sudo apt-get install ca-certificates curl -y
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  EOF
}
