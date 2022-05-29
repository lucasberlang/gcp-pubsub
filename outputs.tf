
######
# google_pubsub_topic
######

output "topics_list" {
  description = "List of topic names"
  value       = google_pubsub_topic.topics.*.name
}

output "ids_list" {
  description = "List of topic IDs"
  value       = google_pubsub_topic.topics.*.id
}
