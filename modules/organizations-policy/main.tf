/**
 * # AWS Organization Policy terraform module
 *
 * This module creates and manages AWS Organization Policies.
 *
 * It also provides functionality to attach policy a to list 
 * of targets (The unique identifier (ID) of the root, 
 * organizational unit, or account number).
 */

resource "aws_organizations_policy" "this_organizations_policy" {
  name        = can(module.this.descriptors["organizations_policy"]) ? module.this.descriptors["organizations_policy"] : module.this.id
  description = var.description
  type        = var.type
  tags        = module.this.tags

  content = var.policy_content
}

resource "aws_organizations_policy_attachment" "this_organizations_policy_attachment" {
  for_each = toset(var.policy_targets)

  policy_id = resource.aws_organizations_policy.this_organizations_policy.id
  target_id = each.key
}
