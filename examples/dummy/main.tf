
provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub" {
  source = "../.."

  topics = var.topics
  labels = var.labels
}
