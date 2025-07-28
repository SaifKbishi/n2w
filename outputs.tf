output "aws_instance_public_dns" {
    value = "http://${aws_instance.n2w_v440.public_dns}"
    description = "Public DNS for n2w instnace"
}