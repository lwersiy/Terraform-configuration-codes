github_repository = "werso_repo"
vpc_cidr_block = "10.0.0.0/16"
vpc_name = "LouisVPC"
public_subnet_cidr_block = "10.0.1.0/24"
availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
pub_subnet_name = "PublicSubnet"
priv_subnet_name = "PrivateSubnet"
priv_subnet_cidr_block = "10.0.64.0/24"
internet_gateway = "LouisVPC-IGW"
pub_route_table_name = "PublicRouteTable"
destination_cidr_block = "0.0.0.0/0"
vpc_eip = "true"
Nat_gateway_name = "NATGateway"
allocation_id_nat = "aws_eip.nat_gateway_eip.id"
private_route_table_name = "PrivateRouteTable"
nat_gateway_id = "aws_nat_gateway.nat_gateway.id"
priv_route_table_id = "aws_route_table.private_route_table.id"
security_group_names = ["SSHAccess", "HTTPAccess", "AllAccess"]
security_group_descriptions = ["Allow SSH inbound traffic", "Allow HTTP inbound traffic", "Allow All inbound traffic"]
ports = ["22", "80", "0", "9000"]
protocol = ["tcp", "-1"]
ami = ["ami-09538990a0c4fe9be", "ami-0f34c5ae932e6f0e4"]
instancetype = ["t2.medium", "t2.micro", "t2.large"]
associate_public_ip_address = ["true", "false"]
key_name = "jjtechtower-nova-keypair"
instance-name-tags = ["jenkins", "werso-instance", "SonarQube"]


