# Create the Security Group for Load Balancer
resource "aws_security_group" "MediaWiki_Security_Load_balancer" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_Load_balancer"
  description  = "MediaWiki_Security_Load_balander"
 
  # allow ingress of port 80
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
 
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "MediaWiki Security Group Load Balancer"
   Description = "MediaWiki Security Load Balancer"
}
} # Load Balancer Security Group Created

# Create the Security Group for Auto Scaling

resource "aws_security_group" "MediaWiki_Security_ASG" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_ASG"
  description  = "MediaWiki_Security_ASG"
 
  # allow ingress of all ports from Public Subnet
  ingress {
    cidr_blocks = var.ingressCIDRblockPublic
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }
 
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "MediaWiki ASG SG"
   Description = "MediaWiki ASG SG"
}
}

# Create the Security Group for Database Server
resource "aws_security_group" "MediaWiki_Security_Database_Server" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_Database_Server"
  description  = "MediaWiki_Security_Database_Server"
 
  ingress {
    cidr_blocks = var.ingressCIDRblockPrivate
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }
 
 
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "MediaWiki Database Server SG"
   Description = "MediaWiki Database Server SG"
}
} # end resource



output "database_sg" {
  value = aws_security_group.MediaWiki_Security_Database_Server.id
}

output "loadbalancer_sg" {
  value = aws_security_group.MediaWiki_Security_Load_balancer.id
}

output "asg_sg" {
  value = aws_security_group.MediaWiki_Security_ASG.id
}