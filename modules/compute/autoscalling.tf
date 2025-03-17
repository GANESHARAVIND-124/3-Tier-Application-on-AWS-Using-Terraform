#AutoScalling Group (ASG)

resource "aws_autoscaling_group" "app_asg" {
    desired_capacity = 2
    min_size = 1
    max_size = 3
    vpc_zone_identifier = var.public_subnet_ids

    launch_template {
      id = aws_launch_template.app_lt.id
      version = "$Latest"
    }

    target_group_arns = [var.target_group_arn]

    health_check_type = "EC2"

    tag {
      key = "Name"
      value = "App-Instance"
      propagate_at_launch = true
    }
}

#Auto Scalling Policy (scale up)

resource "aws_autoscaling_policy" "scale_up" {
  name = "scale-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}

#Auto Scalling Policy (scale down)

resource "aws_autoscaling_policy" "scale_down" {
  name = "scale-down"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
}