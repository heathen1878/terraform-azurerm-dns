resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  soa_record {
    email        = each.value.soa_record.email
    expire_time  = each.value.soa_record.expire_time
    minimum_ttl  = each.value.soa_record.minimum_ttl
    refresh_time = each.value.soa_record.refresh_time
    retry_time   = each.value.soa_record.retry_time
    ttl          = each.value.soa_record.ttl
    tags         = each.value.soa_record.tags
  }
  tags = each.value.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone" {
  for_each = var.private_dns_zones

  name                  = format("%s-%s", each.value.virtual_network_name, replace(each.value.name, ".", "-"))
  resource_group_name   = each.value.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone[each.key].name
  virtual_network_id    = each.value.virtual_network_id
}