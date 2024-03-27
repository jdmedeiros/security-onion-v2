variable "onion_manager_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "onion_manager_type" {
  type    = string
  default = "m5.large"
}

variable "cloud_config_onion_manager" {
  default = "onion-manager-cloud-config.sh"
}

variable "config_onion_manager" {
  default = "onion-manager-config.sh"
}

variable "config_netplan_onion_manager" {
  default = "50-cloud-init.yaml.patch"
}
