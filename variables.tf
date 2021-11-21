variable "environment" {
  description = "(Optional) Specifies the stage of the development lifecycle for the workload that the resource supports."
  type        = string
  default     = null
}

variable "location" {
  description = "(Optional) Specifies the Azure region where the resource is deployed."
  type        = string
  default     = ""
}

variable "locations" {
  description = "(Optional) Specifies one or more Azure region where the resource is deployed. Defaults to `[]`."
  type        = list(string)
  default     = []
}

variable "name" {
  description = "(Required) Specifies the name of the application, workload, or service that the resource is a part of."
  type        = string
}

variable "quantity" {
  description = "(Optional) Specifies the number of resource instances."
  type        = number
  default     = null
}

variable "resource_type" {
  description = "(Optional) Specifies the type of Azure resource or asset."
  type        = string
  default     = null
}

variable "separator" {
  description = "(Optional) Specifies the string separating the components of the resource name. Defaults to `-`."
  type        = string
  default     = "-"
}
