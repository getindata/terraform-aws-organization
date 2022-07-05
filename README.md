# Terraform AWS Organization

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

![License](https://badgen.net/github/license/getindata/terraform-aws-organization/)
![Release](https://badgen.net/github/release/getindata/terraform-aws-organization/)

<p align="center">
  <img height="150" src="https://getindata.com/img/logo.svg">
  <h3 align="center">We help companies turn their data into assets</h3>
</p>

---

This module is able to create and manage AWS organization, accounts, units and policies.

Module itself creates an AWS organization and manages additional resources using submodules, placed in `./modules` directory

> **NOTE:**
>  This module supports only flat organization structure (single level of Organizational Units)

## USAGE

```terraform
module "aws_organization" {
  source  = "github.com/getindata/terraform-aws-organization"
  context = module.this.context

  organizational_units = {
    test-ou = {
      name = "test-ou"
      accounts = {
        test = {
          email = "test@example.com"
        },
      }
    }
  }
}
```

### Import existing AWS resources

You can import existing AWS resources into terraform state without the need of recreating/destroying the resources. 

* Import existing AWS organization to the state:

  ```shell
  $ terraform import "module.aws_organization.aws_organizations_organization.this_organizations_organization" o-1234567
  ```
  where `o-1234567` is the AWS Organization ID

* Import existing AWS Organization OU (Organizational Unit)

  ```shell
  $ terraform import "module.aws_organization.module.this_organizational_units[\"test-ou\"].aws_organizations_organizational_unit.this_orgranizations_organizational_unit" ou-abcd-1234567
  ```
  where `ou-abcd-1234567` is the AWS Organization OU ID

* Import existing AWS Account that was created in the current AWS Organization

  ```shell
  $ terraform import "module.aws_organization.module.this_organizational_units[\"test-ou\"].module.this_orgranizations_organizational_unit_account[\"test\"].aws_organizations_account.this_organizations_account" 123456789098
  ```
  where `123456789098` is the AWS Account ID

## NOTES

_Additional information that should be made public, for ex. how to solve known issues, additional descriptions/suggestions_

<!-- BEGIN_TF_DOCS -->
## EXAMPLES
```hcl
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
```

# AWS Organizations terraform module

This module is able to create and manage AWS organization, accounts,
units and policies

Module itself creates an AWS organization and manages additional resources
using submodules, placed in `./modules` directory



## Inputs

| Name                                                                                                                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Type           | Default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Required |
| ------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map)                                    | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration.                                                                                                                                                                                                                                                                                                                                                                                   | `map(string)`  | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_attributes"></a> [attributes](#input\_attributes)                                                                | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element.                                                                                                                                                                                                                                                                                                                                                                                        | `list(string)` | `[]`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_aws_service_access_principals"></a> [aws\_service\_access\_principals](#input\_aws\_service\_access\_principals) | List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `list(string)` | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_context"></a> [context](#input\_context)                                                                         | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged.                                                                                                                                                                                                                                                                                                                          | `any`          | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> |    no    |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter)                                                                   | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats)                                      | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any`          | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_enabled"></a> [enabled](#input\_enabled)                                                                         | Set to false to prevent the module from creating any resources                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `bool`         | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_enabled_policy_types"></a> [enabled\_policy\_types](#input\_enabled\_policy\_types)                              | List of Organizations policy types to enable in your organization. Valid values are AISERVICES\_OPT\_OUT\_POLICY, BACKUP\_POLICY, SERVICE\_CONTROL\_POLICY, TAG\_POLICY                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `list(string)` | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_environment"></a> [environment](#input\_environment)                                                             | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit)                                             | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `number`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case)                                                | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`.                                                                                                                                                                                                                                                                                                                                                                                                                               | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order)                                                           | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present.                                                                                                                                                                                                                                                                                                                                                                                                                             | `list(string)` | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case)                                          | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`.                                                                                                                                                                                                                                                                          | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags)                                                | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored.                                                                                                                                                         | `set(string)`  | <pre>[<br>  "default"<br>]</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                       |    no    |
| <a name="input_name"></a> [name](#input\_name)                                                                                  | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input.                                                                                                                                                                                                                                                                                                                                                                                                                      | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_namespace"></a> [namespace](#input\_namespace)                                                                   | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units)                                | Flat List of Organizational Units with assigned accounts                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `any`          | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_policies"></a> [policies](#input\_policies)                                                                      | Organizational policy specification, it should be a map of values:<br>`{<br>  name = string<br>  policy_content = string<br><br>  # Optional parameters<br>  description = string<br>  type = string<br>}`,<br>values `name` (policy name) and `policy_content` (JSON policy specification) are mandatory<br>`description` (description of policy), `type` (organizations policy type - one of "AISERVICES\_OPT\_OUT\_POLICY", "BACKUP\_POLICY", "SERVICE\_CONTROL\_POLICY", "TAG\_POLICY")                                                                                                                                                                          | `map(any)`     | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars)                                 | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits.                                                                                                                                                                                                                                                                                                                                                                                                                                      | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_root_accounts"></a> [root\_accounts](#input\_root\_accounts)                                                     | AWS accounts not assigned to any O (partent\_id = organization root)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `any`          | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_root_policies"></a> [root\_policies](#input\_root\_policies)                                                     | A list of policies that should be attached to organizations root                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `set(string)`  | `[]`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_stage"></a> [stage](#input\_stage)                                                                               | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                  | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `map(string)`  | `{}`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |
| <a name="input_tenant"></a> [tenant](#input\_tenant)                                                                            | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `string`       | `null`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |

## Modules

| Name                                                                                                                | Source                         | Version |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------ | ------- |
| <a name="module_this"></a> [this](#module\_this)                                                                    | cloudposse/label/null          | 0.25.0  |
| <a name="module_this_organizational_units"></a> [this\_organizational\_units](#module\_this\_organizational\_units) | ./modules/organizational-unit  | n/a     |
| <a name="module_this_policies"></a> [this\_policies](#module\_this\_policies)                                       | ./modules/organizations-policy | n/a     |
| <a name="module_this_root_accounts"></a> [this\_root\_accounts](#module\_this\_root\_accounts)                      | ./modules/account              | n/a     |

## Outputs

| Name                                                                                               | Description                                                |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| <a name="output_accounts"></a> [accounts](#output\_accounts)                                       | List of organization accounts including the master account |
| <a name="output_arn"></a> [arn](#output\_arn)                                                      | ARN of the organization                                    |
| <a name="output_id"></a> [id](#output\_id)                                                         | Identifier of the organization                             |
| <a name="output_master_account_arn"></a> [master\_account\_arn](#output\_master\_account\_arn)     | ARN of the master account                                  |
| <a name="output_organizational_units"></a> [organizational\_units](#output\_organizational\_units) | Details of Organizational Units                            |
| <a name="output_policies"></a> [policies](#output\_policies)                                       | Details of Policies                                        |
| <a name="output_roots"></a> [roots](#output\_roots)                                                | List of organization roots                                 |

## Providers

| Name                                              | Version |
| ------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.34 |

## Requirements

| Name                                                                      | Version   |
| ------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 3.34   |

## Resources

| Name                                                                                                                                                                     | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_organizations_organization.this_organizations_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_policy_attachment.this_root_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment)    | resource |
<!-- END_TF_DOCS -->

## CONTRIBUTING

Contributions are very welcomed!

Start by reviewing [contribution guide](CONTRIBUTING.md) and our [code of conduct](CODE_OF_CONDUCT.md). After that, start coding and ship your changes by creating a new PR.

## LICENSE

Apache 2 Licensed. See [LICENSE](LICENSE) for full details.

## AUTHORS

<!--- Replace repository name -->
<a href="https://github.com/getindata/terraform-aws-organization/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=getindata/terraform-aws-organization" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
