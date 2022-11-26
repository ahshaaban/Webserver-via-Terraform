

 variable "location" {
  default = "West Europe"
 }

variable "application_port" {
  Default = "80"
}

variable "resource_group_name" {
  default = "web-srv-rg"
}

variable "packer_resource_group_name" {
  default = "ODL-clouddevops-216708"
}


variable "managed_image_name" {
  default = "myPackerImage"
}

variable "admin_user" {
    default = admin_user
  
}
variable "admin_password" {
  default = admin_password
}