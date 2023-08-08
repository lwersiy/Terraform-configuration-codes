variable "github_repository" {
  default     = "some-repo"
  description = "github repositories"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "the cidr to use"
}


variable "vpc_name" {
  default     = "LouisVPC"
  description = "possible names to call vpc"
}

variable "vpc_id" {
    default = "aws_vpc.LouisVPC.id"
    description = "id of my vpc"
  
}

variable "public_subnet_cidr_block" {
  default     = "10.0.1.0/24"
  description = "public subnet cidr"
}

variable "availability_zone" {
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "limit provision to these az only"
}

variable "pub_subnet_name" {
  default     = "PublicSubnet"
  description = "name of public subnet"
}

variable "priv_subnet_name" {
  default     = "PrivateSubnet"
  description = "name of private subnet"
}

variable "priv_subnet_cidr_block" {
  default     = "10.0.64.0/24"
  description = "private subnet cidr range"
}

variable "internet_gateway" {
  default     = "LouisVPC-IGW"
  description = "internet gateway for terraform provisioning only"
}

variable "pub_route_table_name" {
  default     = "PublicRouteTable"
  description = "this route direct traffic to the internet gateway"
}

variable "route_table_id" {
  default     = "aws_route_table.public_route_table.id"
  description = "route table id"
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "from the gateway to the internet"
}

variable "internet_gateway_id" {
  default     = "aws_internet_gateway.gw.id"
  description = "internet gateway id"
}

variable "pub_subnet_id" {
  default     = "aws_subnet.public_subnet.id"
  description = "public subnet id"
}

variable "vpc_eip" {
  default     = ["true", "faulse"]
  description = "elastic ip for nat gateway and instances"
}

variable "Nat_gateway_name" {
  default     = "NATGateway"
  description = "nat gateway name"
}

variable "allocation_id_nat" {
  default     = "aws_eip.nat_gateway_eip.id"
  description = "allocation id helps to direct the ip to your nat gateway for use"
}

variable "private_route_table_name" {
  default     = "PrivateRouteTable"
  description = "this route helps direct traffic from private subnet to the nat gateway"
}

variable "nat_gateway_id" {
  default     = "aws_nat_gateway.nat_gateway.id"
  description = "nat gateway id"
}

variable "Priv_subnet_id" {
  default     = "aws_subnet.private_subnet.id"
  description = "private subnet id"
}

variable "priv_route_table_id" {
  default     = "aws_route_table.private_route_table.id"
  description = "private route table id"
}

variable "security_group_names" {
  default     = ["SSHAccess", "HTTPAccess", "AllAccess"]
  description = "all security groups here"
}

variable "security_group_descriptions" {
  default     = ["Allow SSH inbound traffic", "Allow HTTP inbound traffic", "Allow All inbound traffic"]
  description = "descriptions of security groups"
}

variable "ports" {
  default     = ["22", "80", "0", "9000"]
  description = "available ports range to use"
}

variable "protocol" {
  default     = ["tcp", "-1"]
  description = "available protocols to use"

}

variable "ami" {
  default     = ["ami-09538990a0c4fe9be", "ami-0f34c5ae932e6f0e4"]
  description = "available ami ids to use, amzLinux 2020 and amzLinux 2"
}

variable "instancetype" {
  default     = ["t2.medium", "t2.micro", "t2.large"]
  description = "instance typs for dev use"
}

variable "associate_public_ip_address" {
  default     = ["true", "false"]
  description = "assign ip address or not"
}

variable "key_name" {
  default     = "jjtechtower-nova-keypair"
  description = "northen virgina keypair"
}

variable "instance-name-tags" {
  default     = ["jenkins", "jjtech-instance", "SonarQube", "Nexus"]
  description = "instance name tags"
}