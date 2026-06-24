variable "cluster_name" {
  default = "voting-app"
}

variable "vpc_id" {}

variable "private_subnets" {
  type = list(string)
}
