variable "onion_search_ami" {
  type    = string
  default = "ami-080e1f13689e07408"
}

variable "onion_search_type" {
  type    = string
  default = "m5.large"
}

variable "onion_search_cloud_config" {
  default = "onion-search-cloud-config.sh"
}

variable "onion_search_config" {
  default = "onion-search-config.sh"
}

variable "onion_search_config_netplan" {
  default = "50-cloud-init.yaml.patch"
}
