# Task-4: Secure Strapi Deployment using Terraform

## Introduction
This project focuses on designing a secure and production-oriented AWS infrastructure using Terraform.  
The goal of this task is not live deployment, but to demonstrate a strong understanding of
Terraform, AWS networking concepts, and Infrastructure as Code best practices.

The application used in this design is **Strapi**, which runs inside a Docker container on an EC2 instance.

---

## Architecture Overview
The infrastructure follows a secure and commonly used cloud architecture pattern:

- A **custom VPC** to isolate application resources
- **Public and private subnets** to separate internet-facing and internal components
- A **NAT Gateway** to allow outbound internet access from private resources
- A **private EC2 instance** running Strapi using Docker
- An **Application Load Balancer (ALB)** in the public subnet to expose the application securely
- **Security Groups** to strictly control inbound and outbound traffic

In this design, the application is never directly exposed to the internet.

---

## Network Design
### VPC
- A dedicated VPC is created with a private IP address range.
- This provides complete network isolation from other environments.

### Public Subnet
- Hosts the Internet Gateway and Application Load Balancer.
- Only this subnet is allowed to receive traffic from the internet.

### Private Subnet
- Hosts the EC2 instance running Strapi.
- The instance does not have a public IP address.
- Direct inbound access from the internet is blocked.

### NAT Gateway
- Deployed in the public subnet.
- Allows the private EC2 instance to access the internet for updates and package installation.
- Prevents any inbound connections from the internet to the private subnet.

---

## Compute Layer (EC2)
- The EC2 instance is deployed inside the **private subnet**.
- Docker is installed automatically using `user_data`.
- Strapi is started as a Docker container at instance launch.
- The EC2 instance can only receive traffic from the load balancer.

This approach follows the principle of **least privilege and minimal exposure**.

---

## Application Load Balancer
- The ALB is placed in the public subnet.
- It acts as the single entry point to the application.
- Traffic is forwarded from the ALB to the EC2 instance in the private subnet.
- This improves security, scalability, and future extensibility.

---

## Automation with user_data
The `user_data.sh` script is used to automate instance configuration:
- Installs Docker
- Starts the Docker service
- Runs the Strapi application container

This enables **zero-touch provisioning**, where no manual setup is required after launch.

---

## Environment Management using tfvars
Environment-specific values such as:
- AWS region
- Instance type
- Environment name (dev, staging, prod)

are managed using `terraform.tfvars`.

This keeps the Terraform code reusable and avoids hardcoding environment values.

---

## Terraform Module Structure
The project uses a modular Terraform design:
- **VPC module** – networking components
- **EC2 module** – compute and application layer
- **ALB module** – public access layer

This structure improves:
- Code readability
- Reusability
- Maintenance
- Scalability

---

## Security Considerations
- No public IP assigned to the EC2 instance
- Application access only through the load balancer
- Controlled inbound and outbound rules using security groups
- Separation of public and private resources

---

## Notes
Due to AWS free-tier limitations, this task focuses on **Terraform design and best practices**
rather than live deployment.

The configuration is production-ready and can be deployed without structural changes.

---

## Conclusion
This task demonstrates the ability to design secure cloud infrastructure using Terraform,
apply Infrastructure as Code principles, and follow real-world DevOps best practices.


