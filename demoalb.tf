# Load Balancer
resource "aws_lb" "terraform-lab" {
  name               = "${var.ec2_instance_name}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.load-balancer.id]
  subnets            = aws_subnet.public_subnets[*].id
}

# Target group
resource "aws_alb_target_group" "default-target-group" {
  name     = "${var.ec2_instance_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demovpc.id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 60
    matcher             = "200"
  }
}

resource "aws_autoscaling_group" "ec2-cluster" {
  name                 = "${var.ec2_instance_name}_auto_scaling_group"
  min_size             = var.autoscale_min
  max_size             = var.autoscale_max
  desired_capacity     = var.autoscale_desired
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.ec2.name
  vpc_zone_identifier  = aws_subnet.private_subnets[*].id
  target_group_arns    = [aws_alb_target_group.default-target-group.arn]
}



resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.ec2-cluster.id
  lb_target_group_arn    = aws_alb_target_group.default-target-group.arn
}

resource "aws_alb_listener" "ec2-alb-http-listener" {
  load_balancer_arn = aws_lb.terraform-lab.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.default-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }
}
