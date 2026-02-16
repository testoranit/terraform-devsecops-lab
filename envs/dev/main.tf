resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "devsecops-dev-vpc"
  }
}

resource "aws_subnet" "public_subnet" {

  #checkov:skip=CKV_AWS_130: "Public subnet requires public IP assignment"

  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "dev-private-subnet"
  }
}

