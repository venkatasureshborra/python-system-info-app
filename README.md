# Python System Info App

A containerized  application that provides real-time system info through a web interface. This application is designed with DevOps best practices, featuring Docker containerization, CI/CD pipeline integration, and production-ready deployment configurations.

## Overview

This repository demonstrates a **production-ready CI/CD pipeline and Infrastructure-as-Code (IaC) implementation** for deploying a containerized Python application on **AWS EKS**.

The solution covers the **full DevOps lifecycle**:
- Infrastructure provisioning using **Terraform**
- Containerization using **Docker**
- Image security scanning using **Trivy**
- Kubernetes deployment using **Helm**
- Continuous Integration & Continuous Deployment using **GitHub Actions**
- Public access via **AWS Application Load Balancer (ALB) Ingress**

The application is exposed publicly and automatically updated on every valid code change.

---

## 🏗️ Architecture Overview

**High-level flow:**

1. Terraform provisions AWS infrastructure (VPC, EKS, IAM, ALB Controller)
2. GitHub Actions pipeline is triggered on code push
3. Docker image is built **only when `app/` or `Docker/` changes**
4. Image is scanned for vulnerabilities using Trivy
5. Image is pushed to Docker Hub with a **unique Git SHA tag**
6. Helm deploys (or upgrades) the application on EKS
7. Application is exposed via ALB Ingress

---
## 🧰 Technology Stack

- **Cloud Provider:** AWS
- **IaC:** Terraform
- **Container Runtime:** Docker
- **Container Registry:** Docker Hub
- **Orchestration:** Kubernetes (EKS)
- **Package Manager:** Helm
- **CI/CD:** GitHub Actions (self-hosted runner)
- **Security Scanning:** Trivy
- **Ingress:** AWS Load Balancer Controller (ALB)
---
## 📂 Repository Structure
```
├── app                # Flask application with system metrics endpoints
├── Docker             # Multi-stage Docker build configuration
├── k8s/
│ └── helm/            #Helm chart (Deployment, Service, Ingress, SA)
└── .github/
    └── workflows/    # GitHub Actions CI/CD pipelines
```
---

## ⚙️ How to Run the IaC (Terraform)

### Prerequisites
- AWS CLI configured
- Terraform installed
- Valid AWS credentials with EKS permissions

### Steps

```bash
cd terraform
terraform init
terraform plan
terraform apply
```
- Without Doing All these things manaul Just Run the workflow
  - Go to Actions tab
  - click on Terraform workflow
  - Then click on workflow dispatch
     - select the ENV and Apply/destroy the Infrastructure
        - if you want different configuration for enviornment just upload to s3 bucket
           - aws s3 cp prod.tfvars s3://tfvars-buckets/prod.tfvars


This will:
  - Create the EKS cluster
  - Configure networking
  - Install required IAM roles
  - Prepare the cluster for Helm deployments

## Installation & Deployment

### Local Development

```bash
# Clone the repository
git clone https://github.com/venkatasureshborra/python-system-info-app.git
cd python-system-info-app

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py
```
Access the application at `http://localhost:8000`



## CI/CD Pipeline

The repository includes a GitHub Actions workflow that automates:

- **Linting**: Code quality checks
- **Building**: Docker image creation
- **Security Scanning**: Vulnerability analysis
- **Deployment**: Automated deployment to production
- **Infrastructure** : Automatically create EKS Cluster

### How to Run the CI/CD Pipeline
- Prerequisites
  - GitHub repository secrets configured:
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
    - AWS_REGION
    - EKS_CLUSTER_NAME
    - Region
  - Configure Secrets in AWS Secret Manager
    - DOCKER_USERNAME
    - DOCKER_PASSWORD
  - Self-hosted GitHub runner running
### Pipeline Behavior
- Push changes to master
- Pipeline automatically:
    - Detects changes in app/ or Docker/
    - Builds & tags Docker image (Git SHA)
    - Runs Trivy security scans
    - Pushes image to Docker Hub
    -  Deploys using Helm (helm upgrade --install)
    -  Prints the public Ingress URL in pipeline logs
    - Manual workflow dispatch for **Terraform**

## Live Application URL
  - Check the logs of pipeline

## Monitoring & Observability

### Prometheus Metrics Integration

The application can be extended to expose Prometheus metrics by adding:

```python
from prometheus_flask_exporter import PrometheusMetrics

metrics = PrometheusMetrics(app)
```

### Logging

Application logs are output to stdout/stderr for easy integration with:
- CloudWatch Logs

## Security Considerations

- **Non-root user**: Docker container runs as non-root user
- **Minimal base image**: Uses Python slim image to reduce attack surface
- **Dependency scanning**: Regular updates for security vulnerabilities
- **No hardcoded secrets**: Environment variable configuration
- **HTTPS**: Should be deployed behind reverse proxy (Nginx/Traefik) with SSL/TLS

## Performance Optimization

- **Multi-stage Docker builds**: Reduced image size
- **Resource limits**: Kubernetes resource quotas for stability


### Health check failures
```bash
# Test health endpoint
curl http://localhost:5000/health
```
### Conclusion

This project demonstrates:

End-to-end DevOps automation

Secure, scalable Kubernetes deployment

Industry-standard CI/CD practices

Clean separation of application, infrastructure, and deployment logic
