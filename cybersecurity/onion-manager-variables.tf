variable "onion_manager_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
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
