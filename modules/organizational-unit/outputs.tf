output "arn" {
  description = "ARN of this OU"
  value       = resource.aws_organizations_organizational_unit.this_organizations_organizational_unit.arn
}

output "id" {
  description = "ID of this OU"
  value       = resource.aws_organizations_organizational_unit.this_organizations_organizational_unit.id
}

output "accounts" {
  description = "Map of OU child accounts"
  value       = module.this_organizations_organizational_unit_account
}
