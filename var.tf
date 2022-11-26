

 variable "location" {
  type = string
  default = "West Europe"
 }
variable "resource_group_name" {
  type = string
  default = "web-srv-rg"
}
variable "application_port" {
  default = "80"
}



variable "packer_resource_group_name" {
  type = string
  default = "ODL-clouddevops-216720"
}


variable "managed_image_name" {
  default = "myPackerImage"
}

variable "admin_user" {
    default = "admin_user22"
  
}
variable "admin_password" {
  default = "admin_password22"
}