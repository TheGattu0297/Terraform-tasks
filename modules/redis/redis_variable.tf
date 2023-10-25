variable "resource_group_name" {
  description = "Name of the resource group where Redis will be created."
  type        = string
}

variable "redis_name" {
  description = "Name of the Redis instance."
  type        = string
}

variable "sku_name" {
  description = "The SKU (size) of the Redis instance."
  type        = string
}

variable "capacity" {
  description = "The capacity of the Redis instance."
  type        = number
}

variable "family" {
  description = "The family of the Redis instance (C, P)."
  type        = string
}

variable "enable_non_ssl_port" {
  description = "Whether to enable the non-SSL port."
  type        = bool
}

variable "location" {
  description = "Whether to enable the non-SSL port."
  type        = string
}