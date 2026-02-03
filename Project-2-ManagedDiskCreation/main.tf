
data "snapshot_name" "source_snapshot"{
    name = var.snapshot_name
    location = var.location
    resource_group_name = var.snapshot_rg
}


resource "azurerm_managed_disk" "managed_disk_from_snapshot" {
    name = var.disk_name
    location = var.location
    resource_group_name = var.disk_rg

    storage_account_type = var.disk_sku
    create_option = copy
    source_resource_id = data.azurerm_snapshot.source_snapshot_id

 tags = {
    Environment  = "Prod"
    CreatedFrom  = "Snapshot"
    CreatedBy    = "Terraform"
    Workload     = "AVD"
    Automation   = "True"
  }

}
