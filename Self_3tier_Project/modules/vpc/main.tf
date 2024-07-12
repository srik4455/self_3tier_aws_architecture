resource "aws_vpc" "my_vpc" {
  cidr_block       = var.my_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.my_vpc

  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  count                   = length(var.my_public_subnet)
  cidr_block              = var.my_public_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.my_public_subnet[count.index]
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.my_vpc.id
  count                   = length(var.my_private_subnet)
  cidr_block              = var.my_private_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = var.my_private_subnet[count.index]

  }
}
resource "aws_subnet" "db" {
  vpc_id                  = aws_vpc.my_vpc.id
  count                   = length(var.my_db_subnet)
  cidr_block              = var.my_db_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = var.my_db_subnet[count.index]

  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

resource "aws_eip" "my_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_NAT_gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_igw]
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "my_rt"
  }

}

resource "aws_route_table_association" "rta" {
  count          = length(var.my_public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.rt.id
}

resource "aws_default_route_table" "dfrt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_NAT_gw.id
  }

  tags = {
    Name = "my_dftrt"
  }
}
