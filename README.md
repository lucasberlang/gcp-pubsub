# Google PubSub Terraform Module

Inspired by and adapted from [this](https://registry.terraform.io/modules/terraform-google-modules/pubsub)
and its [source code](https://github.com/terraform-google-modules/terraform-google-pubsub).

* [GCP PubSub Topic](https://www.terraform.io/docs/providers/google/r/pubsub_topic.html)

## Terraform versions

Supported version 0.15 and higher.

## Usage

```hcl
module "gcp-pubsub" {
  source = "git::https://github.com/lucasberlang/gcp-pubsub.git?ref=v1.2.0"

  [...]
}
```

>The value of the ref source argument can be any terraform module version, please see [version list](https://github.com/lucasberlang/gcp-pubsub/tags). We recommend the use of the most updated version.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_binding.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_binding) | resource |
| [google_pubsub_topic.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_binding.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dead_letter_configs"></a> [dead\_letter\_configs](#input\_dead\_letter\_configs) | Per-subscription dead letter policy configuration. <br> <a name=topic:></a>[topic:](#topic:) The name of the topic to which dead letter messages should be published. Format is projects/{project}/topics/{topic}. The Cloud Pub/Sub service account associated with the enclosing subscription's parent project (i.e., service-{project\_number}@gcp-sa-pubsub.iam.gserviceaccount.com) must have permission to Publish() to this topic. The operation will fail if the topic does not exist. Users should ensure that there is a subscription attached to this topic since messages published to a topic with no subscriptions are lost. <br> <a name=max\_delivery\_attempts:></a>[max\_delivery\_attempts:](#max\_delivery\_attempts:) The maximum number of delivery attempts for any message. The value must be between 5 and 100. The number of delivery attempts is defined as 1 + (the sum of number of NACKs and number of times the acknowledgement deadline has been exceeded for the message). A NACK is any call to ModifyAckDeadline with a 0 deadline. Note that client libraries may automatically extend ack\_deadlines. This field will be honored on a best effort basis. If this parameter is 0, a default value of 5 is used. | <pre>map(object({<br>    topic                 = string<br>    max_delivery_attempts = number<br>  }))</pre> | `{}` | no |
| <a name="input_defaults"></a> [defaults](#input\_defaults) | Subscription defaults for options. <br> <a name=ack\_deadline\_seconds:></a>[ack\_deadline\_seconds:](#ack\_deadline\_seconds:) This value is the maximum time after a subscriber receives a message before the subscriber should acknowledge the message. After message delivery but before the ack deadline expires and before the message is acknowledged, it is an outstanding message and will not be delivered again during that time (on a best-effort basis). For pull subscriptions, this value is used as the initial value for the ack deadline. To override this value for a given message, call subscriptions.modifyAckDeadline with the corresponding ackId if using pull. The minimum custom deadline you can specify is 10 seconds. The maximum custom deadline you can specify is 600 seconds (10 minutes). If this parameter is 0, a default value of 10 seconds is used. For push delivery, this value is also used to set the request timeout for the call to the push endpoint. If the subscriber never acknowledges the message, the Pub/Sub system will eventually redeliver the message. <br> <a name=message\_retention\_duration:></a>[message\_retention\_duration:](#message\_retention\_duration:) How long to retain unacknowledged messages in the subscription's backlog, from the moment a message is published. If retain\_acked\_messages is true, then this also configures the retention of acknowledged messages, and thus configures how far back in time a subscriptions.seek can be done. Defaults to 7 days. Cannot be more than 7 days ('604800s') or less than 10 minutes ('600s'). A duration in seconds with up to nine fractional digits, terminated by 's'. Example: '600.5s'. <br> <a name=retain\_acked\_messages:></a>[retain\_acked\_messages:](#retain\_acked\_messages:) Indicates whether to retain acknowledged messages. If true, then messages are not expunged from the subscription's backlog, even if they are acknowledged, until they fall out of the messageRetentionDuration window. <br> <a name=expiration\_policy\_ttl:></a>[expiration\_policy\_ttl:](#expiration\_policy\_ttl:) Specifies the `time-to-live` duration for an associated resource. The resource expires if it is not active for a period of ttl. If ttl is not set, the associated resource never expires. A duration in seconds with up to nine fractional digits, terminated by 's'. Example - `3.5s`. <br> <a name=filter:></a>[filter:](#filter:) The subscription only delivers the messages that match the filter. Pub/Sub automatically acknowledges the messages that don't match the filter. You can filter messages by their attributes. The maximum length of a filter is 256 bytes. After creating the subscription, you can't modify the filter. | <pre>object({<br>    ack_deadline_seconds       = number<br>    message_retention_duration = string<br>    retain_acked_messages      = bool<br>    expiration_policy_ttl      = string<br>    filter                     = string<br>  })</pre> | <pre>{<br>  "ack_deadline_seconds": null,<br>  "expiration_policy_ttl": null,<br>  "filter": null,<br>  "message_retention_duration": null,<br>  "retain_acked_messages": null<br>}</pre> | no |
| <a name="input_iam"></a> [iam](#input\_iam) | IAM bindings for topic in {ROLE => [MEMBERS]} format. | `map(list(string))` | `{}` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | KMS customer managed encryption key. | `string` | `null` | no |
| <a name="input_message_retention_duration"></a> [message\_retention\_duration](#input\_message\_retention\_duration) | Minimum duration to retain a message after it is published to the topic. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | PubSub topic name. | `string` | n/a | yes |
| <a name="input_offset"></a> [offset](#input\_offset) | The offset to be added to the google pubsub topic | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project used for resources. | `string` | n/a | yes |
| <a name="input_push_configs"></a> [push\_configs](#input\_push\_configs) | Push subscription configurations. <br> <a name=attributes:></a>[attributes:](#attributes:) Endpoint configuration attributes. Every endpoint has a set of API supported attributes that can be used to control different aspects of the message delivery. The currently supported attribute is x-goog-version, which you can use to change the format of the pushed message. This attribute indicates the version of the data expected by the endpoint. This controls the shape of the pushed message (i.e., its fields and metadata). The endpoint version is based on the version of the Pub/Sub API. If not present during the subscriptions.create call, it will default to the version of the API used to make such call. If not present during a subscriptions.modifyPushConfig call, its value will not be changed. subscriptions.get calls will always return a valid version, even if the subscription was created without this attribute. The possible values for this attribute are: v1beta1: uses the push format defined in the v1beta1 Pub/Sub API. v1 or v1beta2: uses the push format defined in the v1 Pub/Sub API. <br> <a name=endpoint:></a>[endpoint:](#endpoint:) A URL locating the endpoint to which messages should be pushed. For example, a Webhook endpoint might use 'https://example.com/push'. <br> <a name=oidc\_token:></a>[oidc\_token:](#oidc\_token:) If specified, Pub/Sub will generate and attach an OIDC JWT token as an Authorization header in the HTTP request for every pushed message. <br> - audience: Audience to be used when generating OIDC token. The audience claim identifies the recipients that the JWT is intended for. The audience value is a single case-sensitive string. Having multiple values (array) for the audience field is not supported. More info about the OIDC JWT token audience here: https://tools.ietf.org/html/rfc7519#section-4.1.3 Note: if not specified, the Push endpoint URL will be used. <br> - service\_account\_email: Service account email to be used for generating the OIDC token. The caller (for subscriptions.create, subscriptions.patch, and subscriptions.modifyPushConfig RPCs) must have the iam.serviceAccounts.actAs permission for the service account. | <pre>map(object({<br>    attributes = map(string)<br>    endpoint   = string<br>    oidc_token = object({<br>      audience              = string<br>      service_account_email = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | List of regions used to set persistence policy. | `list(string)` | `[]` | no |
| <a name="input_subscription_iam"></a> [subscription\_iam](#input\_subscription\_iam) | IAM bindings for subscriptions in {SUBSCRIPTION => {ROLE => [MEMBERS]}} format. <br> <a name=sub:></a>[sub:](#sub:) The subscription name or id to bind to attach IAM policy to. <br> <a name=role:></a>[role:](#role:) The role that should be applied. Only one google\_pubsub\_subscription\_iam\_binding can be used per role. Note that custom roles must be of the format [projects\|organizations]/{parent-name}/roles/{role-name}. <br> <a name=members:></a>[members:](#members:) Identities that will be granted the privilege in role. | `map(map(list(string)))` | `{}` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | Topic subscriptions. Also define push configs for push subscriptions. If options is set to null subscription defaults will be used. Labels default to topic labels if set to null. <br> <a name=ack\_deadline\_seconds:></a>[ack\_deadline\_seconds:](#ack\_deadline\_seconds:) This value is the maximum time after a subscriber receives a message before the subscriber should acknowledge the message. After message delivery but before the ack deadline expires and before the message is acknowledged, it is an outstanding message and will not be delivered again during that time (on a best-effort basis). For pull subscriptions, this value is used as the initial value for the ack deadline. To override this value for a given message, call subscriptions.modifyAckDeadline with the corresponding ackId if using pull. The minimum custom deadline you can specify is 10 seconds. The maximum custom deadline you can specify is 600 seconds (10 minutes). If this parameter is 0, a default value of 10 seconds is used. For push delivery, this value is also used to set the request timeout for the call to the push endpoint. If the subscriber never acknowledges the message, the Pub/Sub system will eventually redeliver the message. <br> <a name=message\_retention\_duration:></a>[message\_retention\_duration:](#message\_retention\_duration:) How long to retain unacknowledged messages in the subscription's backlog, from the moment a message is published. If retain\_acked\_messages is true, then this also configures the retention of acknowledged messages, and thus configures how far back in time a subscriptions.seek can be done. Defaults to 7 days. Cannot be more than 7 days (`604800s`) or less than 10 minutes (`600s`). A duration in seconds with up to nine fractional digits, terminated by 's'. Example: `600.5s`. <br> <a name=retain\_acked\_messages:></a>[retain\_acked\_messages:](#retain\_acked\_messages:) Indicates whether to retain acknowledged messages. If true, then messages are not expunged from the subscription's backlog, even if they are acknowledged, until they fall out of the messageRetentionDuration window. <br> <a name=expiration\_policy\_ttl:></a>[expiration\_policy\_ttl:](#expiration\_policy\_ttl:) Specifies the `time-to-live` duration for an associated resource. The resource expires if it is not active for a period of ttl. If ttl is not set, the associated resource never expires. A duration in seconds with up to nine fractional digits, terminated by 's'. Example - `3.5s`. <br> <a name=filter:></a>[filter:](#filter:) The subscription only delivers the messages that match the filter. Pub/Sub automatically acknowledges the messages that don't match the filter. You can filter messages by their attributes. The maximum length of a filter is 256 bytes. After creating the subscription, you can't modify the filter. | <pre>map(object({<br>    labels = map(string)<br>    options = object({<br>      ack_deadline_seconds       = number<br>      message_retention_duration = string<br>      retain_acked_messages      = bool<br>      expiration_policy_ttl      = string<br>      filter                     = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Topic id. |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | Subscription ids. |
| <a name="output_subscriptions"></a> [subscriptions](#output\_subscriptions) | Subscription resources. |
| <a name="output_topic"></a> [topic](#output\_topic) | Topic resource. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Test

### Environment

Since most automated tests written with Terratest can make potentially destructive changes in your environment, we
strongly recommend running tests in an environment that is totally separate from production. For example, if you are
testing infrastructure code for GCP, you should run your tests in a completely separate GCP account.

### Requirements

Terratest uses the Go testing framework. To use terratest, you need to install:

* [Go](https://golang.org/) (requires version >=1.13)

### Running

Now you should be able to run the example test.

1. Change your working directory to the `test/src` folder.
1. Each time you want to run the tests:

```bash
go test -timeout 20m
```

### Terraform CLI

On the `examples/dummy` folder, perform the following commands.

* Get the plugins:

```bash
terraform init
```

* Review and apply the infrastructure test build:

```bash
terraform apply -var-file=fixtures.europe-west3.tfvars
```

* Remove all resources:

```bash
terraform destroy -auto-approve
```
