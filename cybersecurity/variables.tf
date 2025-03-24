variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+PJ+x6O3xPh1/GwWG3vA4GmRBM6UON3pFXdyLNunz9KMHefn1B8cfx0TMuz20mBeQPl+OaruqjrCdzRGMB/ZmjeJIMlyN70A+3ScBYWWQsVG8tOYKzw8mfSuT5knbXh0SDho4fLq6d64fi/csktN3aOf8SB9QKLPpphY9+BxvAXupPPv4iNg5+dhMCV46lMYTkncArZCzEIpU/gocP8osPXizzSMWeSgGgo9y93jqDQVZIrefqQCDKRy5QJ0hpbwO7uvIcaWn6X8vr+GtPS9ajTCUz7ekWAMd1WgHF5Ye8AAFt7sLPS3gvPGBaxi11NCcKuRLoQpcc+rT16VYpa3T ubuntu@control.cyber.local"
}

variable "avail_zone" {
  type    = string
  default = "us-east-1a"
}

variable "vpc_ep_svc_name" {
  type    = string
  default = "com.amazonaws.us-east-1.s3"
}

variable "config-NetworkMiner" {
  default = "NetworkMiner.desktop"
}

variable "config-45-allow-colord" {
  default = "45-allow-colord.sh"
}
