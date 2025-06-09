resource "azurerm_mssql_database" "abhi-sql_db" {
  name           = var.sql_database_name
  server_id      = var.sql_server_id
  sku_name       = "Basic"
  max_size_gb    = 2
  collation      = "SQL_Latin1_General_CP1_CI_AS"
}

