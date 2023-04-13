

# CREATING CONNECTIVITY STUFFS VPC AND SUBNETS

resource "aws_vpc" "WebaapProjectVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "WebaapProjectVPC"
  }
}

# CREATING INTERNAET GATEWAY

resource "aws_internet_gateway" "WebaapProjectIG" {
  vpc_id = aws_vpc.WebaapProjectVPC.id

  tags = {
    Name = "WebaapProjectIG"
  }
}

# CREATING ROUTING TABLE

resource "aws_route_table" "WebaapProjectRT" {
  vpc_id = aws_vpc.WebaapProjectVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.WebaapProjectIG.id
  }
  tags = {
    Name = "WebaapProjectRT"
  }
}

# CREATING SUBNETS NOW in AZ ap-south-1A

resource "aws_subnet" "WebbappProject_ap-south-1a" {
  vpc_id     = aws_vpc.WebaapProjectVPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "WebbappProject_ap-1a"
  }
}
# ASSOCIATION OF SUBNET 1A WITH ROUTING TABLE
resource "aws_route_table_association" "WebaapProjectRTAsso1a" {
  subnet_id      = aws_subnet.WebbappProject_ap-south-1a.id
  route_table_id = aws_route_table.WebaapProjectRT.id
}


# CREATING SUBNETS NOW in AZ ap-south-1B

resource "aws_subnet" "WebbappProject_ap-south-1b" {
  vpc_id     = aws_vpc.WebaapProjectVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "WebbappProject_ap-1b"
  }
}
# ASSOCIATION OF SUBNET 1B WITH ROUTING TABLE

resource "aws_route_table_association" "WebaapProjectRTAsso1b" {
  subnet_id      = aws_subnet.WebbappProject_ap-south-1b.id
  route_table_id = aws_route_table.WebaapProjectRT.id
}

#Craeting Elastic IP

#resource "aws_eip" "Elastic_ip" {
 # vpc      = true
#}

# Creating NAT gateway

#resource "aws_nat_gateway" "Nat_gateway" {
 # allocation_id = aws_eip.Elastic_ip.id
  #subnet_id     = aws_subnet.WebbappProject_ap-south-1a.id

  #tags = {
    #Name = "Nat_gateway"
  #}

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.

  #depends_on = [aws_internet_gateway.WebaapProjectIG]
#}


# CREATING PRIVATE ROUTING TABLE OR PRIVATE SUBNET

resource "aws_route_table" "WebaapProjectRT_Private" {
  vpc_id = aws_vpc.WebaapProjectVPC.id

  #route {
   # cidr_block = "0.0.0.0/0"
    #nat_gateway_id = aws_nat_gateway.Nat_gateway.id
  #}

  tags = {
    Name = "WebaapProjectRT_Private"
  }
}

# ASSOCIATION OF SUBNET 1B WITH ROUTING TABLE

resource "aws_route_table_association" "WebaapProjectRTAsso1b_Private" {
  subnet_id      = aws_subnet.WebbappProject_ap-south-1b_private.id
  route_table_id = aws_route_table.WebaapProjectRT_Private.id
}

# CREATING PRIVATE SUBNET NOW in AZ ap-south-1B

resource "aws_subnet" "WebbappProject_ap-south-1b_private" {
  vpc_id     = aws_vpc.WebaapProjectVPC.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "WebbappProject_ap-1b_private"
  }
}
 