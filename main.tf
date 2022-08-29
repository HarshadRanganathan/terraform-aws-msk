terraform {
  backend "s3" {}
}

locals {
  description = "Managed By Terraform"
  config_name = "aws-${var.stage}-kafka"

  server_properties = <<PROPERTIES
    auto.create.topics.enable = true
  PROPERTIES
}

################################################################################
# Module: Amazon Cloudwatch Group
# Description: Creates cloudwatch group for MSK logging
module "cloudwatch_group" {
  source = "git::https://github.com/HarshadRanganathan/terraform-aws-module-cloudwatch.git//module/log-group?ref=1.0.1"

  enabled = true

  namespace = var.namespace
  stage = var.stage
  name = "kafka"
  stream_names = [
    format("%s-%s-cloudwatch-group-kafka-stream", var.namespace, var.stage)
  ]

  retention_in_days = 7
}

################################################################################
# Module: Amazon Managed Kafka Service (MSK)
# Description: Creates MSK cluster
module "msk" {
  source = "git::https://github.com/HarshadRanganathan/terraform-aws-module-msk.git//module?ref=1.0.3"

  namespace = var.namespace
  stage = var.stage
  name = var.name

  kafka_version = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  # broker_node_group_info
  instance_type = var.instance_type
  ebs_volume_size = var.ebs_volume_size
  client_subnets = data.terraform_remote_state.vpc.outputs.private_subnets

  # Cloudwatch Logs
  enable_cloudwatch_logs = var.enable_cloudwatch_logs
  cloudwatch_log_group_arn = "aws-${var.stage}-kafka-log-group"

  # encryption_in_transit
  client_broker = var.client_broker

  enhanced_monitoring = var.enhanced_monitoring

  # prometheus exporters
  jmx_exporter_enabled = var.jmx_exporter_enabled
  node_exporter_enabled = var.node_exporter_enabled

  msk_tags = {
    Name = "aws-${var.stage}-kafka"
    Stage = var.stage
    ManagedBy = "terraform"
  }

  config_enabled = var.config_enabled
  config_name = local.config_name
  server_properties = local.server_properties

  cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
}
