
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIAXSDEXCWXH2WVZ5OT"
  secret_key = "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"
}


resource "aws_vpc" "MyLab-Vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
     Name = "MyLab-Vpc"
    
  }
}

# creating Subnet (Public)
resource "aws_subnet" "MyLab-Subnet1" {
  vpc_id     = aws_vpc.MyLab-Vpc.id
  cidr_block = var.cidr_block[1]

  tags = {
    Name = "MyLab-Subnet1"
  }
} 

# creating internet Gateway
resource "aws_internet_gateway" "MyLab-InternetGW" {
  vpc_id = aws_vpc.MyLab-Vpc.id

  tags = {
    Name = "MyLab-InternetGW"
  }
  
}
resource "aws_security_group" "MyLab_Sec_Group" {
  name = "MyLab Security Group"
  description = "To Allow inbound and outbound traffic to mylab"
  vpc_id = aws_vpc.MyLab-Vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
     from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

 tags = {
  Name = " Allow traffic"
 }   
}

resource "aws_s3_bucket" "Soomaali-wayn-bucket-01" {
  bucket = "mybest-one-bucket-001"

  tags = {
    Name        = "My-BestOne-bucket01"
    
  }
}

