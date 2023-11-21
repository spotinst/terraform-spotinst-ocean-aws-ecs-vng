# Spot Ocean ECS Launchspec Terraform Module

## Prerequisites

* Have an ECS cluster created and integrated with Ocean on Spot.io
* Spot Account and API Token

## Usage
```hcl
### Create Ocean ECS Cluster ###
module "ocean_ecs" {
  source = "spotinst/ocean-aws-ecs/spotinst"

  cluster_name                    = "ECS-Workshop"
  desired_capacity                = 0
  region                          = "us-west-2"
  subnet_ids                      = ["subnet-123456789, subnet-123456789, subnet-123456789, subnet-123456789"]
  security_group_ids              = ["sg-123456789"]
  iam_instance_profile            = "arn:aws:iam::123456789:instance-profile/ecsInstanceRole"
  images                          = [{image_id="ami-123456"},{image_id="ami-67890"}]
  tags                            = {CreatedBy = "terraform"}
}

### Create Ocean ECS Launchspec ###
module "ocean_ecs_launchspec" {
  source = "spotinst/ocean-aws-ecs-vng/spotinst"

  name                            = "VNG1"
  ocean_id                        = module.ocean_ecs.ocean_id
  attributes                      = {Test = "example"}

  tags                            = {CreatedBy = "terraform"}
}

### Outputs ###
output "ocean_id" {
  value = module.ocean_ecs.ocean_id
}
output "ocean_launchspec_id" {
  value = module.ocean_ecs_launchspec.launchspec_id
}
```

## Providers

| Name | Version   |
|------|-----------|
| spotinst | >= 1.78.0 |

## Modules
* `ocean-aws-ecs` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/spotinst/ocean-aws-ecs/spotinst/latest)
* `ocean-aws-ecs-vng` - (Optional) Add custom virtual node groups

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Inputs

| Name                                                                                                                            | Description                                                                                                                                                                                                                                                                                                                                               | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_ocean_id"></a> [ocean\_id](#input\_ocean\_id)                                                                    | The Ocean cluster identifier. Required for Launch Spec creation.                                                                                                                                                                                                                                                                                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `null` | yes |
| <a name="input_name"></a> [name](#input\_name)                                                                                  | User given name of the virtual node group..                                                                                                                                                                                                                                                                                                                            | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `null` | no |
| <a name="input_images"></a> [images](#input\_images)                        | You can configure VNG with either the imageId or images objects, but not both simultaneously. <br> For each architecture type (amd64, arm64) only one AMI is allowed.<br>  Valid values: null, or an array with at least one element.                                                                                                                     | <pre>list(object({<br>    image_id                = string <br>  }))</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `null` | no |


## Contributing

Please see the [contribution guidelines](CONTRIBUTING.md).

## License

Code is licensed under the [Apache License 2.0](LICENSE).
