variable "ebs_zone" {

}
variable "ebs_size" {
    default = 50
    type = number
}
variable "ebs_tags" {
    type = map
    default = {
        Name = "ebs_volume"
    }
}