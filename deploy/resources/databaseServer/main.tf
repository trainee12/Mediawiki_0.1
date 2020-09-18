resource "aws_instance" "database" {
  ami                   = var.ami_id
  key_name              = var.key_name
  subnet_id             = var.subnet1
  security_groups = var.security_groups
  instance_type         = var.instance_type
  
  root_block_device {
     volume_type = "gp2"
     volume_size = "8"
     delete_on_termination = "true"
        }
  volume_tags = {
     Name                  = "DataVolumeMW"
     }
  tags = {
     Name                  = "DataBaseServerMW"
     }
  user_data = data.template_file.database_setup.rendered
}

# resource "aws_instance" "database-bkp" {
#   #count                 = var.count
#   ami                   = var.ami_id
#   instance_type         = var.instance_type
#   key_name              = var.key_name
#   subnet_id             = var.subnet2
#   security_groups = var.security_groups
#   root_block_device {
#      volume_type = "gp2"
#      volume_size = "8"
#      delete_on_termination = "true"
#         }
#   volume_tags = {
#      Name                  = "MediaWikiDBbkp"
#      }
#   tags = {
#      Name                  = "MediaWikiDBbkp"
#      }
#   user_data = data.template_file.db_setup.rendered
# }





data "template_file" "database_setup" {
  template = file("resources/scripts/database_config.tpl")
  vars = {
    name   = var.name
    username     = var.username
    password     = var.password
    root_password  = var.root_password
  }
}


output "database_ip" {
value = aws_instance.database.private_ip
}

# output "bkp_database_ip" {
# value = [aws_instance.database-bkp.private_ip]
# }

