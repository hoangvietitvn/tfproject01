resource "aws_vpc" "myvpc" {
    cidr_block  = "10.10.0.0/16"
    enable_dns_hostnames = true
    tags        = {
        name    =  "myvpc"
    
    }
}
resource "aws_subnet" "mysubnet01" {
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true
    vpc_id      = "${aws_vpc.myvpc.id}"
    cidr_block  = "10.10.10.0/24"
    tags        = {
        name    =  "mysubnet01"
    }
}
resource "aws_subnet" "mysubnet02" {
    availability_zone = "ap-southeast-1a"
    vpc_id      = "${aws_vpc.myvpc.id}"
    cidr_block  = "10.10.20.0/24"
    tags        = {
        name    = "mysubnet02"
    }
}
resource "aws_internet_gateway" "mygw01" {
    vpc_id     = "${aws_vpc.myvpc.id}"
    tags       = {
        name   = "mygw01"
    }
}
resource "aws_route_table" "myroute01" {
    vpc_id     = "${aws_vpc.myvpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.mygw01.id}"
    }
    tags           = {
        name       = "myroute01"
    }
}
resource "aws_route_table_association" "subnet_route01" {
    subnet_id     = "${aws_subnet.mysubnet01.id}"
    route_table_id = "${aws_route_table.myroute01.id}"
}
resource "aws_security_group" "mysg01" {
    name           = "allowssh"
    description    = "Allow SSH Connection"
    vpc_id         = "${aws_vpc.myvpc.id}"
ingress {

    description    = "Allow Incomming SSH Connection"
    from_port      = "22"
    to_port        = "22"
    protocol       = "tcp"
    cidr_blocks    = ["0.0.0.0/0"]
}
egress {    
    from_port      = 0
    to_port        = 0
    protocol       = "-1"
    cidr_blocks    = ["0.0.0.0/0"]
}
tags               = {
    name           = "Allow SSH"
}
}
