variable "onion_forward_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "onion_forward_type" {
  type    = string
  default = "m5.large"
}

variable "onion_forward_cloud_config" {
  default = "onion-forward-cloud-config.sh"
}

variable "onion_forward_config" {
  default = "onion-forward-config.sh"
}

variable "onion_forward_config_netplan" {
  default = "50-cloud-init.yaml.patch"
}
