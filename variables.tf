
######
# google_pubsub_topic
######

variable "offset" {
  description = "The offset to be added to the google pubsub topic"
  type        = number
  default     = 1
}

variable "name" {
  description = "PubSub topic name."
  type        = string
}

variable "project_id" {
  description = "Project used for resources."
  type        = string
}

variable "message_retention_duration" {
  description = "Minimum duration to retain a message after it is published to the topic."
  type        = string
  default     = null
}

variable "push_configs" {
  description = "Push subscription configurations. \n <a name=attributes:></a>[attributes:](#attributes:) Endpoint configuration attributes. Every endpoint has a set of API supported attributes that can be used to control different aspects of the message delivery. The currently supported attribute is x-goog-version, which you can use to change the format of the pushed message. This attribute indicates the version of the data expected by the endpoint. This controls the shape of the pushed message (i.e., its fields and metadata). The endpoint version is based on the version of the Pub/Sub API. If not present during the subscriptions.create call, it will default to the version of the API used to make such call. If not present during a subscriptions.modifyPushConfig call, its value will not be changed. subscriptions.get calls will always return a valid version, even if the subscription was created without this attribute. The possible values for this attribute are: v1beta1: uses the push format defined in the v1beta1 Pub/Sub API. v1 or v1beta2: uses the push format defined in the v1 Pub/Sub API. \n <a name=endpoint:></a>[endpoint:](#endpoint:) A URL locating the endpoint to which messages should be pushed. For example, a Webhook endpoint might use 'https://example.com/push'. \n <a name=oidc_token:></a>[oidc_token:](#oidc_token:) If specified, Pub/Sub will generate and attach an OIDC JWT token as an Authorization header in the HTTP request for every pushed message. \n - audience: Audience to be used when generating OIDC token. The audience claim identifies the recipients that the JWT is intended for. The audience value is a single case-sensitive string. Having multiple values (array) for the audience field is not supported. More info about the OIDC JWT token audience here: https://tools.ietf.org/html/rfc7519#section-4.1.3 Note: if not specified, the Push endpoint URL will be used. \n - service_account_email: Service account email to be used for generating the OIDC token. The caller (for subscriptions.create, subscriptions.patch, and subscriptions.modifyPushConfig RPCs) must have the iam.serviceAccounts.actAs permission for the service account."
  type = map(object({
    attributes = map(string)
    endpoint   = string
    oidc_token = object({
      audience              = string
      service_account_email = string
    })
  }))
  default = {}
}

variable "regions" {
  description = "List of regions used to set persistence policy."
  type        = list(string)
  default     = []
}

variable "subscription_iam" {
  description = "IAM bindings for subscriptions in {SUBSCRIPTION => {ROLE => [MEMBERS]}} format. \n <a name=sub:></a>[sub:](#sub:) The subscription name or id to bind to attach IAM policy to. \n <a name=role:></a>[role:](#role:) The role that should be applied. Only one google_pubsub_subscription_iam_binding can be used per role. Note that custom roles must be of the format [projects|organizations]/{parent-name}/roles/{role-name}. \n <a name=members:></a>[members:](#members:) Identities that will be granted the privilege in role."
  type        = map(map(list(string)))
  default     = {}
}

variable "dead_letter_configs" {
  description = "Per-subscription dead letter policy configuration. \n <a name=topic:></a>[topic:](#topic:) The name of the topic to which dead letter messages should be published. Format is projects/{project}/topics/{topic}. The Cloud Pub/Sub service account associated with the enclosing subscription's parent project (i.e., service-{project_number}@gcp-sa-pubsub.iam.gserviceaccount.com) must have permission to Publish() to this topic. The operation will fail if the topic does not exist. Users should ensure that there is a subscription attached to this topic since messages published to a topic with no subscriptions are lost. \n <a name=max_delivery_attempts:></a>[max_delivery_attempts:](#max_delivery_attempts:) The maximum number of delivery attempts for any message. The value must be between 5 and 100. The number of delivery attempts is defined as 1 + (the sum of number of NACKs and number of times the acknowledgement deadline has been exceeded for the message). A NACK is any call to ModifyAckDeadline with a 0 deadline. Note that client libraries may automatically extend ack_deadlines. This field will be honored on a best effort basis. If this parameter is 0, a default value of 5 is used."
  type = map(object({
    topic                 = string
    max_delivery_attempts = number
  }))
  default = {}
}

variable "defaults" {
  description = "Subscription defaults for options. \n <a name=ack_deadline_seconds:></a>[ack_deadline_seconds:](#ack_deadline_seconds:) This value is the maximum time after a subscriber receives a message before the subscriber should acknowledge the message. After message delivery but before the ack deadline expires and before the message is acknowledged, it is an outstanding message and will not be delivered again during that time (on a best-effort basis). For pull subscriptions, this value is used as the initial value for the ack deadline. To override this value for a given message, call subscriptions.modifyAckDeadline with the corresponding ackId if using pull. The minimum custom deadline you can specify is 10 seconds. The maximum custom deadline you can specify is 600 seconds (10 minutes). If this parameter is 0, a default value of 10 seconds is used. For push delivery, this value is also used to set the request timeout for the call to the push endpoint. If the subscriber never acknowledges the message, the Pub/Sub system will eventually redeliver the message. \n <a name=message_retention_duration:></a>[message_retention_duration:](#message_retention_duration:) How long to retain unacknowledged messages in the subscription's backlog, from the moment a message is published. If retain_acked_messages is true, then this also configures the retention of acknowledged messages, and thus configures how far back in time a subscriptions.seek can be done. Defaults to 7 days. Cannot be more than 7 days ('604800s') or less than 10 minutes ('600s'). A duration in seconds with up to nine fractional digits, terminated by 's'. Example: '600.5s'. \n <a name=retain_acked_messages:></a>[retain_acked_messages:](#retain_acked_messages:) Indicates whether to retain acknowledged messages. If true, then messages are not expunged from the subscription's backlog, even if they are acknowledged, until they fall out of the messageRetentionDuration window. \n <a name=expiration_policy_ttl:></a>[expiration_policy_ttl:](#expiration_policy_ttl:) Specifies the `time-to-live` duration for an associated resource. The resource expires if it is not active for a period of ttl. If ttl is not set, the associated resource never expires. A duration in seconds with up to nine fractional digits, terminated by 's'. Example - `3.5s`. \n <a name=filter:></a>[filter:](#filter:) The subscription only delivers the messages that match the filter. Pub/Sub automatically acknowledges the messages that don't match the filter. You can filter messages by their attributes. The maximum length of a filter is 256 bytes. After creating the subscription, you can't modify the filter."
  type = object({
    ack_deadline_seconds       = number
    message_retention_duration = string
    retain_acked_messages      = bool
    expiration_policy_ttl      = string
    filter                     = string
  })
  default = {
    ack_deadline_seconds       = null
    message_retention_duration = null
    retain_acked_messages      = null
    expiration_policy_ttl      = null
    filter                     = null
  }
}

variable "iam" {
  description = "IAM bindings for topic in {ROLE => [MEMBERS]} format."
  type        = map(list(string))
  default     = {}
}

variable "kms_key" {
  description = "KMS customer managed encryption key."
  type        = string
  default     = null
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
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
}
