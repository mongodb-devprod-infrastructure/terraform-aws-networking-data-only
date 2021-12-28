data "aws_availability_zones" "this" {
  filter {
    name   = "zone-name"
    values = var.availability_zones
  }
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }

  state = "available"
}

data "aws_subnet_ids" "this" {
  dynamic "filter" {
    for_each = length(data.aws_availability_zones.this.names) > 0 ? range(1) : range(0)

    content {
      name   = "availability-zone"
      values = data.aws_availability_zones.this.names
    }
  }

  vpc_id = data.aws_vpc.this.id
}

data "aws_subnet" "this" {
  for_each = data.aws_subnet_ids.this.ids

  id = each.value
}
