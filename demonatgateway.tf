# NAT Gateway for the public subnet
resource "aws_eip" "nat_gateway" {
  depends_on                = [aws_internet_gateway.gw]
  vpc                       = true
}


/*# Data source to fetch the public subnet dynamically
data "aws_subnet_ids" "public" {
  //vpc_id = "your_vpc_id_here"  # Replace with your VPC ID
  vpc_id            = aws_vpc.demovpc.id
  tags = {
    "Type" = "public"  # Assuming your public subnets are tagged with "Type = public"
  }
}
*/

resource "aws_nat_gateway" "terraform-lab-ngw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnets[0].id
//  subnet_id     = aws_subnet.public_subnets[*].
//  subnet_id      = aws_subnet.public-subnets.id
//  subnet_id     = data.aws_subnet_ids.public.ids[0]  # Assuming you want to use the first public subnet

  tags = {
    Name = "terraform-lab-ngw"
  }
  depends_on = [aws_eip.nat_gateway]
}

# Route NAT Gateway
resource "aws_route" "nat-ngw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.terraform-lab-ngw.id
  destination_cidr_block = "0.0.0.0/0"
}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    Name = "private-terraform-lab-route-table"
  }
}

resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnets[0].id
}
resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private_subnets[1].id
}
