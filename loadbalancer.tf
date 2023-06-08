# Terraform Resource block- Building an ALB for the public subnet
resource "aws_lb" "my_alb_public" {
  name               = "TestAlbPublic"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnets["public_subnet_1"].id, aws_subnet.public_subnets["public_subnet_2"].id, aws_subnet.public_subnets["public_subnet_3"].id]
}

# Building a listener for public ALB

resource "aws_lb_listener" "my_listener_public" {
  load_balancer_arn = aws_lb.my_alb_public.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello, world!"
      status_code  = "200"
    }
  }
}

# Terraform Resource block- Building an ALB for the private subnets
resource "aws_lb" "my_alb_private" {
  name               = "TestAlbPrivate"
  load_balancer_type = "application"
  subnets            = [aws_subnet.private_subnets["private_subnet_1"].id, aws_subnet.private_subnets["private_subnet_2"].id, aws_subnet.private_subnets["private_subnet_3"].id]
}

# Building a listener for private ALB
resource "aws_lb_listener" "my_listener_private" {
  load_balancer_arn = aws_lb.my_alb_private.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello, world!"
      status_code  = "200"
    }
  }
}

