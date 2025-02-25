variable "onion_manager_ami" {
  type    = string
  default = "ami-0e1bed4f06a3b463d"
}

variable "onion_manager_type" {
  type    = string
  default = "m5.large"
}

variable "onion_manager_cloud_config" {
  default = "onion-manager-cloud-config.sh"
}

variable "onion_manager_config" {
  default = "onion-manager-config.sh"
}

variable "onion_manager_config_netplan" {
  default = "50-cloud-init.yaml.patch"
}
