resource "aws_security_group" "tt_k8s_sg" {

  name_prefix = var.cluster_name
  description = "EKS cluster security group."
  vpc_id      = aws_vpc.tt-devops.id

  ingress {
      description      = "secure web connection"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = var.tt_private_networks
    }

   ingress {
      description      = "insecure web connection"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = var.tt_private_networks
    }

    ingress {
      description      = "Minimum inbound traffic"
      from_port        = 10250
      to_port          = 10250
      protocol         = "tcp"
      cidr_blocks      = var.tt_private_networks
    }
    

    ingress{
      description      = "ssh port for accessing k8s cluster"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.tt_private_networks
    }

    egress {
    description      = "Minimum outbound traffic"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
      Name = "${var.cluster_name}-sg",
      Owner = "DevOps"
    }
}