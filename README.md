# Cloud Engineering Take-Home Assignment

## Objective
Create and deploy a simple API to Google Cloud Platform (GCP) using Kubernetes (GKE) with Infrastructure as Code (IaC) exclusively through Terraform. Implement GitHub Actions for Continuous Deployment (CD).

## Requirements

### 1. API Development:
- Develop a simple API in the programming language of your choice that returns the current time in JSON format when accessed via a GET request.
- Containerize the API using Docker.

### 2. Infrastructure Setup and Deployment (Terraform):
- Use Terraform to create the entire infrastructure on Google Cloud Platform (GCP), including:
  - A Google Kubernetes Engine (GKE) cluster where the API will be deployed.
  - A NAT gateway to manage egress traffic from the cluster.
  - Appropriate IAM roles and policies.
  - VPC networking, subnets, and firewall rules for secure communication.
  - Kubernetes resources such as Namespaces, Deployments, Services, ConfigMaps, and Ingress.
- Deploy the API to the GKE cluster exclusively using Terraform.
- Implement Terraform Policy as Code (PaC) to enforce at least one security policy.

### 3. CI/CD Pipeline:
- Implement a GitHub Actions pipeline that:
  - Runs Terraform to provision all required infrastructure, including Kubernetes resources.
  - Builds the Docker image for the API.
  - Deploys the API to the GKE cluster as part of the Terraform deployment.
  - Verifies that the API is accessible by running a test that hits the API endpoint and checks the response.

### 4. Network Security:
- Set up a NAT gateway in GCP to manage the outbound traffic for your GKE cluster.
- Implement any additional firewall rules to secure your infrastructure.
- Ensure that your Terraform configuration includes security best practices, such as restricting access to sensitive resources.

## Deliverables
- A link to your GitHub repository containing:
  - The Terraform code for infrastructure setup, including all Kubernetes resources.
  - The Dockerfile and Kubernetes manifests defined in Terraform.
  - The GitHub Actions workflow.
  - The API source code.
  - A README file with instructions on how to run and test your setup locally.
- A link to the deployed API endpoint (the public URL where the API is accessible).
- A link to the GitHub Actions workflow run that successfully deploys the infrastructure and API.

## Evaluation Criteria
- **Correctness**: Does the API function as expected? Does the infrastructure provision correctly using Terraform?
- **Security**: Are best practices for network security implemented? Are Terraform policies applied correctly?
- **Automation**: Is the deployment fully automated using GitHub Actions? Does the pipeline run smoothly?
- **Documentation**: Is the README clear and comprehensive? Are the Terraform configurations well-documented?
- **Efficiency**: Are resources used efficiently in the cloud? Is the infrastructure scalable and secure?

## Bonus Points
- Implement monitoring and alerting for the deployed API using Google Cloud's monitoring tools.
- Use advanced Terraform features to organize your code.

## Submission
Please submit your assignment by sharing the following:
- A link to your GitHub repository containing the required code and documentation.
- The URL where the API is deployed and accessible.
- A link to the GitHub Actions run that successfully deployed the infrastructure and API.