variable  "aws_region" {
    default = "ap-south-1"  #region where VPC wll eb launched
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"  #CIDR declaration for VPC
}

variable "subnets_cidr" {
    type = list
    default = ["10.0.1.0/24" , "10.0.2.0/24"] #CIDR declaration for 2 subnets 
}

variable "availability_zones" {
    type = list
    default = ["ap-south-1a" , "ap-south-1b"]   #defining AZs for Subnets 
}