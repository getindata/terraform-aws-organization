output "arn" {
  description = "ARN of this AWS account"
  value       = resource.aws_organizations_account.this_organizations_account.arn
}

output "id" {
  description = "ID of this AWS account"
  value       = resource.aws_organizations_account.this_organizations_account.id
}

output "name" {
  description = "Name of this AWS account"
  value       = resource.aws_organizations_account.this_organizations_account.name
}

output "email" {
  description = "e-mail associated with this AWS account"
  value       = resource.aws_organizations_account.this_organizations_account.email
}

output "role_arn" {
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the root account, allowing users in the root account to assume the role, as permitted by the root account administrator. The role has administrator permissions in the new member account."
  value       = local.role_arn
}
