##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##################################################################################
# RESOURCES
##################################################################################

# INSTANCES #
resource "aws_instance" "n2w_440_SC" {
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.n2w_public_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  depends_on             = [aws_iam_role_policy.allow_s3_all]

  user_data = <<EOF
#! /bin/bash
CPMCONFIG
[SERVER]
user=adminDR
password=mABg??kn?vCXY(%WMB)RJjI-W2ti9n-p
volume_option=existing
volume_type=gp3
volume_id=vol-0455a5fd5c5c95ae6
time_zone=Asia/Jerusalem
allow_anonymous_reports=False
force_recovery_mode=False
CPMCONFIGEND
EOF

  tags = {
    Name    = "terraform instance 01"
    Project = local.common_tags.project
    Company = local.common_tags.company
  }

}








#  tags = merge(
#    local.common_tags,
#    {
#      Name        = "N2W v4.4.0"
#      DataType    = "Logs"
#    }
#  )
