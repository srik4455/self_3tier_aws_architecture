variable "project_name" {
  type = string
}
variable "my_vpc" {
  type = string

}

variable "my_vpc_cidr" {
  type = string
}
variable "my_public_subnet" {
  type = list(string)
}

variable "my_public_subnet_cidr" {
  type = list(string)
}

variable "my_private_subnet" {
  type = list(string)
}

variable "my_private_subnet_cidr" {
  type = list(string)
}

variable "my_db_subnet" {
  type = list(string)
}

variable "my_db_cidr" {
  type = list(string)
}
