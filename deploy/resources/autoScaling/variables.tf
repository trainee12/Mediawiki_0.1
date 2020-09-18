variable "instance_type"     { default = "t2.micro" }
variable "vpc_id"            { default = "" }
variable "ami_id"            { default = "" }
variable "key_name"          { default = "" }
variable "min_size"              { default = "1" }
variable "max_size"              { default = "3" }
variable "username"                { default ="admin" }
variable "password"                { default ="" }
variable "name"              { default ="mwdb" }
variable "root_password"           { default ="" }
variable "site_name"            { default ="admin" }
variable "app_ver"              { default ="1.26.3" }
variable "lburl"                  { default ="" }
variable "security_group"   { 
                               type = list
                               default = [] 
                             }

variable "target_group"            { 
                               type = list
                               default = [] 
                             }
variable "database_address"                 { 
                               default = "" 
                             }
variable "subnets"  { 
                               type = list
                               default = [] 
                             }

