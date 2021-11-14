locals {
  environment = (var.environment != null
    ? var.environment
    : ""
  )

  locations = (var.locations != null
    ? var.locations
    : []
  )

  resource_type_key = (var.resource_type != null
    ? replace(replace(lower(var.resource_type), "azure", ""), " ", "")
    : ""
  )

  resource_type = lookup(local.resource_types, local.resource_type_key, local.resource_type_key)
  resource_types = {
    # general
    apimanagementservice = "apim"
    managedidentity      = "id"
    managementgroup      = "mg"
    policydefinition     = "policy"
    resourcegroup        = "rg"

    # compute and web
    appservice                   = "app"
    appserviceenvironment        = "ase"
    appserviceplan               = "plan"
    availabilityset              = "avail"
    arcenabledserver             = "arcs"
    arcenabledkubernetescluster  = "arck"
    cloudservice                 = "cld"
    diskencryptionset            = "des"
    functionapp                  = "func"
    gallery                      = "gal"
    manageddiskdata              = "disk"
    manageddiskos                = "osdisk"
    notificationhub              = "ntf"
    notificationhubnamespace     = "ntfns"
    snapshot                     = "snap"
    staticwebapp                 = "stapp"
    virtualmachine               = "vm"
    virtualmachinescaleset       = "vmss"
    virtualmachinestorageaccount = "stvm"
    webapp                       = "app"

    # containers
    akscluster           = "aks"
    containerinstance    = "ci"
    containerregistry    = "cr"
    servicefabriccluster = "sf"

    # databases
    cosmosdbdatabase                 = "cosmos"
    mysqldatabase                    = "mysql"
    postgresqldatabase               = "psql"
    rediscache                       = "redis"
    sqldatabase                      = "sqldb"
    sqldatabaseserver                = "sql"
    sqlmanagedinstance               = "sqlmi"
    sqlserverstretchdatbase          = "sqlstrdb"
    synapseanalytics                 = "syn"
    synapseanalyticssqldedicatedpool = "syndp"
    synapseanalyticssqlsparkpool     = "synsp"
    synapseanalysticsworkspace       = "synw"

    # management and governance
    applicationinsights   = "appi"
    automationaccount     = "aa"
    blueprint             = "bp"
    blueprintassignment   = "bpa"
    keyvault              = "kv"
    loganalyticsworkspace = "log"

    # networking
    applicationgateway                    = "agw"
    applicationsecuritygroup              = "asg"
    bastion                               = "bas"
    cdnendpoint                           = "cdne"
    cdnprofile                            = "cndp"
    connection                            = "con"
    dns                                   = "dnsz"
    dnszone                               = "pdnsz"
    expressroutecircuit                   = "erc"
    firewall                              = "afw"
    firewallpolicy                        = "afwp"
    frontdoor                             = "fd"
    frontdoorfirewallpolicy               = "fdfp"
    loadbalancerexternal                  = "lbe"
    loadbalancerinternal                  = "lbi"
    loadbalancerrule                      = "rule"
    localnetworkgateway                   = "lgw"
    natgateway                            = "ng"
    networkinterface                      = "nic"
    networksecuritygroup                  = "nsg"
    networksecuritygroupsecurityrule      = "nsgsr"
    networkwatcher                        = "nw"
    privatelink                           = "pl"
    publicipaddress                       = "pip"
    publicipaddressprefix                 = "ippre"
    routefilter                           = "rf"
    routetable                            = "rt"
    serviceendpoint                       = "se"
    subnet                                = "snet" # custom
    trafficmanagerprofile                 = "traf"
    userdefinedroute                      = "udr"
    virtualnetwork                        = "vnet"
    virtualnetworkgateway                 = "vgw"
    virtualnetworkpeering                 = "peer"
    virtualnetworksubnet                  = "snet"
    virtualwan                            = "vwan"
    vpngateway                            = "vpng"
    vpnconnection                         = "vcn"
    vpnsite                               = "vst"
    webapplicationfirewallpolicy          = "waf"
    webapplicationfirewallpolicyrulegroup = "wafrg"

    # storage
    azurestorpimple = "ssimp"
    storageaccount  = "sa"
  }

  quantity = (var.quantity != null
    ? var.quantity
    : 0
  )

  separator = (var.separator != null
    ? var.separator
    : ""
  )

  separator_override = {
    cr = ""
    sa = ""
  }

  separator_environment = (local.environment != ""
    ? lookup(local.separator_override, local.resource_type, local.separator)
    : ""
  )

  separator_locations = (length(local.locations) > 0
    ? lookup(local.separator_override, local.resource_type, local.separator)
    : ""
  )

  separator_quantity = (local.quantity > 0
    ? lookup(local.separator_override, local.resource_type, local.separator)
    : ""
  )

  separator_resource_type = (local.resource_type != ""
    ? lookup(local.separator_override, local.resource_type, local.separator)
    : ""
  )
}
