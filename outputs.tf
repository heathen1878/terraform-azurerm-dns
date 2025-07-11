output "dns" {
  description = "DNS"
  value = {
    network_link = azurerm_private_dns_zone_virtual_network_link.private_dns_zone
    ns_records   = azurerm_dns_ns_record.this
    public       = azurerm_dns_zone.this
    private      = azurerm_private_dns_zone.this
  }
}