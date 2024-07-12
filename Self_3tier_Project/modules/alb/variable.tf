variable "public_subnet_id" {
  type = list(string)

}
variable "private_subnet_id" {
  type = list(string)
}

variable "web_instances_id" {
  type = list(string)

}
variable "app_instances_id" {
  type = list(string)
}
# variable "db_instances_id" {
#   type = list(string)
# }
variable "vpc_id" {
  type = string

}

variable "public_sg_id" {
  type = string

}
variable "private_sg_id" {
  type = string

}
# variable "db_sg_id" {
#   type = string

# }

