resource "aws_vpc" "project8" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project8"
  }
}

# Public Subnet

resource "aws_subnet" "pubsub-1" {
  vpc_id     = aws_vpc.project8.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub-1"
  }
}

resource "aws_subnet" "pubsub-2" {
  vpc_id     = aws_vpc.project8.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub-2"
  }
}
#Private subnet

resource "aws_subnet" "privsub-1" {
  vpc_id     = aws_vpc.project8.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "privsub-1"
  }
}


resource "aws_subnet" "privsub-2" {
  vpc_id     = aws_vpc.project8.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "privsub-2"
  }
}

#Route table

resource "aws_route_table" "publicrt1" {
  vpc_id = aws_vpc.project8.id

  tags = {
    Name = "publicrt1"
  }
}

resource "aws_route_table" "privatert1" {
  vpc_id = aws_vpc.project8.id

  route = []

  tags = {
    Name = "privatert1"
  }
}

#RT association

resource "aws_route_table_association" "pubrt-asso1" {
  subnet_id      = aws_subnet.pubsub-1.id
  route_table_id = aws_route_table.publicrt1.id
}

resource "aws_route_table_association" "pubrt-asso2" {
  subnet_id      = aws_subnet.pubsub-2.id
  route_table_id = aws_route_table.publicrt1.id
}

resource "aws_route_table_association" "privrt-asso1" {
  subnet_id      = aws_subnet.privsub-1.id
  route_table_id = aws_route_table.privatert1.id
}

resource "aws_route_table_association" "privrt-asso2" {
  subnet_id      = aws_subnet.privsub-2.id
  route_table_id = aws_route_table.privatert1.id
}

#Igw

resource "aws_internet_gateway" "igw-project8" {
  vpc_id = aws_vpc.project8.id

  tags = {
    Name = "igw-project8"
  }
}

resource "aws_route" "igw-rtasso" {
  route_table_id = aws_route_table.publicrt1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.igw-project8.id
}
