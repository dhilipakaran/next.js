locals {
  secrets_map = {
    DATABASE_URL    = "postgresql://savemomdev:*f]FVfENltmIsN8A@34.81.39.21/testtaiwan"
    NEXT_AUTH_SECRET  = "jfhgfkhffkhfhkffjutfvthjfvfhjfj"
    GOOGLE_CLIENT_SECRET  = "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"
  }
}

resource "google_secret_manager_secret" "secrets" {
  for_each = local.secrets_map
  secret_id = each.key
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "secrets_version" {
  for_each = local.secrets_map

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value
}