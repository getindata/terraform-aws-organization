variable "description" {
  description = "Description of the policy"
  type        = string
  default     = null
}

variable "type" {
  description = "The type of policy to create"
  type        = string
  default     = "SERVICE_CONTROL_POLICY"
  validation {
    condition     = contains(["AISERVICES_OPT_OUT_POLICY", "BACKUP_POLICY", "SERVICE_CONTROL_POLICY", "TAG_POLICY"], var.type)
    error_message = "Valid values for type are: AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), TAG_POLICY."
  }
}

variable "policy_content" {
  description = "The actual policy content to be added"
  type        = any
}

variable "policy_targets" {
  description = "A list of target root, organizational unit, or account numbers to attach the policy to"
  type        = list(string)
  default     = []
}
