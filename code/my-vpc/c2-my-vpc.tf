resource "aws_vpc" "my-vpc-01" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "my-vpc-01"
  }
  
}

output "vpc_id" {
  value = aws_vpc.my-vpc-01.id

}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc-01.id
  depends_on = [ aws_vpc.my-vpc-01 ]

  tags = {
    Name = "my-internet-gateway-01"
  }
}

resource "aws_route_table" "my-public-route-01" {
  vpc_id = aws_vpc.my-vpc-01.id
  depends_on = [ aws_vpc.my-vpc-01, aws_internet_gateway.my-igw ]

  route {
    cidr_block = aws_vpc.my-vpc-01.cidr_block
    gateway_id = "local"
  }

  route {
    gateway_id = aws_internet_gateway.my-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "my-public-route-01"
  }
}

resource "aws_route_table" "my-private-route-01" {
  vpc_id = aws_vpc.my-vpc-01.id
  depends_on = [ aws_vpc.my-vpc-01, aws_nat_gateway.my-nat-01 ]

  route {
    cidr_block = aws_vpc.my-vpc-01.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my-nat-01.id
  }

  tags = {
    Name = "my-private-route-01"
  }
}

resource "aws_subnet" "my-public-subnet-01" {
  depends_on = [ aws_vpc.my-vpc-01 ]
  vpc_id = aws_vpc.my-vpc-01.id
  cidr_block = "10.0.101.0/24"
  tags = {
    Name = "my-public-subnet-01"
  }
}

resource "aws_subnet" "my-private-subnet-01" {
  depends_on = [ aws_vpc.my-vpc-01 ]
  vpc_id = aws_vpc.my-vpc-01.id
  cidr_block = "10.0.51.0/24"
  tags = {
    Name = "my-private-subnet-01"
  }
}

resource "aws_eip" "elastic-ip-nat" {
  depends_on = [ aws_vpc.my-vpc-01 ]
  domain           = "vpc"

}

output "elastic-ip" {
  value = aws_eip.elastic-ip-nat.public_ip
  
}

resource "aws_nat_gateway" "my-nat-01" {
  allocation_id = aws_eip.elastic-ip-nat.id
  subnet_id     = aws_subnet.my-public-subnet-01.id

  tags = {
    Name = "my-nat-01"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my-igw]
}


resource "aws_route_table_association" "my-public-root" {
  depends_on = [ aws_route_table.my-public-route-01, aws_subnet.my-public-subnet-01 ]
  subnet_id      = aws_subnet.my-public-subnet-01.id
  route_table_id = aws_route_table.my-public-route-01.id
}

resource "aws_route_table_association" "my-private-root" {
  depends_on = [ aws_route_table.my-private-route-01, aws_subnet.my-private-subnet-01 ]
  subnet_id      = aws_subnet.my-private-subnet-01.id
  route_table_id = aws_route_table.my-private-route-01.id
}

