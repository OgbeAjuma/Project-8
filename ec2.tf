resource "aws_instance" "webserver1-proj8" {
  ami           = "ami-0fc15d50d39e4503c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG-proj8.id]
  subnet_id =  aws_subnet.pubsub-1.id
  availability_zone = "eu-west-2a"
  user_data         = file("install_apache.sh")

  tags = {
    Name = "HelloWorld-user"
  }
}

resource "aws_instance" "webserver2-proj8" {
  ami           = "ami-0fc15d50d39e4503c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG-proj8.id ]
  subnet_id =  aws_subnet.pubsub-2.id
  availability_zone = "eu-west-2b"

  tags = {
    Name = "HelloWorld-user"
  }
}