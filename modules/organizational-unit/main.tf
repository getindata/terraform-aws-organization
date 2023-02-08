/**
 * # AWS Organizational Unit terraform module
 *
 * This module creates AWS Organization OUs and uses AWS Accounts module to
 * create accounts inside of that OU.
 *
 * It also provides functionality to attach a list of organizational policies to the OU.
 */


resource "aws_organizations_organizational_unit" "this_organizations_organizational_unit" {
  name      = can(module.this.descriptors["organizations_organzational_unit"]) ? module.this.descriptors["organizations_organzational_unit"] : module.this.id
  parent_id = var.parent_id

  tags = module.this.tags
}

# Attach policies to the OU if policy list is defined
resource "aws_organizations_policy_attachment" "this_organizations_policy_attachment" {
  count = length(var.attached_policies)

  policy_id = var.attached_policies[count.index]
  target_id = aws_organizations_organizational_unit.this_organizations_organizational_unit.id
}

# if list of accounts is added to OU - create them inside that OU
module "this_organizations_organizational_unit_account" {
  for_each = local.accounts

  source  = "../account"
  context = module.this.context

  # Compulsory parameters
  email     = each.value.email
  name      = lookup(each.value, "name", each.key)
  parent_id = aws_organizations_organizational_unit.this_organizations_organizational_unit.id

  # Optional parameters
  role_name                  = lookup(each.value, "role_name", "organization-admin")
  close_on_deletion          = lookup(each.value, "close_on_deletion", true)
  iam_user_access_to_billing = lookup(each.value, "iam_user_access_to_billing", "ALLOW")
  attached_policies          = can(each.value["attached_policies"]) ? flatten([for p in each.value.attached_policies : [for k, v in var.policy_dictionary : v.id if k == p]]) : []
}
