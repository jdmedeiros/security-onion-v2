variable "onion_search_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "onion_search_type" {
  type    = string
  default = "m5.large"
}

variable "cloud_config_onion_search" {
  default = "onion-search-cloud-config.sh"
}

variable "config_onion_search" {
  default = "onion-search-config.sh"
}

variable "config_netplan_onion_search" {
  default = "50-cloud-init.yaml.patch"
}
