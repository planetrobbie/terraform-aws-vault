/*------------------------------------------------
Configuration variables to determine the topology of
the cluster
------------------------------------------------*/
variable "use_asg" {
  description = "a variable set to true or false depending on whether the vault cluster will be inside an ASG or not"
  type        = "string"
  default     = false
}

variable "use_elb" {
  description = "a variable set to true or false depending on whether the vault cluster will use an ELB or not"
  type        = "string"
  default     = false
}

/*------------------------------------------------
Vault Cluster Variables
Variables that define the cluster instances
------------------------------------------------*/
variable "cluster_name" {
  description = "The name of the Vault cluster (e.g. vault-stage). This variable is used to namespace all resources created by this module."
  type        = "string"
}

variable "ami_id" {
  description = "The ID of the AMI to run in this cluster. Should be an AMI that had Vault installed and configured by the install-vault module."
  type        = "string"
}

variable "instance_type" {
  description = "The type of EC2 Instances to run for each node in the cluster (e.g. t2.micro)."
  type        = "string"
}

variable "ssh_key_name" {
  description = "The AWS ssh key to use to build instances in the vault cluster"
  type        = "string"
}

variable "additional_sg_ids" {
  description = "A list of security groups to attach to instances in the vault cluster beyond the standard vault ones"
  type        = "list"
}

variable "private_subnets" {
  description = "A list private subnets the vault cluster will be deployed into"
  type        = "list"
}

variable "availability_zones" {
  description = "A list AZs the vault cluster will be deployed into"
  type        = "list"
}

variable "vpc_id" {
  description = "The ID of the VPC this will be provisioned in"
  type        = "string"
}

/*------------------------------------------------
Optional variables that have sensible defaults
------------------------------------------------
Cluster size variables
------------------------------------------------*/
variable "vault_cluster_size" {
  description = "The size (number of instances) in the Vault cluster without an ASG"
  type        = "string"
  default     = 3
}

variable "vault_cluster_size_min" {
  description = "The min size (number of instances) in the Vault cluster ASG"
  type        = "string"
  default     = 3
}

variable "vault_cluster_size_max" {
  description = "The max size (number of instances) in the Vault cluster ASG"
  type        = "string"
  default     = 3
}

variable "vault_cluster_size_des" {
  description = "The desired size (number of instances) in the Vault cluster ASG"
  type        = "string"
  default     = 3
}

variable "consul_cluster_size" {
  description = "The size (number of instances) in the consul cluster"
  type        = "string"
  default     = 3
}

/*------------------------------------------------
ASG Variables for health checking
------------------------------------------------*/
variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  default     = 300
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = "string"
  default     = "10m"
}

variable "enabled_metrics" {
  description = "List of autoscaling group metrics to enable."
  type        = "list"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  type        = "string"
  default     = "Default"
}

/*------------------------------------------------
variables to manage ELB behaviour
------------------------------------------------*/
variable "cross_zone_load_balancing" {
  description = "Set to true to enable cross-zone load balancing and you have your vault cluster set up across multiple AZs as per the RA"
  type        = "string"
  default     = true
}

variable "idle_timeout" {
  description = "The time, in seconds, that the connection is allowed to be idle."
  type        = "string"
  default     = 60
}

variable "connection_draining" {
  description = "Set to true to enable connection draining."
  type        = "string"
  default     = true
}

variable "connection_draining_timeout" {
  description = "The time, in seconds, to allow for connections to drain."
  type        = "string"
  default     = 300
}

variable "lb_port" {
  description = "The port the load balancer should listen on for API requests."
  type        = "string"
  default     = 8200
}

variable "vault_api_port" {
  description = "The port to listen on for API requests."
  type        = "string"
  default     = 8200
}

/*------------------------------------------------
Variables for ELB Health Checking.
 This is used for traffic direction, not for ASG
healthy status as Vault has several states that
are more complex than healthy/unhealthy
------------------------------------------------*/
variable "health_check_protocol" {
  description = "The protocol to use for health check. As we are using TLS this will be HTTPS."
  type        = "string"
  default     = "HTTPS"
}

variable "health_check_path" {
  description = "The Vaulkt API path to hit."
  type        = "string"
  default     = "/v1/sys/health"
}

variable "health_check_interval" {
  description = "The interval between checks (seconds)."
  type        = "string"
  default     = 15
}

variable "health_check_healthy_threshold" {
  description = "The number of health checks that must pass before the instance is declared healthy."
  type        = "string"
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "The number of health checks that must fail before the instance is declared unhealthy."
  type        = "string"
  default     = 2
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, before a health check times out."
  type        = "string"
  default     = 5
}
