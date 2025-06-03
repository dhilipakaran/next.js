provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_project" "project" {}

resource "google_project_iam_member" "secret_reader" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${var.cloud_run_service_account_email}"
}

resource "google_cloud_run_service" "nextjs" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      service_account_name = var.cloud_run_service_account_email
      containers {
        image = var.image_url

        ports {
          container_port = 8080
        }

        # Secrets as env vars
        env {
          name = "NEXT_AUTH_SECRET"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.secrets["NEXT_AUTH_SECRET"].secret_id
              key  = "latest"
            }
          }
        }

        env {
          name = "DATABASE_URL"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.secrets["DATABASE_URL"].secret_id
              key  = "latest"
            }
          }
        }

        env {
          name = "GOOGLE_CLIENT_SECRET"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.secrets["GOOGLE_CLIENT_SECRET"].secret_id
              key  = "latest"
            }
          }
        }

        # Non-secret env vars
        env {
          name  = "BASEPATH"
          value = var.basepath
        }
        env {
          name  = "NEXT_PUBLIC_APP_URL"
          value = var.next_public_app_url
        }
        env {
          name  = "NEXTAUTH_BASEPATH"
          value = var.nextauth_basepath
        }
        env {
          name  = "NEXTAUTH_URL"
          value = var.nextauth_url
        }
        env {
          name  = "API_URL"
          value = var.api_url
        }
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = var.next_public_api_url
        }
        env {
          name  = "GOOGLE_CLIENT_ID"
          value = var.google_client_id
        }
        env {
          name  = "NEXT_PUBLIC_DOCS_URL"
          value = var.next_public_docs_url
        }
        env {
          name  = "MODE"
          value = var.mode
        }
        env {
          name  = "NEXT_PUBLIC_FIREBASE_CLIENT"
          value = var.next_public_firebase_client
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "1"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.nextjs.location
  service  = google_cloud_run_service.nextjs.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
