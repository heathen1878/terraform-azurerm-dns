# DNS module

## Public DNS zone

Creates a given number of Public DNS zones and returns the name servers, to be consume by a 3rd party DNS module e.g. [IONOS](https://github.com/heathen1878/terraform-ionos-dns/blob/main/README.md). See example [usage](https://raw.githubusercontent.com/heathen1878/terraform-azurerm-dns/main/terraform.tfvars.example).

## Private DNS zone

Creates a given number of Private DNS zones and links them to a given Virtual Network. See example [usage](https://raw.githubusercontent.com/heathen1878/terraform-azurerm-dns/main/terraform.tfvars.example).
