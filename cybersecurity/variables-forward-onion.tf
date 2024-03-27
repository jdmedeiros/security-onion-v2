variable "onion_forward_ami" {
type = string
default = "ami-080e1f13689e07408"
}

variable "onion_forward_type" {
  type = string
  default = "m5.large"
}

variable "cloud_config_onion_forward" {
  default = "cloud-config-onion-forward.sh"
}

variable "config_onion_forward" {
  default = "config-onion-forward.sh"
}

variable "update_fstab_onion_forward" {
default = "update-fstab-onion-forward.sh"
}

variable "config_netplan_onion_forward" {
  default = "50-cloud-init.yaml.patch"
}
