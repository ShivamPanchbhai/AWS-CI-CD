# AWS CI/CD Infrastructure – Cloud-Native Immutable Deployment (Oracle Project)

This project reflects the architecture and automation patterns I implemented at Oracle while working as a DevOps Engineer on the CAMM7 platform.

I was responsible for designing and automating end-to-end AWS infrastructure using Terraform and GitHub Actions with OIDC authentication, deploying a containerized backend service behind an Application Load Balancer with enforced HTTPS and Auto Scaling.

The system followed immutable infrastructure principles, secure IAM boundaries, and Git-driven deployments.

---

## Architecture Overview

The platform was divided into three primary layers:

### 1. Infrastructure Layer (Terraform – Modular Design)

Infrastructure was provisioned using modular Terraform with clear separation of concerns:

Modules implemented:

- ECR (immutable image registry with scan-on-push)
- IAM (runtime EC2 role + instance profile)
- ACM (SSL certificate with DNS validation)
- ALB (HTTPS ingress + target group)
- Compute (Launch Template + Auto Scaling Group)

Key architectural characteristics:

- Remote S3 backend with versioning enabled
- Launch Templates with IMDSv2 enforced
- Auto Scaling Group (minimum 2 instances, multi-AZ)
- Rolling instance refresh on image updates
- HTTP to HTTPS redirect at ALB level
- Route53 alias record integration
- Separate security groups for ALB and EC2

---

### 2. CI/CD Layer (GitHub Actions + OIDC)

Deployments were fully Git-driven.

Pipeline flow:

1. Code push to main branch
2. GitHub Actions authenticates to AWS using OIDC
3. Terraform initializes and applies infrastructure
4. Docker image is built
5. Image is tagged using Git commit SHA
6. Image is pushed to Amazon ECR
7. Auto Scaling Group performs rolling instance refresh

Security controls implemented:

- No static AWS credentials stored in GitHub
- OIDC-based temporary role assumption
- Separate deploy role and runtime role
- Least-privilege IAM enforcement

Each deployment produced a deterministic and traceable release using commit SHA tagging.

---

### 3. Runtime Layer (Containerized Service)

Each EC2 instance bootstrapped automatically using user-data scripts:

- Installed Docker
- Logged into ECR via IAM role
- Pulled image using commit SHA
- Ran container with restart policy
- Enabled AWS SSM for remote management
- Disabled SSH access entirely

Inside the container:

- FastAPI backend service
- nginx reverse proxy
- Health endpoints exposed for ALB checks

---

## Traffic Flow

Client → HTTPS → ALB → HTTP → EC2 → Docker Container → FastAPI Service

Detailed request lifecycle:

- Client establishes TLS connection with ALB
- HTTPS terminates at ALB
- ALB forwards HTTP traffic to target group
- EC2 receives traffic via internal security group
- nginx forwards request to FastAPI service
- Service validates and stores ECG data

EC2 instances were never directly exposed to the internet.

---

## Service Endpoint

POST /ecg

Content-Type: multipart/form-data

Fields:

- ecg_file (required)
- MRN (required)
- patient_name (optional)
- DOB (optional)
- timestamp (required)

Response:

{
  "status": "stored",
  "record_id": "abc123"
}

---

## Security & IAM Design Decisions

At Oracle, I implemented strict IAM and network isolation controls:

- OIDC-based GitHub authentication instead of long-lived credentials
- Separate IAM roles for deployment and runtime
- Runtime role limited to ECR pull and SSM access
- No S3 backend access from EC2
- ALB and EC2 security groups isolated
- IMDSv2 enforced
- HTTPS-only ingress

---

## ECR Lifecycle Management

- Image tags set to IMMUTABLE
- Scan-on-push enabled
- Lifecycle policy retains only the latest 5 images
- Prevents storage sprawl and reduces cost

---

## Infrastructure Reversibility

Infrastructure lifecycle was fully managed via GitHub workflows.

A manual destroy workflow required explicit confirmation before executing Terraform destroy, preventing accidental deletion and ensuring cost control.

---

## Key Engineering Principles Applied

- Immutable infrastructure
- Git-driven deployments
- Least-privilege IAM
- Modular Terraform architecture
- Rolling instance refresh instead of in-place modification
- Remote state management
- Secure CI authentication

---

## Technologies Used

AWS (EC2, ECR, ALB, ASG, ACM, Route53, IAM, S3, VPC, SSM)  
Terraform  
GitHub Actions (OIDC)  
Docker  
FastAPI  
nginx  
Amazon Linux
