resource "aws_instance" "ec2_instance" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.security_group.id]
  associate_public_ip_address = true

  
  key_name = aws_key_pair.key_pair.key_name

  user_data = file("nginx.sh")

  tags = {
    Name = var.instance_name
  }
}
