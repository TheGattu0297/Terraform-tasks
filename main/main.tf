data "azurerm_client_config" "current" {}

module "resource_group" {    
  source    = "../modules/resourcegroup"
  rg_name   = var.rg_name
  location  = var.location  
  tags      = var.tags
}
module "key_vault" {    
  source    = "../modules/keyvault"
  depends_on = [ module.resource_group ]
  kv_name   = var.kv_name
  rg_name   = var.rg_name
  location  = var.location  
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
}
module "redis_instance" {
  source              = "../modules/redis"
  resource_group_name = var.rg_name
  redis_name          = "redis-db-instance"
  sku_name            = "Standard"
  location  = var.location 
  capacity            = 2
  family              = "C"
  enable_non_ssl_port = true
}
module "key_vault_secret" {
  source              = "../modules/keyvaultsecret"
  depends_on = [ module.resource_group,module.redis_instance ]
  key_vault_id        = module.key_vault.key_vault_id
  secret_names = {
    "redis-primary-key"   = module.redis_instance.primary_key
    "redis-secondary-key" = module.redis_instance.secondary_key
  }
}