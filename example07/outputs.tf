output "my_web_site_ip" {
  description = "Elatic IP address assigned to our WebSite"
  value       = aws_eip.my_static_ip.public_ip
}

output "full_eip_info" {
  value       = aws_eip.my_static_ip
}

