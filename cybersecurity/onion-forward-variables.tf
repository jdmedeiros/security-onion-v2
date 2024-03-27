variable "onion_forward_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "onion_forward_type" {
  type    = string
  default = "m5.large"
}

variable "cloud_config_onion_forward" {
  default = "onion-forward-cloud-config.sh"
}

variable "config_onion_forward" {
  default = "onion-forward-config.sh"
}

variable "config_netplan_onion_forward" {
  default = "50-cloud-init.yaml.patch"
}
