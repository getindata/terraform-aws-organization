output "id" {
  description = "Identifier of the organizations policy"
  value       = resource.aws_organizations_policy.this_organizations_policy.id
}

output "arn" {
  description = "ARN of the organizations policy"
  value       = resource.aws_organizations_policy.this_organizations_policy.arn
}
