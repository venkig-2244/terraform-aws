# EC2 public IP
output "ec2_public_ip" {
  value = aws_instance.webserver_ec2.public_ip
  description = "Webserver EC2 instance public IP"
}

# EC2 public DNS name
output "ec2_public_dns" {
  value = aws_instance.webserver_ec2.public_dns
  description = "Webserve EC2 instance public DNS"
}
