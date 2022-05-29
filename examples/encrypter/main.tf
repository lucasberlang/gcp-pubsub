
provider "google" {
  project = var.project_id
  region  = var.region
}

data "terraform_remote_state" "infra" {
  backend = "gcs"
  config = {
    bucket = "go-eu-bluetab-cloud-state-cs01-dev"
    prefix = "infra"
  }
}


module "pubsub" {
  source = "../.."

  encryption_key_names = {
    "dummy" = data.terraform_remote_state.infra.outputs.global_kms
  }

  topics = var.topics
  labels = var.labels
}
