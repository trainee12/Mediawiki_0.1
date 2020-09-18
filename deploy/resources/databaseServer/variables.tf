variable "ami_id"                { default ="" }
variable "instance_type"         { default ="t2.micro" }
variable "key_name"              { default ="" }
variable "subnet1"               { default = "" }
variable "subnet2"               { default = "" }
variable "username"                { default ="admin" }
variable "password"                { default ="" }
variable "name"                     { default ="mwdb" }
variable "root_password"           { default ="" }
variable "security_groups"       {
                                    type= list
                                    default =[]
                                }



