# Current Time API - Terraform Deployment

This repository contains the Terraform configuration files to provision the infrastructure required for the **Current Time API** on **Google Cloud Platform (GCP)**, deploying it to a **Google Kubernetes Engine (GKE)** cluster with a **NAT Gateway**, **IAM roles**, **VPC networking**, and other necessary components.

## Infrastructure Components

- **Google Kubernetes Engine (GKE) Cluster**: The API is deployed in a GKE cluster.
- **Google Container Registry (GCR)**: The Docker image is stored in Google Container Registry.
- **VPC Networking and Subnets**: Secure communication between resources.
- **IAM Roles**: Appropriate roles and policies are set for secure access.
- **NAT Gateway**: Manages egress traffic for the Kubernetes cluster.
- **Kubernetes Resources**: Deployments, Services, Horizontal Pod Autoscaler (HPA), ConfigMaps, and Ingress.
- **Terraform Policy as Code (PaC)**: Enforces security policies.

## Prerequisites

- **Google Cloud SDK** (`gcloud`) installed and authenticated.
- **Terraform** installed.
- **A GCP project** and billing account set up.
- **IAM roles** with necessary permissions:
  - `roles/container.admin`
  - `roles/compute.admin`
  - `roles/storage.admin`
  - `roles/iam.admin`
  - `roles/serviceusage.serviceUsageAdmin`

## GCP Services Required

Before running the Terraform scripts, ensure the following GCP services are enabled:

- Google Kubernetes Engine API
- Google Compute Engine API
- Google Container Registry API
- Artifact Registry API
- Cloud Monitoring API (if using monitoring)

## Terraform Variables

Define the following variables in `terraform.tfvars`:

```hcl
project_id = "your-gcp-project-id"
region     = "us-central1"
cluster_name = "currenttime-api-cluster"
network_name = "vpc-network"
subnet_name = "vpc-subnet"
allowed_ip_range = "0.0.0.0/0"  # Update with your allowed IP range for SSH