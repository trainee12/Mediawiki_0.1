variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}

variable "ingressCIDRblockP2P" {
    type = list
    default = [ "10.0.1.0/24","10.0.3.0/24" ]
}

variable "vpc_id_sg"   { 
    default = "" 
}
