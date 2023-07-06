resource "azurerm_dns_zone" "public_dns_zone" {
  for_each = {
    for key, value in var.public_dns_zones : key => value
    if value.subdomain == null
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

}

resource "azurerm_dns_zone" "public_dns_subdomain" {
  for_each = {
    for key, value in var.public_dns_zones : key => value
    if value.subdomain != null
  }

  name                = each.value.subdomain
  resource_group_name = each.value.subdomain_resource_group_name
  tags                = each.value.tags
}

resource "azurerm_dns_ns_record" "public_dns_zone" {
  for_each = {
    for key, value in var.public_dns_zones : key => value
    if value.subdomain != null
  }

  name                = split(".", each.value.subdomain)[0]
  zone_name           = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl

  records = azurerm_dns_zone.public_dns_subdomain[each.key].name_servers

  tags = each.value.tags
}
