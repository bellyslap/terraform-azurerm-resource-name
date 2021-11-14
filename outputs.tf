output "locations" {
  description = "A map of resource names incorporating the resource's location with the location as the key."
  value = (length(local.locations) > 0 && local.quantity == 0
    ? { for location in local.locations :
      location => format("%s%s%s%s%s%s%s", var.name, local.separator_locations, location, local.separator_resource_type, local.resource_type, local.separator_environment, local.environment)
    }
    : null
  )
}

output "name" {
  description = "The resource name for a single instance without a location."
  value = (local.quantity == 0      # single instance
    ? (length(local.locations) == 0 # no location
      ? format("%s%s%s%s%s", var.name, local.separator_resource_type, local.resource_type, local.separator_environment, local.environment)
      : null
    )
    : null
  )
}

output "names" {
  description = "A list of resource names for one or more instances."
  value = (local.quantity > 0       # multiple instances
    ? (length(local.locations) == 0 # no location
      ? [for index in range(1, local.quantity + 1) :
        format("%s%s%s%s%s%s%s", var.name, local.separator_resource_type, local.resource_type, local.separator_quantity, index, local.separator_environment, local.environment)
      ]
      : (length(local.locations) == 1 # single location
        ? [for index in range(1, local.quantity + 1) :
          format("%s%s%s%s%s%s%s%s%s", var.name, local.separator_locations, local.locations[0], local.separator_resource_type, local.resource_type, local.separator_quantity, index, local.separator_environment, local.environment)
        ]
        : null
      )
    )
    : null
  )
}
