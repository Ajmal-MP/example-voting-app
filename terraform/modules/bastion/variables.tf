variable "vpc_id" {}
variable "public_subnet" {}
variable "key_name" {}
variable "public_key_path" {}
variable "ami" {}
variable "instance_type" {
  default = "t3.micro"
}
