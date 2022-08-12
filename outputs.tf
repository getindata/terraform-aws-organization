output "id" {
  description = "Identifier of the organization"
  value       = resource.aws_organizations_organization.this_organizations_organization.id
}

output "arn" {
  description = "ARN of the organization"
  value       = resource.aws_organizations_organization.this_organizations_organization.arn
}

output "accounts" {
  description = "List of organization accounts including the master account"
  value       = resource.aws_organizations_organization.this_organizations_organization.accounts
}

output "non_master_accounts" {
  description = "List of organization accounts including the master account"
  value       = resource.aws_organizations_organization.this_organizations_organization.non_master_accounts
}

output "master_account_arn" {
  description = "ARN of the master account"
  value       = resource.aws_organizations_organization.this_organizations_organization.master_account_arn
}

output "roots" {
  description = "List of organization roots"
  value       = resource.aws_organizations_organization.this_organizations_organization.roots
}

output "organizational_units" {
  description = "Details of Organizational Units"
  value       = module.this_organizational_units
}

output "policies" {
  description = "Details of Policies"
  value       = module.this_policies
}

output "root_accounts" {
  description = "Details of AWS Accounts created under organizations root"
  value       = module.this_root_accounts
}
