# Create the Security Group
resource "aws_security_group" "MediaWiki_Security_Web_Server" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_Web_Server"
  description  = "MediaWiki_Security_Web_Server"
 
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
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
   Name = "MediaWiki Security Group Web Server"
   Description = "MediaWiki Security Group Web Server"
}
} # end resource

# Create the Security Group
resource "aws_security_group" "MediaWiki_Security_Database_Server" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_Database_Server"
  description  = "MediaWiki_Security_Database_Server"
 
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblockP2P
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = var.ingressCIDRblockP2P
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = var.ingressCIDRblockP2P
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "MediaWiki_Security_ASG" {
  vpc_id       = var.vpc_id_sg
  name         = "MediaWiki_Security_ASG"
  description  = "MediaWiki_Security_ASG"
 
  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = var.ingressCIDRblock  
    from_port   = 443
    to_port     = 443
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

output "database_sg" {
  value = aws_security_group.MediaWiki_Security_Database_Server.id
}

output "loadbalancer_sg" {
  value = aws_security_group.MediaWiki_Security_Web_Server.id
}

output "asg_sg" {
  value = aws_security_group.MediaWiki_Security_ASG.id
}