resource "aws_instance" "webserver_ec2" {
  ami = data.aws_ami.vm_image_template.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  user_data = file("${path.module}/app1-install.sh")

  vpc_security_group_ids = [
                              aws_security_group.vpc-ssh.id, 
                              aws_security_group.vpc-web.id
                           ]
  tags = {
            Name ="Webserver-ec2-instance"
         }

}