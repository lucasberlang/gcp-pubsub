
variable "project_id" {
  description = "fixture"
  type        = string
}

variable "region" {
  description = "fixture"
  type        = string
  default     = "europe-west1"
}

######
# Vars
######


variable "offset" {
  description = "The offset to be added to the google pubsub topic"
  type        = number
}

variable "name" {
  description = "PubSub topic name."
  type        = string
}

variable "subscriptions" {
  description = "Topic subscriptions. Also define push configs for push subscriptions. If options is set to null subscription defaults will be used. Labels default to topic labels if set to null. \n <a name=ack_deadline_seconds:></a>[ack_deadline_seconds:](#ack_deadline_seconds:) This value is the maximum time after a subscriber receives a message before the subscriber should acknowledge the message. After message delivery but before the ack deadline expires and before the message is acknowledged, it is an outstanding message and will not be delivered again during that time (on a best-effort basis). For pull subscriptions, this value is used as the initial value for the ack deadline. To override this value for a given message, call subscriptions.modifyAckDeadline with the corresponding ackId if using pull. The minimum custom deadline you can specify is 10 seconds. The maximum custom deadline you can specify is 600 seconds (10 minutes). If this parameter is 0, a default value of 10 seconds is used. For push delivery, this value is also used to set the request timeout for the call to the push endpoint. If the subscriber never acknowledges the message, the Pub/Sub system will eventually redeliver the message. \n <a name=message_retention_duration:></a>[message_retention_duration:](#message_retention_duration:) How long to retain unacknowledged messages in the subscription's backlog, from the moment a message is published. If retain_acked_messages is true, then this also configures the retention of acknowledged messages, and thus configures how far back in time a subscriptions.seek can be done. Defaults to 7 days. Cannot be more than 7 days (`604800s`) or less than 10 minutes (`600s`). A duration in seconds with up to nine fractional digits, terminated by 's'. Example: `600.5s`. \n <a name=retain_acked_messages:></a>[retain_acked_messages:](#retain_acked_messages:) Indicates whether to retain acknowledged messages. If true, then messages are not expunged from the subscription's backlog, even if they are acknowledged, until they fall out of the messageRetentionDuration window. \n <a name=expiration_policy_ttl:></a>[expiration_policy_ttl:](#expiration_policy_ttl:) Specifies the `time-to-live` duration for an associated resource. The resource expires if it is not active for a period of ttl. If ttl is not set, the associated resource never expires. A duration in seconds with up to nine fractional digits, terminated by 's'. Example - `3.5s`. \n <a name=filter:></a>[filter:](#filter:) The subscription only delivers the messages that match the filter. Pub/Sub automatically acknowledges the messages that don't match the filter. You can filter messages by their attributes. The maximum length of a filter is 256 bytes. After creating the subscription, you can't modify the filter."
  type = map(object({
    labels = map(string)
    options = object({
      ack_deadline_seconds       = number
      message_retention_duration = string
      retain_acked_messages      = bool
      expiration_policy_ttl      = string
      filter                     = string
    })
  }))
  default = {}
}

######
# Tags
######

variable "tags" {
  description = "fixture"
  type        = map(string)
}
