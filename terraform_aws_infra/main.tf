# access default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# create jenkins server
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.medium"  
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = data.aws_subnets.default.ids[0]
  key_name               = var.ssh_keypair
  root_block_device {
    volume_size = 25 
    volume_type = "gp3"
    
  }
  user_data              = file("jenkins-userdata.tpl")                  
  tags = {
    Name = "Jenkins-server"
  }
}

# create sonarQube server
resource "aws_instance" "sonarqube_server" {
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.medium"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = data.aws_subnets.default.ids[0]
  key_name               = "ann-web-server"
  root_block_device {
    volume_size = 25 
    volume_type = "gp3"
    
  }
  user_data              = file("sonarQ-userdata.tpl")
  tags = {
    Name = "Sonarqube-server"
  }
}

