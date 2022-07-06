module "aws_organization" {
  source  = "../../"
  context = module.this.context

  aws_service_access_principals = ["sso.amazonaws.com"]

  policies = {
    test-policy = {
      description    = "testing"
      policy_content = file("policies/test-policy.json")
    },
  }

  root_policies = ["test-policy"]

  root_accounts = {
    test-root = {
      email = "test-root@example.com"
    },
  }

  organizational_units = {
    test-ou = {
      name              = "test-ou"
      attached_policies = ["test-policy"]
      accounts = {
        test = {
          email = "test@example.com"
        },
        test2 = {
          email                      = "test2@example.com"
          name                       = "test"
          role_name                  = "test"
          close_on_deletion          = false
          iam_user_access_to_billing = "ALLOW"
        }
      }
    }
    prod-ou = {
      attached_policies = ["test-policy"]
      accounts = {
        ABC = {
          email = "abc@example.com"
        }
      }
    }
  }
}
