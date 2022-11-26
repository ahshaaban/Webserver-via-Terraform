

 variable "location" {
  default = "West Europe"
 }

variable "application_port" {
  Default = 80
}

variable "resource_group_name" {
  default = "web-srv-rg"
}

variable "resource_group_name" {

    packer_resource_group_name = "ODL-clouddevops-216708"
  
}

variable "image" {

    managed_image_name = "myPackerImage"
  
}
variable "admin_user" {
    default = admin_user
  
}
variable "admin_password" {
  default = admin_password
}