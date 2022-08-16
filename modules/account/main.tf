/**
 * # AWS Account terraform module
 *
 * This module creates and manages AWS accounts inside AWS Organization.
 *
 * It also provides functionality to attach a list of organizational policies to the account.
 */

resource "aws_organizations_account" "this_organizations_account" {
  name      = local.account_name
  email     = var.email
  parent_id = var.parent_id
  role_name = var.role_name == "" ? null : var.role_name

  iam_user_access_to_billing = var.iam_user_access_to_billing == "" ? null : var.iam_user_access_to_billing
  close_on_deletion          = var.close_on_deletion

  tags = module.this.tags
}

resource "aws_organizations_policy_attachment" "this_organizations_policy_attachment" {
  count = length(var.attached_policies)

  policy_id = var.attached_policies[count.index]
  target_id = aws_organizations_account.this_organizations_account.id
}
