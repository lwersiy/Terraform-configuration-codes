# # resource "github_repository" "werso_repo" {
# #   name = var.github_repository
# # }


# # Create the VPC
# resource "aws_vpc" "LouisVPC" {
#   cidr_block = var.vpc_cidr_block
#   tags = {
#     Name = var.vpc_name
#   }
# }

# # Create a public subnet
# resource "aws_subnet" "public_subnet" {
#   vpc_id            = aws_vpc.LouisVPC.id
#   cidr_block        = var.public_subnet_cidr_block
#   availability_zone = var.availability_zone[0] # Change this to your desired availability zone
#   tags = {
#     Name = var.vpc_name
#   }
# }

# # Create a private subnet
# resource "aws_subnet" "private_subnet" {
#   vpc_id            = aws_vpc.LouisVPC.id
#   cidr_block        = var.priv_subnet_cidr_block
#   availability_zone = var.availability_zone[0] # Change this to your desire AZ
#   tags = {
#     Name = var.priv_subnet_name
#   }

# }

# # Create an internet gateway
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.LouisVPC.id
#   tags = {
#     name = var.internet_gateway
#   }
# }

# # Create the public route table
# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.LouisVPC.id


#   tags = {
#     Name = var.pub_route_table_name
#   }
# }

# # Create a default route to an internet gateway for public internet access
# resource "aws_route" "public_internet_gateway_route" {
#   route_table_id         = aws_route_table.public_route_table.id
#   destination_cidr_block = var.destination_cidr_block # Route all traffic (0.0.0.0/0) to the internet gateway

#   gateway_id = aws_internet_gateway.gw.id
# }


# # Associate the public route table with the public subnet
# resource "aws_route_table_association" "public_subnet_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# # # Create the Elastic IP (EIP)
# # resource "aws_eip" "nat_gateway_eip" {
# #   vpc = var.vpc_eip[0] # Specify "true" for an EIP in a VPC; "false" for an EIP in EC2-Classic
# # }

# # # Create the NAT Gateway
# # resource "aws_nat_gateway" "nat_gateway" {
# #   allocation_id = var.allocation_id_nat
# #   subnet_id     = aws_subnet.public_subnet.id  # Replace this with the ID of your public subnet

# #   tags = {
# #     Name = var.Nat_gateway_name
# #   }
# # }

# # Create the private route table
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.LouisVPC.id

#   tags = {
#     Name = var.private_route_table_name
#   }
# }


# # # Create a default route to the NAT Gateway for private internet access
# # resource "aws_route" "private_nat_gateway_route" {
# #   route_table_id         = var.priv_route_table_id
# #   destination_cidr_block = var.destination_cidr_block  # Route all traffic (0.0.0.0/0) to the NAT Gateway

# #   nat_gateway_id = var.nat_gateway_id
# # }


# # # Associate the private route table with the private subnet
# # resource "aws_route_table_association" "private_subnet_association" {
# #   subnet_id      = aws_subnet.private_subnet.id
# #   route_table_id = var.priv_route_table_id
# # }


# # Create a security group for SSH access
# resource "aws_security_group" "ssh_sg" {
#   name        = var.security_group_names[0]
#   description = var.security_group_descriptions[0]
#   vpc_id      = aws_vpc.LouisVPC.id

#   ingress {
#     from_port   = var.ports[0]
#     to_port     = var.ports[0]
#     protocol    = var.protocol[0]
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Egress rule allowing all outbound traffic to any IP address
#   egress {
#     from_port   = var.ports[2]
#     to_port     = var.ports[2]
#     protocol    = var.protocol[1] # The protocol "-1" means all protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Create a security group for HTTP access
# resource "aws_security_group" "http_sg" {
#   name        = var.security_group_names[1]
#   description = var.security_group_descriptions[1]
#   vpc_id      = aws_vpc.LouisVPC.id


#   ingress {
#     from_port   = var.ports[1]
#     to_port     = var.ports[1]
#     protocol    = var.protocol[0]
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Egress rule allowing all outbound traffic to any IP address
#   egress {
#     from_port   = var.ports[2]
#     to_port     = var.ports[2]
#     protocol    = var.protocol[1]# The protocol "-1" means all protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Create a security group for 8081 access
# resource "aws_security_group" "jenkins_sg" {
#   name        = var.security_group_names[2]
#   description = var.security_group_descriptions[2]
#   vpc_id      = aws_vpc.LouisVPC.id

