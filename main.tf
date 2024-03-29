provider "aws" {
  region = "us-west-1" // Specify the AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-05c969369880fa2c2" // Specify the Linux AMI ID
  instance_type = "t2.micro" // Specify the instance type
  iam_instance_profile = "ec2-role-poc"
  tags = {
    Name = "Linux-instance"
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
    # adding index html file
    sudo mkdir -p /home/ubuntu/web
    cat <<EOT >> /home/ubuntu/web/index.html
     <html lang="en">
     <body>
       <h2>Hello from Nginx container of jenkins poc</h2>
     </body>
     </html>
    EOT
    #Install Docker
    # Add Docker's official GPG key:
    sudo apt-get update -y
    #install aws cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt install unzip -y
    unzip awscliv2.zip
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
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
    #Install OWASPZAP
    echo 'deb http://download.opensuse.org/repositories/home:/cabelo/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/home:cabelo.list
    curl -fsSL https://download.opensuse.org/repositories/home:cabelo/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_cabelo.gpg > /dev/null
    sudo apt update -y
    sudo apt install owasp-zap -y
  EOF
}
