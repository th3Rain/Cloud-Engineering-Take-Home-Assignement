variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where resources will be deployed"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "example-autopilot-cluster"
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "example-network"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "example-subnetwork"
}

variable "service_account_email" {
  description = "The service account email to use for the GKE nodes"
  type        = string
}

variable "allowed_ip_range" {
  description = "The IP range allowed to access the cluster"
  type        = string
  default     = "0.0.0.0/0"
}