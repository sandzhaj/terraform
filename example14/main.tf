provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      Name  = "example12"
      Owner = "Mark"
    }
  }
}

# LOCAL VARS
locals {
    aws_zones = data.aws_availability_zones.exist.names
}

# SUBNETS
resource "aws_default_subnet" "df_subnet" {
    count = length(local.aws_zones)
    availability_zone = local.aws_zones[count.index]
    tags = merge(var.default_tags, { Name = "Subnet ${count.index + 1}"})
}