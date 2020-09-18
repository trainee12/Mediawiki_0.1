variable "ami_id"                { default ="" }
variable "instance_type"         { default ="t2.micro" }
variable "key_name"              { default ="" }
variable "availability_zone"     { 
                               type = list
                               default = ["us-east-1a", "us-east-1b"] 
                             }


variable "subnet1"               { default = "" }
variable "subnet2"               { default = "" }
variable "security_groups"       { 
type    = list
default =[]
}

### Template Variables ###
variable "username"                { default ="admin" }
variable "password"                { default ="admin123" }
variable "name"              { default ="mwdb" }
variable "root_password"           { default ="admin123" }


