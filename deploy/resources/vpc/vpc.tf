# create the VPC
resource "aws_vpc" "MediaWiki" {
  cidr_block           = var.vpcCIDRblock
tags = {
    Name = "VPC for MediaWiki Application"
}
}

# create the Subnet
resource "aws_subnet" "MediaWiki_Public_Subnet1" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPublic1
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone1
tags = {
   Name = "MediaWiki_Public_Subnet1"
}
}

resource "aws_subnet" "MediaWiki_Public_Subnet2" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPublic2
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone2
tags = {
   Name = "MediaWiki_Public_Subnet2"
}
}

# create the Subnet
resource "aws_subnet" "MediaWiki_Private_Subnet1" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPrivate1
  availability_zone       = var.availabilityZone1
tags = {
   Name = "MediaWiki_Private_Subnet1"
}
}

# create the Subnet
resource "aws_subnet" "MediaWiki_Private_Subnet2" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPrivate2
  availability_zone       = var.availabilityZone2
tags = {
   Name = "MediaWiki_Private_Subnet2"
}
}




# # create VPC Network access control list
# resource "aws_network_acl" "MediaWiki_Security_ACL" {
#   vpc_id = aws_vpc.MediaWiki.id
#   subnet_ids = [ aws_subnet.MediaWiki_Public_Subnet1.id ]
# # allow ingress port 22
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 22
#     to_port    = 22
#   }
 
#   # allow ingress port 80
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 80
#     to_port    = 80
#   }
 
#   # allow ingress ephemeral ports
#   ingress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 1024
#     to_port    = 65535
#   }
 
#   # allow egress port 22
#   egress {
#     protocol   = "tcp"
#     rule_no    = 100
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 22
#     to_port    = 22
#   }
 
#   # allow egress port 80
#   egress {
#     protocol   = "tcp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 80  
#     to_port    = 80
#   }
 
#   # allow egress ephemeral ports
#   egress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = var.destinationCIDRblock
#     from_port  = 1024
#     to_port    = 65535
#   }
# tags = {
#     Name = "MediaWiki ACL"
# }
# } # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "MW_GW" {
 vpc_id = aws_vpc.MediaWiki.id
 tags = {
        Name = "MediaWiki Internet Gateway"
}
}

# Create the Route Table
resource "aws_route_table" "MediaWiki_public_route_table" {
 vpc_id = aws_vpc.MediaWiki.id
 tags = {
        Name = "My VPC Route Table"
}
} # end resource
# Create the Internet Access
resource "aws_route" "MediaWiki_internet_access" {
  route_table_id         = aws_route_table.MediaWiki_public_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.MW_GW.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "MediaWiki_association" {
  subnet_id      = aws_subnet.MediaWiki_Public_Subnet1.id
  route_table_id = aws_route_table.MediaWiki_public_route_table.id
} # end resource

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.MediaWiki_Public_Subnet1.id
  tags = {
    "Name" = "DummyNatGateway"
  }
}

output "vpc_id" {
value = aws_vpc.MediaWiki.id
}

output "private_subnet_1" {
  value = aws_subnet.MediaWiki_Private_Subnet1.id
}
output "private_subnet_2" {
  value = aws_subnet.MediaWiki_Private_Subnet2.id
}

output "public_subnet_2" {
  value = aws_subnet.MediaWiki_Public_Subnet2.id
}
output "public_subnet_1" {
  value = aws_subnet.MediaWiki_Public_Subnet1.id
}