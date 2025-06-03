variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "galvanic-portal-456405-a2"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-south1"
}

variable "service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "next-js-app"
}

variable "image_url" {
  description = "Docker image URL"
  type        = string
  default     = "docker.io/dhilipakaran/js:v1"
}

variable "basepath" {
  type    = string
  default = ""
}

variable "next_public_app_url" {
  type    = string
  default = "http://localhost:3000/"
}

variable "nextauth_basepath" {
  type    = string
  default = "/api/auth"
}

variable "nextauth_url" {
  type    = string
  default = "http://localhost:3000/api/auth"
}

variable "nextauth_secret" {
  type      = string
  sensitive = true
}

variable "api_url" {
  type    = string
  default = "http://localhost:3000/api"
}

variable "next_public_api_url" {
  type    = string
  default = "http://localhost:3000/api"
}

variable "google_client_id" {
  type = string
}

variable "google_client_secret" {
  type      = string
  sensitive = true
}

variable "database_url" {
  type      = string
  sensitive = true
}

variable "next_public_docs_url" {
  type    = string
  default = "https://demos.themeselection.com/sneat-mui-nextjs-admin-template/documentation"
}

variable "mode" {
  type    = string
  default = "dev"
}

variable "next_public_firebase_client" {
  type = string
}

variable "cloud_run_service_account_email" {
  description = "The email of the service account used by Cloud Run"
  type        = string
  default     = "1076859015448-compute@developer.gserviceaccount.com"
}
