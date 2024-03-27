variable "kali_ami" {
  type = string
  default = "ami-052c14fe577c45df1"
}

variable "kali_type" {
  type = string
  default = "m5.large"
}

variable "kali_userpw" {
  description = "Insert the pasword for the user kali"
  type = string
  sensitive   = true
}

variable "cloud-config-kali" {
  default = "cloud-config-kali.sh"
}

variable "config-kali" {
  default = "config-kali.sh"
}

variable "kali-change-password" {
  default = "kali-change-password.sh"
}
