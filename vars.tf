variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
    default = "ap-southeast-1"
}
variable "key_path" {}
variable "amis" {
    type    =     "map"
    default = {
        ap-southeast-1 = "ami-0615132a0f36d24f4"
    }
} 