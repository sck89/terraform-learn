provider "aws" {
  region     = "ap-south-1"  
}

variable cidr_blocks {}

resource "aws_vpc" "vpc-dev"{
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name = var.cidr_blocks[0].name
        Environment = var.cidr_blocks[0].environment
    }
}

data "aws_vpc" "selected" {
    default = "false"
    tags = {
        Environment = "Dev"
    }
}

output "vpc_id"{
    value = data.aws_vpc.selected.id 
}

variable avail_zone{}
#from cmd use set TF_VAR_avail_zone=ap-south-1b
#that will set environment varaible avail_zone as ap-soth-1b
 
resource "aws_subnet" "public-subnet" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = var.avail_zone 
    cidr_block = var.cidr_blocks[1].cidr_block
    tags = {
        Name = var.cidr_blocks[1].name 
    }    
}

resource "aws_subnet" "private-subnet" {
    vpc_id = data.aws_vpc.selected.id
    availability_zone = "ap-south-1b"
    cidr_block = var.cidr_blocks[2].cidr_block
    tags = {
        Name = var.cidr_blocks[2].name
    }
}