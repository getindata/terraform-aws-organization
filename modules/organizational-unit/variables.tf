variable "parent_id" {
  description = "ID of the parent organizational unit or root"
  type        = string
}

variable "accounts" {
  description = "List of AWS accounts to be created inside of that OU"
  type        = any
  default     = {}
}

variable "attached_policies" {
  description = "List of organization policy IDs to be attached to that OU"
  type        = list(string)
  default     = []
}

variable "policy_dictionary" {
  description = "Map of policy names, IDs and ARNs, used to determine policy_id passed to accounts module"
  type        = map(any)
  default     = {}
}
