variable "ec2_subnets"  { 
                               type = list
                               default = [] 
                             }
variable "security_group"   { 
                               type = list
                               default = [] 
                             }
variable "vpc_id"            { default = "" }
variable "ami_id"            { default = "" }
variable "key_name"          { default = "" }
variable "target_group"            { 
                               type = list
                               default = [] 
                             }
variable "instance_type"     { default = "t2.micro" }
variable "min_size"              { default = "2" }
variable "max_size"              { default = "5" }


### Template Variables ###
variable "database_address"                 { 
                               default = "" 
                             }
### Template Variables ###
variable "username"                { default ="admin" }
variable "password"                { default ="admin" }
variable "name"              { default ="mwdb" }
variable "root_password"           { default ="admin123" }
variable "site_name"            { default ="admin" }
variable "app_ver"              { default ="1.26.3" }
variable "lburl"                  { default ="" }

