resource "aws_instance" "webserver_ec2" {
   ami = data.aws_ami.vm_image_template.id
   instance_type = var.instance_type
   # instance_type = var.instance_type_list[1]
   # instance_type = var.instance_type_map["prod"]
   key_name = var.instance_keypair
   user_data = file("${path.module}/app1-install.sh")

   vpc_security_group_ids = [
                                 aws_security_group.vpc-ssh.id, 
                                 aws_security_group.vpc-web.id
                              ]

   for_each = toset(keys({
                           for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
                           az => details.instance_types if length(details.instance_types) != 0 }))

   availability_zone = each.key
   tags = {
               Name ="Webserver-ec2-instance-${each.value}"
            }
}