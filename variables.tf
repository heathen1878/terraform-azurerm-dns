variable "public_dns_zones" {
  description = "A map of public DNS zone to create and manage"
  type = map(object(
    {
      name                          = string
      subdomain                     = optional(string, null)
      resource_group_name           = string
      subdomain_resource_group_name = optional(string, null)
      ttl                           = optional(number)
      tags                          = map(any)
    }
  ))

}

variable "private_dns_zones" {
  description = "A map of private DNS zone to create and manage"
  type = map(object(
    {
      name                = string
      resource_group_name = string
      soa_record = optional(object(
        {
          email        = string
          expire_time  = number
          minimum_ttl  = number
          refresh_time = number
          retry_time   = number
          ttl          = number
          tags         = map(any)
        }),
        {
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
      )
      tags                 = map(any)
      virtual_network_id   = string
      virtual_network_name = string
      link_only            = optional(bool, false)
    }
  ))

}

variable "management_subscription" {
  description = "The subscription to use for the AzureRM provider alias. It's only used if cross_subscription vNet peers are required."
  type        = string
}