resource "spotinst_ocean_ecs_launch_spec" "ocean_ecs_launchspec" {
  ocean_id                    = var.ocean_id
  name                        = var.name
  user_data                   = var.user_data
  image_id                    = var.image_id
  iam_instance_profile        = var.iam_instance_profile
  security_group_ids          = var.security_group_ids

  # Default Provider Tags
  dynamic tags {
    for_each = data.aws_default_tags.default_tags.tags
    content {
      key = tags.key
      value = tags.value
    }
  }
  # Additional Tags
  dynamic tags {
    for_each = var.tags == null ? {} : var.tags
    content {
      key = tags.key
      value = tags.value
    }
  }

  instance_types                = var.instance_types
  restrict_scale_down           = var.restrict_scale_down
  subnet_ids                    = var.subnet_ids

  dynamic attributes {
    for_each = var.attributes == null ? {} : var.attributes
    content {
      key = attributes.key
      value = attributes.value
    }
  }

  autoscale_headrooms {
    cpu_per_unit                = var.cpu_per_unit
    memory_per_unit             = var.memory_per_unit
    num_of_units                = var.num_of_units
  }


  dynamic "scheduling_task" {
    for_each = var.scheduling_task != null ? [var.scheduling_task] : []
    content {
      is_enabled              = scheduling_task.value.is_enabled
      cron_expression         = scheduling_task.value.cron_expression
      task_type               = scheduling_task.value.task_type
      task_headroom {
        num_of_units          = scheduling_task.value.num_of_units
        cpu_per_unit          = scheduling_task.value.cpu_per_unit
        memory_per_unit       = scheduling_task.value.memory_per_unit
      }
    }
  }

  ## Block Device Mappings ##
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings != null ? [var.block_device_mappings] : []
    content {
      device_name = block_device_mappings.value.device_name
      no_device                   = block_device_mappings.value.no_device
      ebs {
        delete_on_termination       = block_device_mappings.value.delete_on_termination
        encrypted                   = block_device_mappings.value.encrypted
        iops                        = block_device_mappings.value.iops
        kms_key_id                  = block_device_mappings.value.kms_key_id
        snapshot_id                 = block_device_mappings.value.snapshot_id
        volume_type                 = block_device_mappings.value.volume_type
        volume_size                 = block_device_mappings.value.volume_size
        throughput                  = block_device_mappings.value.throughput
        dynamic dynamic_volume_size {
          for_each = var.dynamic_volume_size != null ? [var.dynamic_volume_size] : []
          content {
            base_size               = dynamic_volume_size.value.base_size
            resource                = dynamic_volume_size.value.resource
            size_per_resource_unit  = dynamic_volume_size.value.size_per_resource_unit
          }
        }
      }
    }
  }




}