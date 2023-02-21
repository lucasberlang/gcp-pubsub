
provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub" {
  source = "../.."

  name          = var.name
  offset        = var.offset
  project_id    = var.project_id
  subscriptions = var.subscriptions
  
  subscription_iam = {
    "pullsub" = {
      "roles/pubsub.editor" = ["user:xxxxx"]
    }
  }
  tags = var.tags
}