#   # Ingress rule allowing all traffic from any IP address
#   ingress {
#     from_port   = var.ports[2]            # This represents all ports (from 0 to 65535)
#     to_port     = var.ports[2]            # This represents all ports (from 0 to 65535)
#     protocol    = var.protocol[1]          # This represents all protocols
#     cidr_blocks = ["0.0.0.0/0"] # Allow all IP addresses
#   }

#   # Egress rule allowing all outbound traffic to any IP address
#   egress {
#     from_port   = var.ports[2] 
#     to_port     = var.ports[2] 
#     protocol    = var.protocol[1] # The protocol "-1" means all protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }



# # Output the VPC ID and subnet ID
# output "vpc_id" {
#   value = aws_vpc.LouisVPC.id
# }

# output "public_subnet_id" {
#   value = var.pub_subnet_id
# }

# # Create and ec2 instance in a public subnet
# resource "aws_instance" "Nexus" {
#   ami                         = var.ami[0]
#   instance_type               = var.instancetype[1]
#   subnet_id                   = aws_subnet.public_subnet.id
#   associate_public_ip_address = var.associate_public_ip_address[0]
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]



#   # Pass the user data as a script
#   #   user_data = <<-EOT
#   # #!/bin/bash

#   # EOT




#   tags = {
#     Name = "Nexus"
#     Env  = "Dev"
#   }

# }


# resource "aws_instance" "Jenkins" {
#   ami                         = var.ami[1]
#   instance_type               = var.instancetype[0]
#   subnet_id                   = aws_subnet.public_subnet.id
#   associate_public_ip_address = var.associate_public_ip_address[0]
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id, aws_security_group.jenkins_sg.id]



#   # Pass the user data as a script
#   user_data = <<-EOT
# #!/bin/bash
# sudo yum update -y
# sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# #Removing old RPM Keys
# #sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# #sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# sudo yum upgrade -y
# sudo amazon-linux-extras install java-openjdk11 -y
# sudo yum install jenkins -y
# sudo systemctl enable jenkins
# sudo systemctl start jenkins

# # Installing Git
# sudo yum install git -y
# ###

# # Use The Amazon Linux 2 AMI When Launching The Jenkins VM/EC2 Instance
# # Instance Type: t2.medium or small minimum
# # Open Port (Security Group): 8080 
# EOT
#   tags = {
#     Name = var.instance-name-tags[0]
#     Env  = "Dev"
#   }

# }



# resource "aws_instance" "werso-instance" {
#   ami                         = var.ami[0]
#   instance_type               = var.instancetype[0]
#   subnet_id                   = aws_subnet.public_subnet.id
#   associate_public_ip_address = var.associate_public_ip_address[0]
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]



#   # Pass the user data as a script
#   user_data = <<-EOT
# #!/bin/bash
# sudo su
# yum update -y
# yum install -y httpd
# systemctl start httpd
# systemctl enable httpd
# echo "<h1> <body bgcolor=pink>
# Hello Awesome Tower Batch!
# Today we are Learning about Elastic Load Balancers.
# This message is coming to you from $(hostname -f)
# Do remember me? If not it is OK, I will remind you.
# You just configured me.</h1>">/var/www/html/index.html

# EOT

#   tags = {
#     Name = var.instance-name-tags[1]
#     Env  = "Dev"
#   }

# }


# resource "aws_instance" "SonarQube" {
#   ami                         = var.ami[0]
#   instance_type               = var.instancetype[0]
#   subnet_id                   = aws_subnet.public_subnet.id
#   associate_public_ip_address = var.associate_public_ip_address[0]
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]

#   tags = {
#     Name = var.instance-name-tags[2]
#     Env  = "Dev"
#   }

#   #     user_data = <<-EOT
#   #     #!/bin/bash

#   # EOT


# <<<<<<< HEAD:main.tf
# }
# =======
  
# }
# >>>>>>> 73a41777632b374ed9f69f46907eeab662b01e46:mainnnn.tf
