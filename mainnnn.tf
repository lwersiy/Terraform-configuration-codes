# resource "github_repository" "some_repo" {
#   name = "some-repo"
# }


# Create the VPC
resource "aws_vpc" "WersoVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "WersoVPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.WersoVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Change this to your desired availability zone
  tags = {
    Name = "PublicSubnet"
  }
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.WersoVPC.id
    cidr_block = "10.0.64.0/24"
    availability_zone = "us-east-1a" # Change this to your desire AZ
    tags = {
      Name = "PrivateSubnet"
    }
  
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.WersoVPC.id
  tags ={
    name = "WersoVPC-IGW"
  }
}

# Create the public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.WersoVPC.id
  

  tags = {
    Name = "PublicRouteTable"
  }
}

# Create a default route to an internet gateway for public internet access
resource "aws_route" "public_internet_gateway_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"  # Route all traffic (0.0.0.0/0) to the internet gateway

  gateway_id = aws_internet_gateway.gw.id
}


# Associate the public route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# # Create the Elastic IP (EIP)
# resource "aws_eip" "nat_gateway_eip" {
#   vpc = true  # Specify "true" for an EIP in a VPC; "false" for an EIP in EC2-Classic
# }

# # Create the NAT Gateway
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_gateway_eip.id
#   subnet_id     = aws_subnet.public_subnet.id  # Replace this with the ID of your public subnet

#   tags = {
#     Name = "NATGateway"
#   }
# }

# Create the private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.WersoVPC.id

  tags = {
    Name = "PrivateRouteTable"
  }
}


# # Create a default route to the NAT Gateway for private internet access
# resource "aws_route" "private_nat_gateway_route" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"  # Route all traffic (0.0.0.0/0) to the NAT Gateway

#   nat_gateway_id = aws_nat_gateway.nat_gateway.id
# }


# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


# Create a security group for SSH access
resource "aws_security_group" "ssh_sg" {
  name        = "SSHAccess"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.WersoVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all outbound traffic to any IP address
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # The protocol "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for HTTP access
resource "aws_security_group" "http_sg" {
  name        = "HTTPAccess"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.WersoVPC.id
  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule allowing all outbound traffic to any IP address
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # The protocol "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for 8081 access
resource "aws_security_group" "jenkins_sg" {
  name        = "CustomTCPAccess"
  description = "Allow 8081 inbound traffic"
  vpc_id      = aws_vpc.WersoVPC.id

  # Ingress rule allowing all traffic from any IP address
  ingress {
    from_port   = 0  # This represents all ports (from 0 to 65535)
    to_port     = 0  # This represents all ports (from 0 to 65535)
    protocol    = "-1"  # This represents all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IP addresses
  }

  # Egress rule allowing all outbound traffic to any IP address
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # The protocol "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Output the VPC ID and subnet ID
output "vpc_id" {
  value = aws_vpc.WersoVPC.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "aws_security_group" {
    value = aws_security_group.ssh_sg.id
  
}

# Create and ec2 instance in a public subnet
resource "aws_instance" "Nexus" {
    ami = "ami-09538990a0c4fe9be"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name      = "jjtechtower-nova-keypair"
    vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]
    
    

    # Pass the user data as a script
#   user_data = <<-EOT
# #!/bin/bash

# EOT




    tags = {
      Name = "Nexus"
      Env = "Dev"
    }
  
}


resource "aws_instance" "Jenkins" {
    ami = "ami-09538990a0c4fe9be"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name      = "jjtechtower-nova-keypair"
    vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id, aws_security_group.jenkins_sg.id]
    
    

    # Pass the user data as a script
  user_data = <<-EOT
#!/bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
#Removing old RPM Keys
#sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Installing Git
sudo yum install git -y
###

# Use The Amazon Linux 2 AMI When Launching The Jenkins VM/EC2 Instance
# Instance Type: t2.medium or small minimum
# Open Port (Security Group): 8080 
EOT
    tags = {
      Name = "Jenkins"
      Env = "Dev"
    }
  
}



resource "aws_instance" "werso-instance" {
    ami = "ami-09538990a0c4fe9be"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name      = "jjtechtower-nova-keypair"
    vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]
    
    

    # Pass the user data as a script
  user_data = <<-EOT
#!/bin/bash
sudo su
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> <body bgcolor=pink>
Hello Awesome Tower Batch!
Today we are Learning about Elastic Load Balancers.
This message is coming to you from $(hostname -f)
Do remember me? If not it is OK, I will remind you.
You just configured me.</h1>">/var/www/html/index.html

EOT

    tags = {
      Name = "JJtech-instance"
      Env = "Dev"
    }
  
}


resource "aws_instance" "SonarQube" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    key_name      = "jjtechtower-nova-keypair"
    vpc_security_group_ids = [aws_security_group.ssh_sg.id, aws_security_group.http_sg.id]

    tags = {
      Name = "SonarQube"
      Env = "Dev"
    }

#     user_data = <<-EOT
#     #!/bin/bash

# EOT

  
}
