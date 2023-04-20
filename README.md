<div align="center">
  <a href="https://github.com/mongodb-devprod-infrastructure/terraform-aws-networking-data-only">
    <img src="https://user-images.githubusercontent.com/2184329/145092072-d669fd86-de77-427e-aa78-7bc14e0bf531.png" width="200">
  </a>
  <h1>
    <code>terraform-aws-networking-data-only</code>
  </h1>
  <p>Returns descriptive information about an Amazon VPC</p>
</div>

## Purpose

This module is considered to be a [data-only](https://www.terraform.io/docs/language/modules/develop/composition.html#data-only-modules) module. Given the name of a VPC and an optional set of availability zones, this module returns information about a VPC, such as public and private subnets, the VPC ID, etc. See the [outputs](outputs.tf) file for which data is returned from this module. This module is useful for workspaces that require such information without declaring repetitive `data` sources in your Terraform configurations.

## Usage

The following example creates a security group and an application load balancer.

```hcl
provider "aws" {}

module "networking" {
  source = "github.com/mongodb-devprod-infrastructure/terraform-aws-networking-data-only"

  vpc_name = "tutorial-vpc"
}

resource "aws_security_group" "this" {
  ingress = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 443
      protocol    = "TCP"
      to_port     = 443
    }
  ]

  vpc_id = module.networking.vpc_id
}

resource "aws_lb" "this" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = module.networking.public_subnets
}
```

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Select subnets only in the given AZs | `set(string)` | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_hostnames_enabled"></a> [dns\_hostnames\_enabled](#output\_dns\_hostnames\_enabled) | Indicates if instances launched in this VPC will have public DNS hostnames |
| <a name="output_dns_support_enabled"></a> [dns\_support\_enabled](#output\_dns\_support\_enabled) | Indicates if DNS support is enabled for this VPC |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of private subnets in this VPC |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of public subnets in this VPC |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | Arn of this VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | CIDR range for this VPC |
| <a name="output_vpc_cidr_blocks"></a> [vpc\_cidr\_blocks](#output\_vpc\_cidr\_blocks) | All CIDR ranges for this VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

## Contributing

Please refer to the [CONTRIBUTING](docs/CONTRIBUTING.md) document for more information.

## License

[Apache License 2.0](LICENSE)
