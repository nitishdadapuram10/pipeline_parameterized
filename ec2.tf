resource "aws_instance" "my_private-ec2" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id]


  user_data = <<-EOF
              #!/bin/bash
              sudo yum install httpd -y
              echo "Welcome to Cloud" | sudo tee /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOF

  tags = {
    Name = "Private_Instance"
  }
}

