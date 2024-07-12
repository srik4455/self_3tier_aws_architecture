resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  key_name                    = "aws"
  count                       = length(var.web_instances)
  subnet_id                   = var.public_subnet_id[count.index]
  vpc_security_group_ids      = [var.public_sg_id]
  availability_zone           = data.aws_availability_zones.available.names[count.index]
  associate_public_ip_address = true


  tags = {
    Name = var.web_instances[count.index]
  }
  provisioner "file" {
    source      = "./aws.pem"
    destination = "/home/ec2-user/aws.pem"

  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./aws.pem")
    host        = self.public_ip
  }
}


resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  key_name                    = "aws"
  count                       = length(var.app_instances)
  subnet_id                   = var.private_subnet_id[count.index]
  vpc_security_group_ids      = [var.private_sg_id]
  availability_zone           = data.aws_availability_zones.available.names[count.index]
  associate_public_ip_address = false


  tags = {
    Name = var.app_instances[count.index]
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./aws.pem")
      host        = aws_instance.web[count.index].public_ip
    }
    inline = [
      "chmod 400 aws.pem; scp -i aws.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ./aws.pem ${self.private_ip}:/home/ec2-user/"
    ]

  }
  #   provisioner "file" {
  #     source      = "./aws.pem"
  #     destination = "/home/ec2-user/aws.pem"

  #   }
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("./aws.pem")
  #     host        = self.private_ip
  #   }
}

resource "aws_instance" "db" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  key_name                    = "aws"
  count                       = length(var.db_instances)
  subnet_id                   = var.db_subnet_id[count.index]
  vpc_security_group_ids      = [var.db_sg_id]
  availability_zone           = data.aws_availability_zones.available.names[count.index]
  associate_public_ip_address = false


  tags = {
    Name = var.db_instances[count.index]
  }

}

