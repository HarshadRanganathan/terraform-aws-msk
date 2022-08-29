################################################################################
# Outputs: Amazon Managed Kafka Service (MSK)
# Description: Outputs MSK cluster

output "arn" {
  value = module.msk.arn
}

output "zookeeper_connect_string" {
  value = module.msk.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = module.msk.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = module.msk.bootstrap_brokers_tls
}

################################################################################
# outputs: Amazon Cloudwatch group
# Description: outputs cloudwatch group for MSK logging
output "cloudwatch_group_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = module.cloudwatch_group.arn
}