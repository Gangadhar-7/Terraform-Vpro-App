
module "ec2-ins-vpro" {
  # VERY VERY IMPORTANT else userdata webserver provisioning will fail
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.8.0"
  # insert the 10 required variables here
  name          = "vpro-app-container"
  ami           = "ami-06aa3f7caf3a30282" #data.aws_ami.new-created-ami.id
  instance_type = var.instance_type_list[1]
  tags = {
    "Name" = "Ec2-docker-vpro"
  }
  instance_count = 1
  key_name       = var.instance_keypair
  subnet_id = "subnet-086f15569e4d1d06f"
  vpc_security_group_ids = [
    aws_security_group.terraform-SG.id
  ]
  user_data = file("${path.module}/install.sh")
}

resource "null_resource" "name" {
  depends_on = [module.ec2-ins-vpro]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = "module.ec2-ins-vpro.public_ip"
    user        = "ec2-user"
    password    = ""
    private_key = file("./ADMIN_KEYPAIR.pem")
  }
  #   provisioner "file" {
  #     source      = "private-key/terraform-key.pem"
  #     destination = "/tmp/ADMIN_KEYPAIR.pem"
  #   }

  provisioner "remote-exec" {
    inline = ["wget https://raw.githubusercontent.com/devopshydclub/vprofile-project/docker/compose/docker-compose.yml",
    "docker compose up -d"]
  }

}
