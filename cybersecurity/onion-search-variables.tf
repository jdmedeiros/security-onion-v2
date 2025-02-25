variable "onion_search_ami" {
  type    = string
  default = "ami-0e1bed4f06a3b463d"
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
