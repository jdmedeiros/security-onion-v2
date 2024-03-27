variable "onion_ami" {
type = string
default = "ami-080e1f13689e07408"
}

variable "onion_type" {
  type = string
  default = "m5.large"
}

variable "cloud-config-onion" {
  default = "cloud-config-onion.sh"
}

variable "config-onion" {
  default = "config-onion.sh"
}

variable "update-fstab" {
default = "update-fstab.sh"
}

variable "config-netplan" {
  default = "50-cloud-init.yaml.patch"
}
