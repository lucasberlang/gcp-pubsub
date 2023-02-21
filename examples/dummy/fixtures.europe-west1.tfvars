
project_id = "xxxxx"

offset = 1

name = "tst"

subscriptions = {
  "pullsub" = {
    labels = {
      foo = "bar"
    }
    options = {
      ack_deadline_seconds       = 20
      message_retention_duration = "1200s"
      retain_acked_messages      = true
      expiration_policy_ttl      = "300000.5s"
      filter                     = null
    }
  }
}

######
# Tags
######

tags = {
  "provider"                = "go",
  "region"                  = "euw1",
  "enterprise"              = "blue",
  "account"                 = "poc",
  "system"                  = "tst"
  "environment"             = "poc",
  "cmdb_name"               = "",
  "security_exposure_level" = "mz",
  "status"                  = "",
  "on_service"              = "yes",
}
