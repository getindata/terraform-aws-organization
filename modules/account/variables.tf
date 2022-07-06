variable "email" {
  description = "The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  type        = string
}

variable "iam_user_access_to_billing" {
  description = "If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information."
  type        = string
  default     = "ALLOW"
}

variable "parent_id" {
  description = "Parent Organizational Unit ID or Root ID for the account"
  type        = string
  default     = null
}

variable "close_on_deletion" {
  description = "If true, a deletion event will close the account. Otherwise, it will only remove from the organization."
  type        = bool
  default     = true
}

variable "role_name" {
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account."
  type        = string
  default     = "organization-admin"
}

variable "attached_policies" {
  description = "List of organization policy IDs to be attached to that account"
  type        = list(string)
  default     = []
}
