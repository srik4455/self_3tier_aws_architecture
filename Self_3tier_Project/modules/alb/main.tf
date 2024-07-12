resource "aws_lb" "web-lb" {
  name               = "Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = var.public_subnet_id

  enable_deletion_protection = false
  tags = {
    Name = "web-lb"
  }
}

#Target Group
resource "aws_lb_target_group" "web-tg" {
  name     = "web-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

}

#Target Group Attachment    
resource "aws_lb_target_group_attachment" "web-tg-attachment" {
  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = var.web_instances_id[count.index]
  count            = length(var.web_instances_id)
  port             = 80
}
#listerner

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}

###Internal Load Balancer

resource "aws_lb" "app-lb" {
  name               = "Application-Load-Balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_sg_id]
  subnets            = ["var.public_subnet_id", "var.private_subnet_id"]



  enable_deletion_protection = false
  tags = {
    Name = "app-lb"
  }
}

#Target Group
resource "aws_lb_target_group" "app-tg" {
  name     = "app-targetgroup"
  port     = 22
  protocol = "TCP"
  vpc_id   = var.vpc_id

}

#Target Group Attachment    
resource "aws_lb_target_group_attachment" "app-tg-attachment" {
  target_group_arn = aws_lb_target_group.app-tg.arn
  target_id        = var.app_instances_id[count.index]
  count            = length(var.app_instances_id)
  port             = 22
}
#listerner

resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "22"
  protocol          = "TCP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}
