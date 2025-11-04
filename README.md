[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![CI](https://github.com/Rohan-2110-git/CloudOps-360/actions/workflows/tf-ci.yml/badge.svg)](https://github.com/Rohan-2110-git/CloudOps-360/actions/workflows/tf-ci.yml)
![Terraform](https://img.shields.io/badge/Terraform-Used-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Deployed-232F3E?logo=amazon-aws)
![CloudWatch](https://img.shields.io/badge/Monitoring-CloudWatch-FF9900?logo=amazon-aws)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![Prometheus](https://img.shields.io/badge/Prometheus-Metrics-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboard-F46800?logo=grafana)


---


# CloudOps 360

An **industry-grade DevOps + AWS** project that showcases a real workflow:  
**Dockerized app → IaC (Terraform) → ECR → ECS Fargate behind ALB → CloudWatch logs → Auto-scaling → CI/CD with GitHub Actions.**

> Built to mirror real DevOps work while staying budget-friendly & interview-ready.

---

## 🔭 What’s Inside

- **App** → Flask backend + Nginx frontend (proxying `/api/*` → backend)
- **Local stack** → `docker-compose up --build`
- **AWS Infra** →
  - VPC (CIDR, subnets, IGW, route tables)
  - ECR container registry
  - ECS Fargate service + **Application Load Balancer**
  - CloudWatch logs
  - Target tracking **auto-scaling**
- **CI/CD** → GitHub Actions → build, push, redeploy ECS automatically

---

## 🧭 Folder Structure

cloudops-360/
├─ app/
│ ├─ backend/
│ │ ├─ app.py
│ │ ├─ requirements.txt
│ │ └─ Dockerfile
│ └─ frontend/
│ ├─ index.html
│ └─ default.conf
├─ infra/
│ ├─ main.tf
│ ├─ providers.tf
│ ├─ variables.tf
│ └─ modules/
│ ├─ vpc/
│ ├─ ecr/
│ └─ ecs/
├─ docker-compose.yml
├─ progress_notes.md
└─ .github/workflows/cicd.yml

yaml
Copy code

---

## ✅ Local Development

```bash
docker-compose up --build
Verify:

bash
Copy code
curl http://localhost:5000/health     # backend
curl http://localhost:8080            # frontend
curl http://localhost:8080/api/status # proxy working
☁️ AWS Deployment — Terraform
✅ AWS CLI Configure (IAM User)
bash
Copy code
aws configure --profile cloudops360
export AWS_PROFILE=cloudops360
✅ Terraform Init / Plan / Apply
bash
Copy code
cd infra
terraform init
terraform fmt -recursive
terraform validate
Deploy:

bash
Copy code
terraform apply
📦 Push Backend Docker Image to ECR
Get repo URI:

bash
Copy code
aws ecr describe-repositories \
  --repository-names cloudops360-backend \
  --query "repositories[0].repositoryUri" --output text
Login + Tag + Push:

bash
Copy code
aws ecr get-login-password --region ap-south-1 \
| docker login --username AWS --password-stdin <repo-uri>

docker tag cloudops-360-backend:latest <repo-uri>:latest
docker push <repo-uri>:latest
🚀 ECS Fargate + Load Balancer
Deploy:

bash
Copy code
terraform plan -var='backend_image=<repo-uri>:latest'
terraform apply -var='backend_image=<repo-uri>:latest'
Test Public URL:

bash
Copy code
curl http://<ALB-DNS>/health
curl http://<ALB-DNS>/status
Expected:

json
Copy code
{"status": "healthy"}
{"api": "status","service":"cloudops-360-backend","status":"ok"}
📊 Logs & Auto Scaling
✅ CloudWatch Log Group
/ecs/cloudops360-backend

✅ Auto Scaling — CPU Target 50%
Console:

ECS → Cluster → Service → Auto Scaling tab

Application Auto Scaling → ECS namespace

Scale range: 1 → 2 tasks

🤖 CI/CD — GitHub Actions
Workflow: .github/workflows/cicd.yml

Triggers: push to main
Actions:

Build → Tag → Push Image to ECR

Force ECS new deployment

✅ Required Secrets:

Name	Value
AWS_REGION	ap-south-1
AWS_ACCOUNT_ID	your AWS id
ECR_REPOSITORY	cloudops360-backend
ECS_CLUSTER	cloudops360-cluster
ECS_SERVICE	cloudops360-backend-svc
AWS_ACCESS_KEY_ID	from IAM user
AWS_SECRET_ACCESS_KEY	from IAM user

Push workflow:

bash
Copy code
git add .github/workflows/cicd.yml
git commit -m "ci: add GitHub Actions pipeline"
git push
Watch under → Actions tab ✅

✅ Key Architecture
Frontend EC2? ❌

EC2 for backend? ❌
✅ Fully managed serverless containers with Fargate

Flow:

java
Copy code
Internet → ALB → ECS Tasks (Fargate) → CloudWatch Logs
💼 Resume Line ✅
Designed and deployed a production-style microservices platform on AWS using Terraform, ECS Fargate, ALB, ECR, CloudWatch, and GitHub Actions CI/CD to enable fully automated, scalable deployments of Dockerized apps.

✅ Verification Checklist
Item	Status
Docker local build	✅
VPC/Subnets/IGW	✅
ECR Repo + image pushed	✅
ECS + ALB live endpoint	✅
Logs in CloudWatch	✅
Target tracking auto-scaling	✅
CI/CD pipeline	✅

🧯 Troubleshooting (Exact errors we faced)
Error	Fix
Invalid single-argument block definition ;	Remove semicolons, use multiline HCL blocks
Module not installed	terraform init
Repository not found	Correct GitHub remote URL
Docker Desktop pipe error	Start Docker Desktop + enable WSL2

💸 Cost-Saving Tips
Min ECS tasks = 1

Use public subnets (no NAT charges)

Destroy when not using:

bash
Copy code
terraform destroy -var='backend_image=<repo-uri>:latest'
📌 Future Enhancements
✅ HTTPS (ACM) + redirect

✅ Budget Alerts (SNS)

✅ Secret Manager for env vars

✅ Private subnets + NAT

✅ RDS or DynamoDB integration

✅ Blue/Green deployments

✅ Full monitoring dashboards

Internet → ALB (Public Subnet)
                  ↓
         ECS Fargate (Private Subnet)
                  ↓
             NAT Gateway
                  ↓
          Internet / ECR Access


👨‍💻 Author
Rohan Ghorpade
Cloud + DevOps Engineer 🔥

