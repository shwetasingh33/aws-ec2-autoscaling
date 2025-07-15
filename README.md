# EC2 Auto Scaling Web Server with Load Balancer on AWS

This project demonstrates how to set up a highly available web server architecture on AWS using EC2, Auto Scaling, and Application Load Balancer (ALB).

## ✅ Technologies Used
- Amazon EC2
- Auto Scaling Group (ASG)
- Elastic Load Balancer (ALB)
- VPC, Subnets, Security Groups
- AWS CLI
- Bash Scripting

## 📐 Architecture
- Launch Template provisions EC2 with Apache web server.
- Auto Scaling Group spans multiple subnets.
- ALB distributes traffic and ensures high availability.

## 🚀 Setup Instructions
1. Update variables in `autoscaling-setup.sh`:
   - VPC ID
   - Subnet IDs
   - Security Group ID
   - EC2 Key Pair
2. Run `autoscaling-setup.sh` using AWS CLI.
3. Open the ALB DNS URL in browser to view web server.

## 🔐 Security Note
Ensure only HTTP traffic is allowed on port 80 in your security group.

## 💡 Future Enhancements
- Add CloudWatch alarms for scaling triggers.
- Deploy a Flask or Node.js app instead of static HTML.
- Use Terraform or CloudFormation for full IaC.
