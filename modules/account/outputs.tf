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
