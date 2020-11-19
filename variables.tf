variable "rgname" {
    type = string
    description = "(optional) describe your resourcegrp"
    
}

variable "image" {
    type = string
    description = "(optional) describe your variable"
    default = "myPackerImagenew"
}
variable "noofvm" {

    type = number
    description = "(optional) Enter the number of VM"
}
variable "name" {
    type = string
    description = "(optional) describe your variable"
}