resource "azurerm_dns_zone" "public_dns_zone" {
  for_each = var.public_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}