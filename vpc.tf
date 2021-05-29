#creating VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "my-vpc"
    }
}

#creating subnets inside the above-created vpc
resource "aws_subnet" "sbnt" {
    count  = length(var.subnets_cidr) #number of times the block will run is equal to length of subnet's_cidr list
    vpc_id = aws_vpc.vpc.id
    /*when block runs for first time, first value form list subnet's_cidr will be passed and 
    when block runs for second time second value form list subnet's_cidr will be passed*/
    cidr_block              = element(var.subnets_cidr , count.index) 
    availability_zone       = element(var.availability_zones , count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "My-Subnet-${count.index + 1}"
    }
}

#creating internet gateway for our subnets to be able to connect to internet
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "My-IGW"
    }
}

#creating route table
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "My-Public-Routing-Table"
    }
}

#attaching route table to subnets created so that they can  have access to internet.
resource "aws_route_table_association" "a" {
    count          = length(var.subnets_cidr)
    subnet_id      = element(aws_subnet.sbnt.*.id , count.index)
    route_table_id = aws_route_table.rt.id
}