

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
  default = "xxxxxx" ## resource group in server.json
}


variable "managed_image_name" {
  default = "myPackerImage"
}

variable "admin_user" {
    default = "xxxxx" ## user name for vms in terrafrom file
  
}
variable "admin_password" {
  default = "xxxxxx" ## password for vms in terraform file
}