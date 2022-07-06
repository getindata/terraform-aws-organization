output "arn" {
  description = "ARN of this OU"
  value       = resource.aws_organizations_organizational_unit.this_orgranizations_organizational_unit.arn
}

output "id" {
  description = "ID of this OU"
  value       = resource.aws_organizations_organizational_unit.this_orgranizations_organizational_unit.id
}

output "accounts" {
  description = "List of OU child accounts"
  value       = resource.aws_organizations_organizational_unit.this_orgranizations_organizational_unit.accounts
}
