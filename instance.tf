resource "aws_key_pair" "hoangviet88vn" {
    key_name                    = "hoangviet88vn"
    public_key                  = "${file("${var.key_path}/id_rsa.pub")}"
}
resource "aws_instance" "lab01" {
    ami                         =  "${lookup(var.amis , var.aws_region )}"
    instance_type               =  "t2.micro"
    key_name                    =  "hoangviet88vn"
    associate_public_ip_address =   true
    security_groups             =   ["launch-wizard-1"]

    connection {
    type                        =  "ssh"
    user                        =  "ec2-user"
    private_key                 =  "${file("${var.key_path}/id_rsa")}"
    host                        =  self.public_ip
    }
    provisioner "remote-exec" {
    inline = ["uptime"]
    }
    provisioner "local-exec"  {
    command = "echo server01 ansible_host=${self.public_ip} >> hosts ; ansible-playbook -i hosts -u ec2-user -b --private_key /home/hoangvietitvn/.ssh/id_rsa"
    }
}