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

  block_device_mappings = {
    device_name           = "/dev/xvda"
    delete_on_termination = true
    encrypted             = true
    iops                  = 300
    kms_key_id            = local.kms_key_arn
    snapshot_id           = module.ami_creation.snapshot_id
    volume_type           = "gp3"
    volume_size           = 100
    throughput            = null
    base_size             = 0
  }

  tags = { CreatedBy = "terraform" }
}


output "ocean_id" {
  value = module.ocean_ecs.ocean_id
}

output "ocean_launchspec_id" {
  value = module.ocean_ecs_launchspec.launchspec_id
}
