resource "aws_instance" "my_private_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id]


  user_data = <<-EOF
              
              
              echo "Welcome to Cloud" | sudo tee /var/www/html/index.html
              
              EOF

  tags = {
    Name = "Private_Instance"
  }
}

