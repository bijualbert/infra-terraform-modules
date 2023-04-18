locals {
  servername = "${var.application_location}${var.application_environment}${var.application_domain}"
}


data "vsphere_datastore" "datastore" {
  count         = var.amount_of_servers
  name          = "${data.null_data_source.ds_name[count.index].outputs["datastore_name"]}"
  datacenter_id = var.vsphere_datacenter
}

data "null_data_source" "ds_name" {
  count         = var.amount_of_servers
  inputs = {
    datastore_name = "${var.vm_datastores[count.index % length(var.vm_datastores)]}"
  }
}

resource "vsphere_virtual_machine" "vsphereserver" {
  count                      = var.amount_of_servers
  name                       = "${local.servername}${count.index +1}"
  resource_pool_id           = var.vsphere_resource_pool_id
  datastore_id               = "${data.vsphere_datastore.datastore[count.index].id}"
  num_cpus                   = var.vm_cpu_sockets
  num_cores_per_socket       = var.vm_cpu_cores
  memory                     = var.vm_memory
  guest_id                   = var.vm_windows_version
  scsi_type                  = var.scsi_type
  wait_for_guest_net_timeout = 0
  network_interface {
    network_id = var.vm_network_name
  }

  clone {
    template_uuid = var.vm_template_uuid

    customize {
      windows_options {
        computer_name         = "${local.servername}${count.index + 1}"
        join_domain           = var.vm_domain
        domain_admin_user     = var.vm_domain_admin_user
        domain_admin_password = var.vm_domain_admin_password
        admin_password        = var.vm_admin_password
        full_name             = "Administrator"
        organization_name     = "Albelli BV"
        auto_logon            = "true"
        auto_logon_count      = "1"
        time_zone             = "110"
      }

      network_interface {
        ipv4_address    = "${var.vm_ipv4_address}${var.vm_ipv4_address_host + count.index}"
        ipv4_netmask    = var.vm_ipv4_subnet_mask
        dns_server_list = var.vm_dns_server_list
      }
      ipv4_gateway = var.vm_ipv4_gateway
    }
  }
  disk {
    label            = "disk0"
    size             = var.vm_disk_1_size
    thin_provisioned = var.vm_thin_provisioned_disk_1
    eagerly_scrub    = var.vm_eagerly_scrub_disk_1
  }
  disk {
    label            = "disk1"
    unit_number      = 1
    size             = var.vm_disk2_size
    thin_provisioned = var.vm_thin_provisioned_disk_2
    eagerly_scrub    = var.vm_eagerly_scrub_disk_2
  }

  provisioner "file" {
    content = templatefile("${path.module}/files/Octopus/InstallOctopus.ps1",
    {
    roles = var.octopus_roles,
    octopus_environment = var.octopus_environment,
    octopus_trust = var.octopus_trust,
    octopus_apikey = var.octopus_apikey
    }
    )
    destination = "C:/APShared/Launch/Scripts/InstallOctopus.ps1"
    connection {
      type     = "winrm"
      user     = "administrator"
      password = var.vm_admin_password
      host     = "${var.vm_ipv4_address}${var.vm_ipv4_address_host + count.index}"
      insecure = "true"
      timeout  = "25m"
      https    = "false"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -Command C:/APShared/Launch/Scripts/InstallOctopus.ps1",
    ]
    connection {
      host     = "${var.vm_ipv4_address}${var.vm_ipv4_address_host + count.index}"
      type     = "winrm"
      https    = "false"
      user     = "administrator"
      password = var.vm_admin_password
      agent    = "false"
      insecure = "true"
    }
  }
}

//  data "template_file" "octopus_script" {
//  template = "${file("${path.module}/files/Octopus/InstallOctopus.ps1")}"
//  vars = {
//    octopus_role1       = var.octopus_role1
//    octopus_role2       = var.octopus_role2
//    octopus_role3       = var.octopus_role3
//    octopus_environment = var.octopus_environment
//    octopus_trust       = var.octopus_trust
//    octopus_apikey      = var.octopus_apikey
//    }
//  }
