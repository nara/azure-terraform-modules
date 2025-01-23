variable "org_key" {
  description = "The organization 3 letter word"
  type        = string
}

variable "org_email_domain" {
  description = "The organization domain (e.g. example.com )"
  type        = string
}

variable "line_of_business_key" {
  description = "A 3 letter word for line of business that is unique in org"
  type        = string
}

variable "team_key" {
  description = "Opitonal. A 3 letter word for team managing the resources in this project"
  type        = string
  default = ""
}

variable "app_key" {
  description = "A 3 letter app key that is unique in org"
  type        = string
}

variable "environment" {
  description = "A max 4 letter word explaining the environment the resources belong to. e.g. dev, qa, uat, stg, prod"
  type        = string
}

variable "location" {
  description = "azure cloud location"
  type        = string
  default = ""
}

variable "location_short" {
  description = "Azure location short form"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

# Network Security Group definition

# Custom security rules
# [name, priority, direction, access, protocol, source_port_range, destination_port_range, description]"
# All the fields are required.
variable "destination_address_prefix" {
  type        = list(string)
  default     = ["*"]
  description = "Destination address prefix to be applied to all predefined rules. list(string) only allowed one element (CIDR, `*`, source IP range or Tags). Example [\"10.0.3.0/24\"] or [\"VirtualNetwork\"]"
}

variable "destination_address_prefixes" {
  type        = list(string)
  default     = null
  description = "Destination address prefix to be applied to all predefined rules. Example [\"10.0.3.0/32\",\"10.0.3.128/32\"]"
}

variable "rules" {
  type = map(any)
  # [direction, access, protocol, source_port_range, destination_port_range, description]"
  # The following info are in the submodules: source_address_prefix, destination_address_prefix
  default = {
    #ActiveDirectory
    ActiveDirectory-AllowADReplication          = ["Inbound", "Allow", "*", "*", "389", "AllowADReplication"]
    ActiveDirectory-AllowADReplicationSSL       = ["Inbound", "Allow", "*", "*", "636", "AllowADReplicationSSL"]
    ActiveDirectory-AllowADGCReplication        = ["Inbound", "Allow", "Tcp", "*", "3268", "AllowADGCReplication"]
    ActiveDirectory-AllowADGCReplicationSSL     = ["Inbound", "Allow", "Tcp", "*", "3269", "AllowADGCReplicationSSL"]
    ActiveDirectory-AllowDNS                    = ["Inbound", "Allow", "*", "*", "53", "AllowDNS"]
    ActiveDirectory-AllowKerberosAuthentication = ["Inbound", "Allow", "*", "*", "88", "AllowKerberosAuthentication"]
    ActiveDirectory-AllowADReplicationTrust     = ["Inbound", "Allow", "*", "*", "445", "AllowADReplicationTrust"]
    ActiveDirectory-AllowSMTPReplication        = ["Inbound", "Allow", "Tcp", "*", "25", "AllowSMTPReplication"]
    ActiveDirectory-AllowRPCReplication         = ["Inbound", "Allow", "Tcp", "*", "135", "AllowRPCReplication"]
    ActiveDirectory-AllowFileReplication        = ["Inbound", "Allow", "Tcp", "*", "5722", "AllowFileReplication"]
    ActiveDirectory-AllowWindowsTime            = ["Inbound", "Allow", "Udp", "*", "123", "AllowWindowsTime"]
    ActiveDirectory-AllowPasswordChangeKerberes = ["Inbound", "Allow", "*", "*", "464", "AllowPasswordChangeKerberes"]
    ActiveDirectory-AllowDFSGroupPolicy         = ["Inbound", "Allow", "Udp", "*", "138", "AllowDFSGroupPolicy"]
    ActiveDirectory-AllowADDSWebServices        = ["Inbound", "Allow", "Tcp", "*", "9389", "AllowADDSWebServices"]
    ActiveDirectory-AllowNETBIOSAuthentication  = ["Inbound", "Allow", "Udp", "*", "137", "AllowNETBIOSAuthentication"]
    ActiveDirectory-AllowNETBIOSReplication     = ["Inbound", "Allow", "Tcp", "*", "139", "AllowNETBIOSReplication"]

    #Cassandra
    Cassandra = ["Inbound", "Allow", "Tcp", "*", "9042", "Cassandra"]

    #Cassandra-JMX
    Cassandra-JMX = ["Inbound", "Allow", "Tcp", "*", "7199", "Cassandra-JMX"]

    #Cassandra-Thrift
    Cassandra-Thrift = ["Inbound", "Allow", "Tcp", "*", "9160", "Cassandra-Thrift"]

    #CouchDB
    CouchDB = ["Inbound", "Allow", "Tcp", "*", "5984", "CouchDB"]

    #CouchDB-HTTPS
    CouchDB-HTTPS = ["Inbound", "Allow", "Tcp", "*", "6984", "CouchDB-HTTPS"]

    #DNS-TCP
    DNS-TCP = ["Inbound", "Allow", "Tcp", "*", "53", "DNS-TCP"]

    #DNS-UDP
    DNS-UDP = ["Inbound", "Allow", "Udp", "*", "53", "DNS-UDP"]

    #DynamicPorts
    DynamicPorts = ["Inbound", "Allow", "Tcp", "*", "49152-65535", "DynamicPorts"]

    #ElasticSearch
    ElasticSearch = ["Inbound", "Allow", "Tcp", "*", "9200-9300", "ElasticSearch"]

    #FTP
    FTP = ["Inbound", "Allow", "Tcp", "*", "21", "FTP"]

    #HTTP
    HTTP = ["Inbound", "Allow", "Tcp", "*", "80", "HTTP"]

    #HTTPS
    HTTPS = ["Inbound", "Allow", "Tcp", "*", "443", "HTTPS"]

    #IMAP
    IMAP = ["Inbound", "Allow", "Tcp", "*", "143", "IMAP"]

    #IMAPS
    IMAPS = ["Inbound", "Allow", "Tcp", "*", "993", "IMAPS"]

    #Kestrel
    Kestrel = ["Inbound", "Allow", "Tcp", "*", "22133", "Kestrel"]

    #LDAP
    LDAP = ["Inbound", "Allow", "Tcp", "*", "389", "LDAP"]

    #MongoDB
    MongoDB = ["Inbound", "Allow", "Tcp", "*", "27017", "MongoDB"]

    #Memcached
    Memcached = ["Inbound", "Allow", "Tcp", "*", "11211", "Memcached"]

    #MSSQL
    MSSQL = ["Inbound", "Allow", "Tcp", "*", "1433", "MSSQL"]

    #MySQL
    MySQL = ["Inbound", "Allow", "Tcp", "*", "3306", "MySQL"]

    #Neo4J
    Neo4J = ["Inbound", "Allow", "Tcp", "*", "7474", "Neo4J"]

    #POP3
    POP3 = ["Inbound", "Allow", "Tcp", "*", "110", "POP3"]

    #POP3S
    POP3S = ["Inbound", "Allow", "Tcp", "*", "995", "POP3S"]

    #PostgreSQL
    PostgreSQL = ["Inbound", "Allow", "Tcp", "*", "5432", "PostgreSQL"]

    #RabbitMQ
    RabbitMQ = ["Inbound", "Allow", "Tcp", "*", "5672", "RabbitMQ"]

    #RDP
    RDP = ["Inbound", "Allow", "Tcp", "*", "3389", "RDP"]

    #Redis
    Redis = ["Inbound", "Allow", "Tcp", "*", "6379", "Redis"]

    #Riak
    Riak = ["Inbound", "Allow", "Tcp", "*", "8093", "Riak"]

    #Riak-JMX
    Riak-JMX = ["Inbound", "Allow", "Tcp", "*", "8985", "Riak-JMX"]

    #SMTP
    SMTP = ["Inbound", "Allow", "Tcp", "*", "25", "SMTP"]

    #SMTPS
    SMTPS = ["Inbound", "Allow", "Tcp", "*", "465", "SMTPS"]

    #SSH
    SSH = ["Inbound", "Allow", "Tcp", "*", "22", "SSH"]

    #WinRM
    WinRM = ["Inbound", "Allow", "Tcp", "*", "5986", "WinRM"]
  }
  description = "Standard set of predefined rules"
}

variable "security_group_name" {
  type        = string
  default     = "nsg"
  description = "Network security group name"
}

variable "source_address_prefix" {
  type        = list(string)
  default     = ["*"]
  description = "Source address prefix to be applied to all predefined rules. list(string) only allowed one element (CIDR, `*`, source IP range or Tags). Example [\"10.0.3.0/24\"] or [\"VirtualNetwork\"]"
}

variable "source_address_prefixes" {
  type        = list(string)
  default     = null
  description = "Destination address prefix to be applied to all predefined rules. Example [\"10.0.3.0/32\",\"10.0.3.128/32\"]"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags to associate with your network security group."
}

variable "use_for_each" {
  type        = bool
  default     = false
  description = "Choose wheter to use 'for_each' as iteration technic to generate the rules, defaults to false so we will use 'count' for compatibilty with previous module versions, but prefered method is 'for_each'"
  nullable    = false
}

variable "subnet_config" {
  type = list(object({
    name = string
    subnet_name = string
    vnet_name = string
    subnet_type = string
    subnet_postfix = string
  }))
  description = "List of subnets to create NSGs for, one to one mapping with the subnets in the vnet"
}

variable "rules_by_subnet" {
  type        = list(object({
    tier_name = string
    subnet_name = string
    predefined_rules = list(object({
      name = string
      priority = number
      source_port_range = string
    }))
    custom_rules = list(object({
      name = string
      priority = number
      direction = string
      access = string
      protocol = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = optional(string)
      destination_address_prefix = optional(string)
      source_app_layer_name = optional(string)
      destination_app_layer_name = optional(string)
      description = string
    }))
  }))
  description = "Resource group name"
}

variable "app_layers" {
  type = list(object({
    app_nsg_name = string
    layer_name = string
  }))
}