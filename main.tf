resource "azurerm_dns_zone" "this" {
  for_each = var.create_public_dns_zone ? { "dns" = "true" } : {}

  name                = var.public_dns_zone_name
  resource_group_name = var.public_dns_zone_resource_group_name
  tags                = var.tags

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "azurerm_dns_ns_record" "this" {
  for_each = var.public_parent_domain_name != null ? { "subdomain" = "true" } : {}

  name                = split(".", var.public_dns_zone_name)[0]
  zone_name           = var.public_parent_domain_name
  resource_group_name = var.public_dns_zone_resource_group_name
  ttl                 = var.ttl

  records = azurerm_dns_zone.this["dns"].name_servers

  tags = var.tags

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "azurerm_private_dns_zone" "this" {
  for_each = (
    !var.link_only && var.create_private_dns_zone
  ) ? { "dns" = "true" } : {}

  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name

  soa_record {
    email        = var.soa_record.email
    expire_time  = var.soa_record.expire_time
    minimum_ttl  = var.soa_record.minimum_ttl
    refresh_time = var.soa_record.refresh_time
    retry_time   = var.soa_record.retry_time
    ttl          = var.soa_record.ttl
    tags         = var.soa_record.tags
  }

  tags = var.tags

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone" {
  for_each = (
    !var.no_network_link && var.create_private_dns_zone
  ) ? { "dns" = "true" } : {}

  name                  = format("%s-%s", var.virtual_network_name, replace(var.private_dns_zone_name, ".", "-"))
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this["dns"].name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.auto_reg_enabled
  tags                  = var.tags

  depends_on = [
    azurerm_private_dns_zone.this
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_link_only" {
  for_each = var.link_only ? { "link_only" = "true" } : {}

  name                  = format("%s-%s", var.virtual_network_name, replace(var.private_dns_zone_name, ".", "-"))
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.auto_reg_enabled
  tags                  = var.tags
}