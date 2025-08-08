# Creation of VPC
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev-vpc"
    }
  
}
# Creation of subnets
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "dev-subnet"
    }
  
}
resource "aws_subnet" "name2" {
  vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "dev-subnet"
    }
  
}
# Creation IG and attach to vpc
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "dev-sg"
  }
}

# Creation of route table and edit routes 
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
  
}
# Creation of subnet association 
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
}
# Creation SG group 
#SG grooup
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.name.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

# Creation of servers
resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
  
}