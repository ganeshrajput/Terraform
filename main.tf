
#CREATING INSTANCE IN SUBNET 1B
resource "aws_instance" "ServerInsideVpc1" {
  ami                     = "ami-0ee3950be11ebc3ae"
  instance_type           = "t2.micro"
  key_name = aws_key_pair.loginkey.id
  subnet_id = aws_subnet.WebbappProject_ap-south-1a.id
  vpc_security_group_ids = [aws_security_group.WebaapProjectSG.id]
  user_data = <<EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install default-jre -y
  EOF


tags = {
    Name = "ServerInsideVpc1"
}
}

#CREATING INSTANCE IN SUBNET 1B
resource "aws_instance" "ServerInsideVpc2" {
  ami                     = "ami-0ee3950be11ebc3ae"
  instance_type           = "t2.micro"
  key_name = aws_key_pair.loginkey.id
  subnet_id = aws_subnet.WebbappProject_ap-south-1b.id
  vpc_security_group_ids = [aws_security_group.WebaapProjectSG.id]
  user_data = <<EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install default-jre -y
  EOF

tags = {
    Name = "ServerInsideVpc2"
}
}

#CREATING INSTANCE IN SUBNET 1B PRIVATE

resource "aws_instance" "ServerInsideVpc3_private" {
  ami                     = "ami-0ee3950be11ebc3ae"
  instance_type           = "t2.micro"
  key_name = aws_key_pair.loginkey.id
  subnet_id = aws_subnet.WebbappProject_ap-south-1b_private.id
  vpc_security_group_ids = [aws_security_group.WebaapProjectSG.id]
  user_data = <<EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt install default-jre -y
  EOF

tags = {
    Name = "ServerInsideVpc3_private"
}
}



