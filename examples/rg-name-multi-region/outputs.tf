output "rg_names" {
  description = "A map of the resource group names with the location as its key."
  value       = module.rg_names.locations
}