Lesson 1

Topics:
- AWS Basics
- AWS Identity and Access Management (IAM) 
- Amazon Virtual Private Cloud (VPC)
- Amazon Elastic Compute Cloud (EC2)

What you will learn:
- how to create user and specific roles,
- how to login to console and cli,
- understand roles and policies, user security options
- how to setup and login into basic compute

IAM and security:
1)  Create user training
2)  Create group Administrators, add policy Admin, add user to group
3)  Review policy
4)  Review role
5)  Review user security options

Networking:
1)  Create VPC - 10.0.0.0/27 - 32 hosts
2)  Create internet gateway
3)  Create NAT gateway
4)  Create public route table, 10.0.0.0/27, internet gateway
5)  Create private route table, 10.0.0.0/27, NAT gateway
6)  Create public subnet - 10.0.0.0/28 - 16 hosts
7)  Create private subnet - 10.0.0.16/28 - 16 hosts
8)  Create key pair
9)  Create EC2 instance in public subnet (public IP)
10) Create EC2 instance in private subnet (public IP)
11) SSH into public and private EC2
12) Change private route table, remove NAT, insert internet gateway
13) SSH into private EC2
14) Remove EC2 instances
15) Remove NAT gateway
16) Remove VPC

Lesson 2

Topics:
- Amazon Elastic Compute Cloud (EC2)
- AWS Lambda, Amazon Elastic Container Service (ECS), Amazon EKS
- Infrastructure as code, (CloudFormation, Terraform, CLI, SDK)
- example project

What you will learn:
- how to setup environment with CloudFormation
- how to setup environment with Terraform
- how to create project from scratch

Compute and containers:
1) Review EC2, Lambda
2) Review ECS, EKS

Infrastructure as code
1) Review console, CLI, SDK
2) Review CloudFormation, CDK
3) Review Terraform

Example project with infrastructure in terraform:
- vpc
- two subnets (public, private)
- alb, routing
- s3 (static frontend?)
- dynamodb
- fargate (cluster, task definition, service)

https://devcloud.swcoe.ge.com/devspace/display/~212626796/AWS+Training

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html
