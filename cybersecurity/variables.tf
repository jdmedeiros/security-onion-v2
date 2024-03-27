variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCApU5n7mLRBOzVJMp0Jg3JsewtUmlrhSiSXdIGD7SDAE58dGJ2MMDXsbyd+AlmNRTotngbVgP7QS52hxzgqUwB4fQ6X4i9MtdRAUuT6Yb9v6+zTAm2Jx8bSQ8UKAXyPn1ah5H3QXRt38M3b7xkfca59xfSdHseriy5xbxJawCG2KeRFzNrISt0YswlNIeqyGmemRH0E2cseklhB+a08C1Yi4TTV+P+niASMHz10sqf8L24moMwXXskh6MFHqAdm8eAf0//rekpq9hdUQkFjue/KPtkNQ5qjYulexAe50GSSXU+K0f4zfXcbM48O69sAdjL0ivDj31V2dMMXDgTJ5zn"
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
