provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "proj2" {
  depends_on = [aws_db_instance.default]
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id   = "subnet-010656811f3381d92"
  key_name = "Naveen06training"
  user_data = templatefile("${path.module}/userdata.tftpl", {endpoint = aws_db_instance.default.endpoint,password = aws_db_instance.default.password})
   iam_instance_profile = "demo-Role"
  security_groups = ["sg-0b947349537e69ed2"]
  tags = {
    Name = "cpms"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "cpms"
  identifier           = "myrdb"
  username             = "admin"
  password             = "Naveen1999"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = ["sg-0b947349537e69ed2"]
}
