# display IP addresses of instances
output "jenkins_server_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "sonarqube_server_ip" {
  value = aws_instance.sonarqube_server.public_ip
}
