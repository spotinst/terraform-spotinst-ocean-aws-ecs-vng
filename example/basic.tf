#### Create Ocean ECS Cluster ####
module "ocean_ecs" {
  source = "spotinst/ocean-aws-ecs/spotinst"

  cluster_name         = "ECS-Workshop"
  desired_capacity     = 0
  region               = "us-west-2"
  subnet_ids           = ["subnet-123456789, subnet-123456789, subnet-123456789, subnet-123456789"]
  security_group_ids   = ["sg-123456789"]
  iam_instance_profile = "arn:aws:iam::123456789:instance-profile/ecsInstanceRole"
  tags = { CreatedBy = "terraform" }
}


module "ocean_ecs_launchspec" {
  source = "spotinst/ocean-aws-ecs-vng/spotinst"

  name       = "VNG1"
  ocean_id   = module.ocean_ecs.ocean_id
  attributes = { Test = "example" }
  images     = [{image_id="ami-123456"},{image_id="ami-67890"}]
  tags       = { CreatedBy = "terraform" }
}

output "ocean_id" {
  value = module.ocean_ecs.ocean_id
}

output "ocean_launchspec_id" {
  value = module.ocean_ecs_launchspec.launchspec_id
}
