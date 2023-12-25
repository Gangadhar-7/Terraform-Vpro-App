resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey" # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "chmod o+w /root/Integrations/Packer-Terraform-Integration/terraform-infra-code && touch myKey.pem && echo '${tls_private_key.pk.private_key_pem}' > myKey.pem && chmod 400 myKey.pem"
  }
}
