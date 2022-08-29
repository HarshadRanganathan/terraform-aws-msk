################################################################################
# Variable: Amazon Managed service kafka (MSK)
# Description: Variables Amazon Managed service kafka (MSK)
variable "name" {
  type        = string
  description = "AWS region"
  default     = "kafka"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
  default     = ""
}

variable "stage" {
  type        = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "enabled" {
  type        = bool
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "kafka_version" {
  description = "specify the kafka version 1.1.1 or 2.2.1 or 2.3.1"
  type        = string
  default     = "2.2.1"
}

variable "number_of_broker_nodes" {
  description = "set the number of kafka broker nodes"
  type        = string
  default     = "3"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "msk_tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "set the aws instance type for the broker nodes"
  type        = string
  default     = "kafka.m5.large"
}

variable "ebs_volume_size" {
  description = "set the ebs volume size for the msk broker nodes"
  type        = string
  default     = "1000"
}

variable "vpc_id" {
  description = "VPC ID for where the MSK nodes will reside"
  type        = list(string)
  default     = []
}

variable "client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
  default     = []
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN"
  type        = string
  default     = ""
}

variable "client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  type        = string
  default     = "TLS_PLAINTEXT"
}

variable "az_distribution" {
  description = "The distribution of broker nodes across availability zones"
  type        = string
  default     = "DEFAULT"
}

variable "config_description" {
  description = "Description of the configuration."
  type        = string
  default     = ""
}

variable "config_enabled" {
  description = "Enable server configuration"
  type        = bool
  default     = false
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level."
  type        = string
  default     = "DEFAULT"
}

variable "jmx_exporter_enabled" {
  description = "Indicates whether you want to enable or disable the JMX Exporter"
  type        = bool
  default     = false
}

variable "node_exporter_enabled" {
  description = "Indicates whether you want to enable or disavle the NODE Exporter"
  type        = bool
  default     = false
}

variable "enable_cloudwatch_logs" {
  description = "Indicates wheterh you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_arn" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = ""
}

################################################################################
# Variable: Amazon Key Management Service (KMS)
# Description: Variables KMS Key for encryption
variable "deletion_window_in_days" {
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}
