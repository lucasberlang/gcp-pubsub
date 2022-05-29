
output "dummy_topics_list" {
  description = "List of topic names"
  value       = module.pubsub.topics_list
}
