##Outputs

output "ami_arn" {
  value = data.aws_ami.myami.arn
}

output "ami_date" {
  value = data.aws_ami.myami.creation_date
}

output "web_pubip" {
  value = aws_instance.web.public_ip
}
output "web_pvtip" {
  value = aws_instance.web.private_ip
}
output "web_endpoint" {
  value = "http://${aws_instance.web.public_ip}:80/"
}
