
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix               = "${var.project_name}-${var.env}-launch-template"
  image_id                  = var.ami_id
  instance_type             = var.instance_type
  vpc_security_group_ids    = var.ec2_security_group_id
  key_name                  = var.key_name
  user_data                 = var.user_data_base64

  iam_instance_profile  { 
      name = aws_iam_instance_profile.instance_profile.name 
             }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.project_name}-${var.env}-asg-group"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.vpc_zone_identifier
  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
 # target_group_arns = [var.target_group_arn]
  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
  tag {
        key   = "Name"
        value = "${var.project_name}-${var.env}-asg-ec2"
        propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_cloudwatch_metric_alarm" "high_network_in" {
  alarm_description   = "Scale up if average NetworkIn > 750000000 for 5 minutes"
  alarm_name          = "high_network_in"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.high_network_in_threshold
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
     AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }
}

resource "aws_cloudwatch_metric_alarm" "low_network_in" {
  alarm_description   = "Scale down if average NetworkIn < 250000000 for 15 minutes"
  alarm_name          = "low_network_in"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.low_network_in_threshold
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling_group.name
  }
}