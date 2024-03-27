resource "aws_instance" "onion-manager" {
  ami           = var.onion_manager_ami
  instance_type = var.onion_manager_type
  key_name      = aws_key_pair.CyberSecurity.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.onion_manager_nic_public1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.onion_manager_nic_private1.id
  }
  network_interface {
    device_index         = 2
    network_interface_id = aws_network_interface.onion_manager_nic_private2.id
  }
  tags = {
    "Name" = "onion-manager"
  }
  root_block_device {
    delete_on_termination = true
    tags = {
      "Name" = "Volume for onion-manager"
    }
    volume_size = 64
    volume_type = "gp2"
  }

  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_size           = 100
    delete_on_termination = true
    volume_type           = "gp2"
  }

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 100
    delete_on_termination = true
    volume_type           = "gp2"
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = 100
    delete_on_termination = true
    volume_type           = "gp2"
  }

  user_data = data.template_cloudinit_config.onion-manager-config.rendered
}

resource "aws_network_interface" "onion_manager_nic_private1" {
  private_ips = ["10.0.1.11"]
  security_groups = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check = false
  subnet_id         = aws_subnet.subnet_private1.id
  tags = {
    "Name" = "CyberSecurity onion-manager private1 interface"
  }
}

resource "aws_network_interface" "onion_manager_nic_private2" {
  private_ips = ["10.0.2.11"]
  security_groups = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check = false
  subnet_id         = aws_subnet.subnet_private2.id
  tags = {
    "Name" = "CyberSecurity onion-manager private2 interface"
  }
}

resource "aws_network_interface" "onion_manager_nic_private3" {
  private_ips = ["10.0.3.11"]
  security_groups = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check = false
  subnet_id         = aws_subnet.subnet_private3.id
  tags = {
    "Name" = "CyberSecurity onion-manager private3 interface"
  }
}

resource "aws_network_interface" "onion_manager_nic_public1" {
  private_ips = ["10.0.0.11"]
  security_groups = [
    aws_security_group.cyber_default.id,
  ]
  source_dest_check = false
  subnet_id         = aws_subnet.subnet_public1.id
  tags = {
    "Name" = "CyberSecurity onion-manager public interface"
  }
}

resource "aws_eip" "onion_manager_public_ip" {
  domain                 = "vpc"
  network_interface         = aws_network_interface.onion_manager_nic_public1.id
  tags                                 = {
    "Name" = "CyberSecurity onion-manager public IP"
  }
  depends_on = [
    aws_instance.onion-manager
  ]
}