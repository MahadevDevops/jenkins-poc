output "ec2_public_IP" {
  value       = aws_instance.example.public_ip
  description = "Public IP of your EC2"
}