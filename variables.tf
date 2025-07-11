
variable "create_private_dns_zone" {
  description = "Must be true to create Private DNS zones"
  default     = false
  type        = bool
  validation {
    condition     = contains([true, false], var.create_private_dns_zone)
    error_message = "Can only be be true or false."
  }
}

variable "create_public_dns_zone" {
  description = "Must be true to create Public DNS zones"
  default     = false
  type        = bool
  validation {
    condition     = contains([true, false], var.create_public_dns_zone)
    error_message = "Can only be be true or false."
  }
}

variable "private_dns_zone_name" {
  description = "The private DNS zone name"
  default     = null
  type        = string
  validation {
    condition     = var.private_dns_zone_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9_]$", var.private_dns_zone_name))
    error_message = "The name must start with a number or letter, and can consist of letters, numbers, underscores, periods and hyphens and must end in a number, letter or underscore."
  }
}

variable "private_dns_zone_resource_group_name" {
  description = "The resource group where the private DNS zone should reside"
  default     = null
  type        = string
  validation {
    condition     = var.private_dns_zone_resource_group_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9._()\\-]*[^.]$", var.private_dns_zone_resource_group_name))
    error_message = "The resource group name must start with a number or letter, and can consist of letters, numbers, underscores, periods, parentheses and hyphens but must not end in a period."
  }
}

variable "soa_record" {
  description = "The Start of Authority for the Private DNS zone"
  default = {
    email        = "azureprivatedns-host.microsoft.com"
    expire_time  = 2419200
    minimum_ttl  = 10
    refresh_time = 3600
    retry_time   = 300
    ttl          = 3600
    tags = {
      defaults = "yes"
    }
  }
  type = object(
    {
      email        = string
      expire_time  = number
      minimum_ttl  = number
      refresh_time = number
      retry_time   = number
      ttl          = number
      tags         = map(any)
    }
  )
}

variable "public_dns_zone_name" {
  description = "The private DNS zone name"
  default     = null
  type        = string
  validation {
    condition     = var.public_dns_zone_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9_]$", var.public_dns_zone_name))
    error_message = "The name must start with a number or letter, and can consist of letters, numbers, underscores, periods and hyphens and must end in a number, letter or underscore."
  }
}

variable "public_dns_zone_resource_group_name" {
  description = "The resource group where the private DNS zone should reside"
  default     = null
  type        = string
  validation {
    condition     = var.public_dns_zone_resource_group_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9._()\\-]*[^.]$", var.public_dns_zone_resource_group_name))
    error_message = "The resource group name must start with a number or letter, and can consist of letters, numbers, underscores, periods, parentheses and hyphens but must not end in a period."
  }
}

variable "tags" {
  description = "A map of tags to assign to the Private DNS zone"
  default = {
    "warning" = "No tagging applied"
  }
  type = map(any)
}

variable "virtual_network_id" {
  description = "The virtual network resource ID to link to"
  default     = null
  type        = string
}

variable "virtual_network_name" {
  description = "The virtual network - used to name the private DNS link"
  default     = null
  type        = string
}

variable "link_only" {
  description = "Should the DNS zone be linked only?"
  default     = false
  type        = bool
  validation {
    condition     = contains([true, false], var.link_only)
    error_message = "Can only be be true or false."
  }
}

variable "no_network_link" {
  description = "Should the Private DNS zone be created within any network links?"
  default     = false
  type        = bool
  validation {
    condition     = contains([true, false], var.no_network_link)
    error_message = "Can only be be true or false."
  }
}

variable "auto_reg_enabled" {
  description = "Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?"
  default     = false
  type        = bool
}

variable "public_parent_domain_name" {
  description = "If the domain name is subdomain, what is the name of the parent?"
  default     = null
  type        = string
}

variable "ttl" {
  description = "The TTL for NS records"
  default     = 3600
  type        = number
}