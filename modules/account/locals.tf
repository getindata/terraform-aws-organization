locals {
  account_name = can(module.this.descriptors["organizations_account"]) ? module.this.descriptors["organizations_account"] : module.this.id

  role_name = resource.aws_organizations_account.this_organizations_account.role_name != null ? resource.aws_organizations_account.this_organizations_account.role_name : "OrganizationAccountAccessRole"
  role_arn  = "arn:aws:iam::${resource.aws_organizations_account.this_organizations_account.id}:role/${local.role_name}"
}
