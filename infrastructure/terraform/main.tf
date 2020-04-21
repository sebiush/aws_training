provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

locals {
  tags = {
    Id = "training"
    Name = "training"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/26"
  enable_dns_hostnames = true
  enable_dns_support   = false
  instance_tenancy     = "default"

  tags = local.tags
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

resource "aws_eip" "nat_gateway_ip" {
  vpc = true

  tags = local.tags
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = module.public_subnet_az1a.subnet_id

  tags = local.tags
}

//public subnet
module "public_subnet_az1a" {
  source = "./subnet"

  vpc_id                         = aws_vpc.vpc.id
  gateway_id                     = aws_internet_gateway.internet_gateway.id
  subnet_availability_zone       = "us-east-1a"
  subnet_cidr_block              = "10.0.0.0/28"
  subnet_map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = "training public" })
}

module "public_subnet_az1b" {
  source = "./subnet"

  vpc_id                         = aws_vpc.vpc.id
  gateway_id                     = aws_internet_gateway.internet_gateway.id
  subnet_availability_zone       = "us-east-1b"
  subnet_cidr_block              = "10.0.0.16/28"
  subnet_map_public_ip_on_launch = true

  tags = merge(local.tags, { Name = "training public" })
}

//private subnet
module "private_subnet_az1a" {
  source = "./subnet"

  vpc_id                         = aws_vpc.vpc.id
  gateway_id                     = aws_nat_gateway.nat_gateway.id
  subnet_availability_zone       = "us-east-1a"
  subnet_cidr_block              = "10.0.0.32/28"
  subnet_map_public_ip_on_launch = false

  tags = merge(local.tags, { Name = "training private" })
}

module "private_subnet_az1b" {
  source = "./subnet"

  vpc_id                         = aws_vpc.vpc.id
  gateway_id                     = aws_nat_gateway.nat_gateway.id
  subnet_availability_zone       = "us-east-1b"
  subnet_cidr_block              = "10.0.0.48/28"
  subnet_map_public_ip_on_launch = false

  tags = merge(local.tags, { Name = "training private" })
}

resource "aws_security_group" "application_load_balancer_security_group" {
  name        = "application-load-balancer-security-group"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.vpc.id
  tags        = local.tags

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb" "application_load_balancer" {
  name                       = "application-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  idle_timeout               = 30
  enable_deletion_protection = false
  tags                       = local.tags
  security_groups = [
    aws_security_group.application_load_balancer_security_group.id
  ]
  subnets = [
    module.private_subnet_az1a.subnet_id,
    module.private_subnet_az1b.subnet_id
  ]
}

resource "aws_alb_target_group" "frontend_target_group" {
  name        = "frontend-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  tags        = local.tags

  health_check {
    interval            = 60
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_alb_target_group" "producer_target_group" {
  name        = "producer-target-group"
  port        = 3001
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  tags        = local.tags

  health_check {
    interval            = 60
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_alb_target_group" "consumer_target_group" {
  name        = "consumer-target-group"
  port        = 3002
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  tags        = local.tags

  health_check {
    interval            = 60
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_alb_target_group" "stock_target_group" {
  name        = "stock-target-group"
  port        = 3003
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  tags        = local.tags

  health_check {
    interval            = 60
    path                = "/health"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.frontend_target_group.arn
  }
}

resource "aws_alb_listener_rule" "consumer_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.consumer_target_group.arn
  }

  condition {
    path_pattern {
      values = [
        "/api/consumer"
      ]
    }
  }
}

resource "aws_alb_listener_rule" "producer_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.producer_target_group.arn
  }

  condition {
    path_pattern {
      values = [
        "/api/producer"
      ]
    }
  }
}

resource "aws_alb_listener_rule" "stock_listener_rule" {
  listener_arn = aws_alb_listener.listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.stock_target_group.arn
  }

  condition {
    path_pattern {
      values = [
        "/api/stock"
      ]
    }
  }
}
