variable "aws_region" {
  default = "eu-west-1"
}
variable "aws_shared_services_account_id" {
  default = "973160909116"
}
variable "location" {
  default = "Almere"
}
variable "vsphere_vcenter_name" {}
variable "vsphere_datacenter" {}
variable "vsphere_compute_cluster" {}
variable "vsphere_resource_pool_id" {}
variable "vm_datastores" {
  type = "list"
}
variable "application_location" {}
variable "application_environment" {}
variable "application_domain" {}
variable "amount_of_servers" {
  default = 4
}
variable "vm_template_uuid" {}
variable "vm_windows_version" {
  default = "windows8Server64Guest"
}
variable "vm_domain" {}
variable "vm_domain_admin_user" {}
variable "vm_domain_admin_password" {}
variable "vm_workgroup" {}
variable "vm_admin_user" {}
variable "vm_admin_password" {}
variable "vm_cpu_sockets" {
  default = 1
}
variable "vm_cpu_cores" {
  default = 2
}
variable "vm_memory" {
  default = 4096
}
variable "vm_disk_1_size" {}
variable "vm_thin_provisioned_disk_1" {}
variable "vm_eagerly_scrub_disk_1" {}
variable "vm_disk2_size" {
  default = 20
}
variable "vm_thin_provisioned_disk_2" {}
variable "vm_eagerly_scrub_disk_2" {}
variable "vm_network_name" {}
variable "vm_ipv4_address" {}
variable "vm_ipv4_address_host" {}
variable "vm_ipv4_subnet_mask" {}
variable "vm_ipv4_gateway" {}
variable "vm_dns_server_list" {
  type = list
}
variable "scsi_type" {
  default = "lsilogic-sas"
}
variable "octopus_roles" {
  type = "list"
}
variable "octopus_environment" {}
variable "octopus_trust" {}
variable "octopus_apikey" {}

