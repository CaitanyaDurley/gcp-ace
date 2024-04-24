variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {
    # This makes instance_type an optional variable
    default = "e2-micro"
}
variable "instance_network" {}
