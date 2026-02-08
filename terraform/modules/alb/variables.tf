variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "service_name" {
  type = string
}

variable "certificate_arn" {
  type = string
}

