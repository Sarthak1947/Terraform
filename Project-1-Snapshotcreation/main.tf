data "azurerm_virtual_machine" "avdvm" {
    name = var.vm_name
    resource_group_name = var.vm_rg
}

resource "azurerm_snapshot" "os_disk_snapshot"{
    name = "$(var.vm_name)-osdisk"
    location = var.location
    resource_group_name = var.vm_rg
    create_option  = "Copy"
    source_uri = data.azurerm_virtual_machine.vm.storage_os_disk[0].managed_disk_id

    tags = {
        Environment = "Production"
        CreatedBy = "Terraform"
        SnapshotType = "Disk"
        Workload = "AVD"
        Automation = "True"
    }
}
