/**
 * # AWS Organizations terraform module
 *
 * This module is able to create and manage AWS organization, accounts,
 * units and policies
 *
 * Module itself creates an AWS organization and manages additional resources
 * using submodules, placed in `./modules` directory
 *
 */

resource "aws_organizations_organization" "this_organizations_organization" {
  feature_set = "ALL"

  # List of AWS service principal names for which you want to enable integration with your organization
  aws_service_access_principals = var.aws_service_access_principals

  enabled_policy_types = var.enabled_policy_types
}

module "this_policies" {
  for_each = var.policies

  source  = "./modules/organizations-policy"
  context = module.this.context

  # Compulsory parameters
  name           = lookup(each.value, "name", each.key)
  policy_content = each.value.policy_content

  # Optional parameters
  description = lookup(each.value, "description", null)
  type        = lookup(each.value, "type", "SERVICE_CONTROL_POLICY")
}

resource "aws_organizations_policy_attachment" "this_root_policies" {
  for_each = var.root_policies

  policy_id = module.this_policies[each.key].id
  target_id = resource.aws_organizations_organization.this_organizations_organization.roots[0].id

  depends_on = [
    module.this_policies
  ]
}

# Create AWS account assigned to root
module "this_root_accounts" {
  for_each = var.root_accounts

  source  = "./modules/account"
  context = module.this.context

  # Compulsory parameters
  email     = each.value.email
  name      = lookup(each.value, "name", each.key)
  parent_id = resource.aws_organizations_organization.this_organizations_organization.roots[0].id

  # Optional parameters
  role_name                  = lookup(each.value, "role_name", "organization-admin")
  close_on_deletion          = lookup(each.value, "close_on_deletion", true)
  iam_user_access_to_billing = lookup(each.value, "iam_user_access_to_billing", "ALLOW")
  attached_policies          = can(each.value["attached_policies"]) ? flatten([for p in each.value.attached_policies : [for k, v in module.this_policies : v.id if k == p]]) : []

  depends_on = [
    aws_organizations_organization.this_organizations_organization,
    module.this_policies
  ]
}

# Create AWS Organizational Units and child AWS accounts
module "this_organizational_units" {
  for_each = var.organizational_units

  source  = "./modules/organizational-unit"
  context = module.this.context

  # Compulsory parameters
  name      = lookup(each.value, "name", each.key)
  parent_id = resource.aws_organizations_organization.this_organizations_organization.roots[0].id

  # Optional parameters
  accounts          = lookup(each.value, "accounts", {})
  attached_policies = can(each.value["attached_policies"]) ? flatten([for p in each.value.attached_policies : [for k, v in module.this_policies : v.id if k == p]]) : []
  policy_dictionary = module.this_policies

  depends_on = [
    aws_organizations_organization.this_organizations_organization,
    module.this_policies
  ]
}
