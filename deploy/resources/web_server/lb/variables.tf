variable "name"              { default = "" }
variable "load_balancer_subnets"    { 
                               type = list
                               default = [] 
                             }
variable "security_group"   { 
                               type = list
                               default = [] 
                             }
variable "vpc_id"            { default = "" }
