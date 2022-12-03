## Launchspec Variables ##
variable "name" {
  type        = string
  description = "The Ocean Launch Specification name."
}
variable "ocean_id" {
  type        = string
  description = "The Ocean cluster ID"
}
variable "user_data" {
  type        = string
  default     = null
  description = "Base64-encoded MIME user data to make available to the instances."
}
variable "image_id" {
  type        = string
  default     = null
  description = "ID of the image used to launch the instances."
}
variable "iam_instance_profile" {
  type        = string
  default     = null
  description = "The ARN or name of an IAM instance profile to associate with launched instances."
}
variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "One or more security group ids"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "Optionally adds tags to instances launched in an Ocean cluster."
}
variable "instance_types" {
  type        = list(string)
  default     = null
  description = "A list of instance types allowed to be provisioned for pods pending under the specified launch specification. The list overrides the list defined for the Ocean cluster."
}
variable "restrict_scale_down" {
  type        = bool
  default     = null
  description = "When set to “True”, VNG nodes will be treated as if all pods running have the restrict-scale-down label. Therefore, Ocean will not scale nodes down unless empty."
}
variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "One or more security group ids"
}
###################

## Block Device Mappings ##
variable "block_device_mappings" {
  type 								= object({
    device_name						= string
    delete_on_termination 			= bool
    encrypted 						= bool
    iops 							= number
    kms_key_id 						= string
    snapshot_id 					= string
    volume_type 					= string
    volume_size						= number
    throughput						= number
    no_device 						= string
  })
  default 							= null
  description 						= "Block Device Mapping Object"
}

variable "dynamic_volume_size" {
  type 					  = object({
    base_size						= number
    resource 						= string
    size_per_resource_unit			= number
  })
  default 							= null
  description 						= "dynamic_volume_size Object"
}
##################

## Attributes ##
variable "attributes" {
  type        = map(string)
  default     = null
  description = "Optionally adds labels to instances launched in an Ocean cluster."
}

## Headroom ##
variable "cpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "memory_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the amount of memory (MiB) to allocate for each headroom unit."
}
variable "num_of_units" {
  type        = number
  default     = 0
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU, memory and GPU."
}
##################

## Scheduled Task ##
variable "scheduling_task" {
  type 				    = object({
    is_enabled 		    = bool
    cron_expression 	= list(string)
    task_type 	        = string
    num_of_units 		= number
    cpu_per_unit 		= number
    memory_per_unit     = number
  })
  default 				= null
  description 			= "Scheduled Task Block"
}