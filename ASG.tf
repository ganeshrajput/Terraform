
#creating launch template.

resource "aws_launch_template" "WebaapProject_launch_tamplate" {
  name = "WebaapProject_launch_tamplate"

  image_id = "ami-0ee3950be11ebc3ae"

  instance_type = "t2.micro"
  key_name = aws_key_pair.loginkey.id

  vpc_security_group_ids = [aws_security_group.WebaapProjectSG.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "WebaapProject_launch_tamplate"
    }
  }

}

# creating Auto scalling group

resource "aws_autoscaling_group" "WebaapProject_Auto_scale" {
  #availability_zones = [ap-south-1a]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 2
  vpc_zone_identifier = [ aws_subnet.WebbappProject_ap-south-1a.id,aws_subnet.WebbappProject_ap-south-1b.id ]

  launch_template {
    id      = aws_launch_template.WebaapProject_launch_tamplate.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.WebaapProjectLBTargetGroupASG.arn]
}

 
# CREATING TARGEET GROUP for Auto Scalling Group


resource "aws_lb_target_group" "WebaapProjectLBTargetGroupASG" {
  name     = "WebaapProjectLBASG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.WebaapProjectVPC.id
}


#CREATING LOAD BALANCER LISTNER

resource "aws_lb_listener" "WebaapProjectLBListnerASG" {
  load_balancer_arn = aws_lb.WebaapProjectLBASG.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebaapProjectLBTargetGroupASG.arn
  }
}

# CREATING LOAD BALANCER


resource "aws_lb" "WebaapProjectLBASG" {
  name               = "WebaapProjectLBASG"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.WebaapProjectSG.id]
  subnets            = [aws_subnet.WebbappProject_ap-south-1b.id,aws_subnet.WebbappProject_ap-south-1a.id]


  tags = {
    Environment = "production"
  }
}