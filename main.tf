provider "aws" {
  region = "us-west-1" // Specify the AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-08f5f3cd3a44fc3c4" // Specify the Windows AMI ID
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
    <powershell>
      # Insert your PowerShell commands here
      Write-Host "Hello, Windows!"
    </powershell>
  EOF
}
