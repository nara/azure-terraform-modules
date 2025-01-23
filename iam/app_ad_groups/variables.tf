variable "group_prefix" {
  description = "Prefix for the group name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
  default     = {}
}