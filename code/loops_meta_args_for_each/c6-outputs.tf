# EC2 public IP
output "ec2_public_ip" {
  value = toset([for instance in aws_instance.webserver_ec2: instance.public_ip])
  description = "Webserver EC2 instance public IP"
}

# EC2 public DNS name
output "ec2_public_dns" {
  value = toset([for instance in aws_instance.webserver_ec2: instance.public_dns])
  description = "Webserve EC2 instance public DNS"
}

output "ec2_public_dns_map" {
  value = tomap({ for az, instance in aws_instance.webserver_ec2: az => instance.public_dns})
}
# For loop with list
# output "for_loop_list" {
#   description = "For loop with list"
#   value = [for instance in aws_instance.webserver_ec2: instance.public_ip]
# }

# output "for_loop_map1" {
#   description = "For loop with map 1"
#   value = {for instance in aws_instance.webserver_ec2: instance.id => instance.public_ip}
# }

# output "for_loop_map2" {
#   description = "For loop with map 2 - advanced"
#   value = {for c, instance in aws_instance.webserver_ec2: c => instance.public_ip}
# }

# Legacy splat operator
# output "legacy_splat_instance_public_dns" {
#   description = "Legacy splat public DNS"
#   value = aws_instance.webserver_ec2.*.public_dns
# }

# # Generalized splat operator
# output "advanced_splat_instance_public_dns" {
#   description = "Latest splat public DNS"
#   value = aws_instance.webserver_ec2[*].public_dns
# }

