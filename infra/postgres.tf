resource "azurerm_postgresql_flexible_server" "this" {
  name                = "psql-${local.prefix}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  version             = var.postgres_version
  delegated_subnet_id = azurerm_subnet.postgres.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  public_network_access_enabled = false

  zone                  = "1"
  storage_mb            = var.postgres_storage_mb
  sku_name              = var.postgres_sku_name
  backup_retention_days = 7

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgres
  ]

  tags = local.common_tags
}

resource "azurerm_postgresql_flexible_server_database" "app" {
  name      = "appdb"
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}