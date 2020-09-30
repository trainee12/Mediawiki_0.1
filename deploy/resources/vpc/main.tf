resource "aws_vpc" "MediaWiki" {
  cidr_block           = var.vpcCIDRblock
tags = {
    Name = "VPC for MediaWiki Application"
}
}

# Create the First Public Subnet
resource "aws_subnet" "MediaWiki_Public_Subnet1" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPublic1
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone1
tags = {
   Name = "MediaWiki_Public_Subnet1"
}
}

# Create the Second Public Subnet
resource "aws_subnet" "MediaWiki_Public_Subnet2" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPublic2
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone2
tags = {
   Name = "MediaWiki_Public_Subnet2"
}
}

# Create the First Private Subnet
resource "aws_subnet" "MediaWiki_Private_Subnet1" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPrivate1
  availability_zone       = var.availabilityZone1
  map_public_ip_on_launch = false
tags = {
   Name = "MediaWiki_Private_Subnet1"
}
}




# Create the Second Private Subnet
resource "aws_subnet" "MediaWiki_Private_Subnet2" {
  vpc_id                  = aws_vpc.MediaWiki.id
  cidr_block              = var.subnetCIDRblockPrivate2
  availability_zone       = var.availabilityZone2
  map_public_ip_on_launch = false
tags = {
   Name = "MediaWiki_Private_Subnet2"
}
}



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
        Name = "Public1"
}
} 

# Create the Internet Access
resource "aws_route" "MediaWiki_internet_access" {
  route_table_id         = aws_route_table.MediaWiki_public_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.MW_GW.id
} # end resource

# Associate the Route Table with the Subnet

resource "aws_route_table_association" "Route_association1" {
  subnet_id      = aws_subnet.MediaWiki_Public_Subnet1.id
  route_table_id = aws_route_table.MediaWiki_public_route_table.id
} 

resource "aws_route_table_association" "Route_association2" {
  subnet_id      = aws_subnet.MediaWiki_Public_Subnet2.id
  route_table_id = aws_route_table.MediaWiki_public_route_table.id
}


# Create Nat Gateway and EIP

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

# Create the Route Table
resource "aws_route_table" "MediaWiki_private_route_table" {
 vpc_id = aws_vpc.MediaWiki.id
 tags = {
        Name = "Private"
}
} 

# Add Nat Gateway to Route Table

resource "aws_route" "MediaWiki_private" {
  route_table_id         = aws_route_table.MediaWiki_private_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  nat_gateway_id             = aws_nat_gateway.nat_gateway.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "Route_association3" {
  subnet_id      = aws_subnet.MediaWiki_Private_Subnet1.id
  route_table_id = aws_route_table.MediaWiki_private_route_table.id
} 

resource "aws_route_table_association" "Route_association4" {
  subnet_id      = aws_subnet.MediaWiki_Private_Subnet2.id
  route_table_id = aws_route_table.MediaWiki_private_route_table.id
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
