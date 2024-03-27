variable "onion_manager_ami" {
type = string
default = "ami-080e1f13689e07408"
}

variable "onion_manager_type" {
  type = string
  default = "m5.large"
}

variable "cloud_config_onion_manager" {
  default = "cloud-config-onion-manager.sh"
}

variable "config_onion_manager" {
  default = "config-onion-manager.sh"
}

variable "update_fstab_onion_manager" {
default = "update-fstab-onion-manager.sh"
}

variable "config_netplan_onion_manager" {
  default = "50-cloud-init.yaml.patch"
}
