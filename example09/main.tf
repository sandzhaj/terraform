provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name  = "example9"
      Owner = "Mark"
    }
  }
}


data "aws_availability_zones" "availible" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}


data "aws_vpc" "prod_vpc" {}


resource "aws_subnet" "prod_subnet_1" {
  count             = length(data.aws_availability_zones.availible.names)
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.availible.names[count.index]
  cidr_block        = "10.10.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.availible.names[0]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}



output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "prod_vpc_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}


output "data_aws_availability_zones" {
  value = data.aws_availability_zones.availible.names
}


output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "data_aws_region_description" {
  value = data.aws_region.current.description
}
