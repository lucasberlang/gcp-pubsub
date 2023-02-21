
output "id" {
  description = "Topic id."
  value       = module.pubsub.id
}

output "subscription_id" {
  description = "Subscription ids."
  value       = module.pubsub.subscription_id
}

output "subscriptions" {
  description = "Subscription resources."
  value       = module.pubsub.subscriptions
}

output "topic" {
  description = "Topic resource."
  value       = module.pubsub.topic
}

output "topic_name" {
  description = "Topic resource."
  value       = module.pubsub.topic.name
}
