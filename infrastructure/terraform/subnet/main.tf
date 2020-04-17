resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}

resource "aws_subnet" "subnet" {
  cidr_block = var.subnet_cidr_block
  vpc_id     = var.vpc_id
  availability_zone = var.subnet_availability_zone
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch

  tags = var.tags
}

resource "aws_route_table_association" "route_table_association" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.subnet.id
}
