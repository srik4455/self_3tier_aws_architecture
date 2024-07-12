variable "web_instances" {
  type    = list(string)
  default = ["web1", "web2"]

}

variable "app_instances" {
  type    = list(string)
  default = ["app1", "app2"]

}

variable "db_instances" {
  type    = list(string)
  default = ["db1", "db2"]

}

variable "vpc_id" {
  type = string

}

variable "public_sg_id" {
  type = string

}
variable "private_sg_id" {
  type = string

}
variable "db_sg_id" {
  type = string

}
variable "public_subnet_id" {
  type = list(string)

}

variable "private_subnet_id" {
  type = list(string)

}
variable "db_subnet_id" {
  type = list(string)

}





