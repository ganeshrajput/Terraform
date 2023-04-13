
# CREATING TARGEET GROUP


resource "aws_lb_target_group" "WebaapProjectLBTargetG" {
  name     = "WebaapProjectLB"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.WebaapProjectVPC.id
}


#CREATING LOAD BALANCER LISTNER

resource "aws_lb_listener" "WebaapProjectLBListner" {
  load_balancer_arn = aws_lb.WebaapProjectLB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebaapProjectLBTargetG.arn
  }
}

# CREATING LOAD BALANCER


resource "aws_lb" "WebaapProjectLB" {
  name               = "WebaapProjectLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.WebaapProjectSG.id]
  subnets            = [aws_subnet.WebbappProject_ap-south-1b.id,aws_subnet.WebbappProject_ap-south-1a.id]


  tags = {
    Environment = "production"
  }
}

# Creating Attachement with TG for 01
resource "aws_lb_target_group_attachment" "WebaapProjectLBattachement01" {
  target_group_arn = aws_lb_target_group.WebaapProjectLBTargetG.arn
  target_id        = aws_instance.ServerInsideVpc1.id
  port             = 80
}

# Creating Attachement with TG for 02

resource "aws_lb_target_group_attachment" "WebaapProjectLBattachement02" {
  target_group_arn = aws_lb_target_group.WebaapProjectLBTargetG.arn
  target_id        = aws_instance.ServerInsideVpc2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "WebaapProjectLBattachement03" {
  target_group_arn = aws_lb_target_group.WebaapProjectLBTargetG.arn
  target_id        = aws_instance.ServerInsideVpc3_private.id
  port             = 80
}

