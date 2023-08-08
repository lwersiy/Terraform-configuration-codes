# Output the VPC ID and subnet ID
output "vpc_id" {
  value = aws_vpc.LouisVPC.id
}

output "public_subnet_id" {
  value = var.pub_subnet_id
}