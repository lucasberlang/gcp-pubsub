# Google PubSub Terraform Module

Inspired by and adapted from [this](https://registry.terraform.io/modules/terraform-google-modules/pubsub)
and its [source code](https://github.com/terraform-google-modules/terraform-google-pubsub).

* [GCP PubSub Topic](https://www.terraform.io/docs/providers/google/r/pubsub_topic.html)

## Terraform versions

Only Terraform 0.14 is supported.

## Assumptions

* This module will create one topic with zero or more IAM bindings for that topic

## Usage

```hcl
module "pubsub" {
  source = "git::ssh://git@vliamd634.cloud.bankia.int:7999/ter/gcp-pubsub.git?ref=v0.1.0"

  [...]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| google | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| google | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admins | A map of key name that indicates IAM members who will be granted as admins | `map(any)` | `{}` | no |
| create\_topic | Controls if the new topic should be created | `bool` | `true` | no |
| editors | A map of key name that indicates IAM members who will be granted as editors | `map(any)` | `{}` | no |
| encryption\_key\_names | A map of topic name that indicates a Cloud KMS key that will be used to encrypt objects | `map(any)` | `{}` | no |
| labels | A mapping of labels to assign to all resources | `map(string)` | n/a | yes |
| message\_storage\_policy | A list of IDs of regions where topic messages may be persisted in storage | <pre>list(object({<br>    algallowed_persistence_regionsorithm = list(string)<br>  }))</pre> | `[]` | no |
| set\_admin\_roles | Grant roles/pubsub.admin | `bool` | `false` | no |
| set\_editor\_roles | Grant roles/pubsub.editor | `bool` | `false` | no |
| set\_viewer\_roles | Grant roles/pubsub.viewer | `bool` | `false` | no |
| topics | The name for the topics | `list(string)` | n/a | yes |
| viewers | A map of key name that indicates IAM members who will be granted as viewers | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ids\_list | List of topic IDs |
| topics\_list | List of topic names |

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
