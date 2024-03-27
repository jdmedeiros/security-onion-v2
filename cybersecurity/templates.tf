data "template_file" "kali-password" {
  template = file("${path.module}/kali-change-password.tpl")

  vars = {
    userid = "kali",
    userpw = var.kali_userpw
  }
}

data "template_file" "sift-password" {
  template = file("${path.module}/sift-change-password.tpl")

  vars = {
    userid = "sansforensics",
    userpw = var.sift_userpw
  }
}


data "template_file" "remnux-password" {
  template = file("${path.module}/remnux-change-password.tpl")

  vars = {
    userid = "remnux",
    userpw = var.remnux_userpw
  }
}
