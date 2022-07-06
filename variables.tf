variable "aws_service_access_principals" {
  description = "List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com"
  type        = list(string)
  default     = null
}

variable "enabled_policy_types" {
  description = " List of Organizations policy types to enable in your organization. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY, TAG_POLICY"
  type        = list(string)
  default     = null
}


variable "root_accounts" {
  description = "AWS accounts not assigned to any O (partent_id = organization root)"
  type        = any
  default     = {}
}

variable "organizational_units" {
  description = "Flat List of Organizational Units with assigned accounts"
  type        = any
  default     = {}
}

variable "policies" {
  description = <<-EOT
    Organizational policy specification, it should be a map of values:
    `{
      name = string
      policy_content = string

      # Optional parameters
      description = string
      type = string
    }`,
    values `name` (policy name) and `policy_content` (JSON policy specification) are mandatory
    `description` (description of policy), `type` (organizations policy type - one of "AISERVICES_OPT_OUT_POLICY", "BACKUP_POLICY", "SERVICE_CONTROL_POLICY", "TAG_POLICY")
    EOT
  type        = map(any)
  default     = {}
}

variable "root_policies" {
  description = "A list of policies that should be attached to organizations root"
  type        = set(string)
  default     = []
}
