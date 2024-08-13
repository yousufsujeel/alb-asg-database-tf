output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.autoscaling_group.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.ec2_launch_template.id
}