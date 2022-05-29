
######
# google_pubsub_topic
######

variable "create_topic" {
  description = "Controls if the new topic should be created"
  type        = bool
  default     = true
}

variable "topics" {
  description = "The name for the topics"
  type        = list(string)
}

variable "encryption_key_names" {
  description = "A map of topic name that indicates a Cloud KMS key that will be used to encrypt objects"
  type        = map(any)
  default     = {}
}

variable "message_storage_policy" {
  type = list(object({
    algallowed_persistence_regionsorithm = list(string)
  }))
  description = "A list of IDs of regions where topic messages may be persisted in storage"
  default     = []
}

######
# google_pubsub_topic_iam_binding
######

variable "set_admin_roles" {
  description = "Grant roles/pubsub.admin"
  type        = bool
  default     = false
}

variable "admins" {
  description = "A map of key name that indicates IAM members who will be granted as admins"
  type        = map(any)
  default     = {}
}

variable "set_editor_roles" {
  description = "Grant roles/pubsub.editor"
  type        = bool
  default     = false
}

variable "editors" {
  description = "A map of key name that indicates IAM members who will be granted as editors"
  type        = map(any)
  default     = {}
}

variable "set_viewer_roles" {
  description = "Grant roles/pubsub.viewer"
  type        = bool
  default     = false
}

variable "viewers" {
  description = "A map of key name that indicates IAM members who will be granted as viewers"
  type        = map(any)
  default     = {}
}

######
# Tags
######

variable "labels" {
  description = "A mapping of labels to assign to all resources"
  type        = map(string)
}
