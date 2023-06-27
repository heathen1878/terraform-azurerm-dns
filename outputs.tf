output "public_dns_zones" {
  value = azurerm_dns_zone.public_dns_zone
}

output "private_dns_zones" {
  value = azurerm_private_dns_zone.private_dns_zone
}