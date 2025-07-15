#!/bin/bash
# This script uses AWS CLI to set up EC2 with Auto Scaling and Load Balancer

# VARIABLES (Edit these before running)
LAUNCH_TEMPLATE_NAME="WebServerLT"
AUTO_SCALING_GROUP="WebServerASG"
LOAD_BALANCER_NAME="WebServerLB"
TARGET_GROUP_NAME="WebServerTG"
VPC_ID="vpc-xxxxxxxx"
SUBNETS="subnet-xxxxxxx subnet-yyyyyyy"
KEY_NAME="your-key-pair"

# 1. Create Launch Template
aws ec2 create-launch-template --launch-template-name $LAUNCH_TEMPLATE_NAME --version-description "v1" --launch-template-data '{
  "ImageId":"ami-0c02fb55956c7d316",
  "InstanceType":"t2.micro",
  "KeyName":"'"$KEY_NAME"'",
  "SecurityGroupIds":["sg-xxxxxxxx"],
  "UserData":"'"$(base64 -w 0 userdata-script.sh)"'"
}'

# 2. Create Target Group
aws elbv2 create-target-group --name $TARGET_GROUP_NAME --protocol HTTP --port 80 --vpc-id $VPC_ID --target-type instance

# 3. Create Load Balancer
aws elbv2 create-load-balancer --name $LOAD_BALANCER_NAME --subnets $SUBNETS --security-groups sg-xxxxxxxx --scheme internet-facing --type application --ip-address-type ipv4

# 4. Register Target Group with Load Balancer Listener
# (Manual step or add via create-listener command)

# 5. Create Auto Scaling Group
aws autoscaling create-auto-scaling-group --auto-scaling-group-name $AUTO_SCALING_GROUP --launch-template "LaunchTemplateName=$LAUNCH_TEMPLATE_NAME,Version=1" --min-size 1 --max-size 3 --desired-capacity 1 --vpc-zone-identifier "$SUBNETS" --target-group-arns arn:aws:elasticloadbalancing:...

# 6. Add scaling policies and CloudWatch alarms (optional)

echo "✅ Setup complete. Load Balancer and Auto Scaling configured."
