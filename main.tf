
######
# Google PubSub Module
######

locals {
  prefix = join("-", tolist(["go", lower(var.labels.region), var.labels.company, var.labels.account, ""]))
}

resource "google_pubsub_topic" "topics" {
  count = var.create_topic ? length(var.topics) : 0

  labels = var.labels

  kms_key_name = trimspace(
    lookup(
      var.encryption_key_names,
      lower(element(var.topics, count.index)),
      "",
    )
  )

  name = format("%s-pubsub01-%s",
    "${local.prefix}${lower(element(var.topics, count.index))}",
    var.labels.environment
  )

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy

    content {
      allowed_persistence_regions = lookup(message_storage_policy.value, "allowed_persistence_regions", null)
    }
  }
}

resource "google_pubsub_topic_iam_binding" "admins" {
  count = var.set_admin_roles ? length(var.topics) : 0
  topic = element(google_pubsub_topic.topics.*.name, count.index)
  role  = "roles/pubsub.admin"

  members = split(
    ",",
    lookup(var.admins, element(var.topics, count.index), ""),
  )
}

resource "google_pubsub_topic_iam_binding" "editors" {
  count = var.set_editor_roles ? length(var.topics) : 0
  topic = element(google_pubsub_topic.topics.*.name, count.index)
  role  = "roles/pubsub.editor"

  members = split(
    ",",
    lookup(var.editors, element(var.topics, count.index), ""),
  )
}

resource "google_pubsub_topic_iam_binding" "viewers" {
  count = var.set_viewer_roles ? length(var.topics) : 0
  topic = element(google_pubsub_topic.topics.*.name, count.index)
  role  = "roles/pubsub.viewer"

  members = split(
    ",",
    lookup(var.viewers, element(var.topics, count.index), ""),
  )
}
