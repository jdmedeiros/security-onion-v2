terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.56.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.3.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  #access_key = "xxxx"
  #secret_key = "xxxx"
  #token = "xxxx"

  profile = "vocareum"
}

provider "cloudinit" {
}

data "template_cloudinit_config" "config-onion" {
  gzip          = false
  base64_encode = false

  part {
    filename     = var.cloud_config_onion_manager
    content_type = "text/x-shellscript"
    content      = file(var.cloud_config_onion_manager)
  }

  part {
    filename     = var.config_onion_manager
    content_type = "text/x-shellscript"
    content      = file(var.config_onion_manager)
  }

  part {
    filename     = var.config_netplan_onion_manager
    content_type = "text/x-shellscript"
    content      = file(var.config_netplan_onion_manager)
  }

  part {
    filename     = var.config-NetworkMiner
    content_type = "text/x-shellscript"
    content      = file(var.config-NetworkMiner)
  }
  part {
    filename     = var.config-45-allow-colord
    content_type = "text/plain"
    content      = file(var.config-45-allow-colord)
  }
}

data "template_cloudinit_config" "config-kali" {
  gzip          = false
  base64_encode = false

  part {
    filename     = var.kali-change-password
    content_type = "text/x-shellscript"
    content      = data.template_file.kali-password.rendered
  }

  part {
    filename     = var.cloud-config-kali
    content_type = "text/x-shellscript"
    content      = file(var.cloud-config-kali)
  }

  part {
    filename     = var.config-kali
    content_type = "text/x-shellscript"
    content      = file(var.config-kali)
  }

  part {
    filename     = var.config-NetworkMiner
    content_type = "text/x-shellscript"
    content      = file(var.config-NetworkMiner)
  }

  part {
    filename     = var.config-45-allow-colord
    content_type = "text/plain"
    content      = file(var.config-45-allow-colord)
  }
}

data "template_cloudinit_config" "config-sift" {
  gzip          = false
  base64_encode = false

  part {
    filename     = var.sift-change-password
    content_type = "text/x-shellscript"
    content      = data.template_file.sift-password.rendered
  }

  part {
    filename     = var.cloud-config-sift
    content_type = "text/x-shellscript"
    content      = file(var.cloud-config-sift)
  }

  part {
    filename     = var.config-sift
    content_type = "text/x-shellscript"
    content      = file(var.config-sift)
  }

  part {
    filename     = var.config-NetworkMiner
    content_type = "text/x-shellscript"
    content      = file(var.config-NetworkMiner)
  }

  part {
    filename     = var.config-45-allow-colord
    content_type = "text/plain"
    content      = file(var.config-45-allow-colord)
  }
}

data "template_cloudinit_config" "config-remnux" {
  gzip          = false
  base64_encode = false

  part {
    filename     = var.remnux-change-password
    content_type = "text/x-shellscript"
    content      = data.template_file.remnux-password.rendered
  }

  part {
    filename     = var.cloud-config-remnux
    content_type = "text/x-shellscript"
    content      = file(var.cloud-config-remnux)
  }

  part {
    filename     = var.config-remnux
    content_type = "text/x-shellscript"
    content      = file(var.config-remnux)
  }

  part {
    filename     = var.config-NetworkMiner
    content_type = "text/x-shellscript"
    content      = file(var.config-NetworkMiner)
  }

  part {
    filename     = var.config-45-allow-colord
    content_type = "text/plain"
    content      = file(var.config-45-allow-colord)
  }
}