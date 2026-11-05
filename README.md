# terraform-github-repository
## About

A [Terraform][1] module for creating a public or private repository on [GitHub][2].


## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

```text
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction.

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

Source: https://opensource.org/licenses/MIT
```
See [LICENSE](LICENSE) for full details.
## Authors

- Rafał Masiarek | [website](https://masiarek.pl) | [email](mailto:rafal@masiarek.pl) | [github](https://github.com/rafalmasiarek)


<!-- BEGIN_TF_DOCS -->
## Documentation


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.13.0, < 7.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [github_actions_environment_secret.environment_secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.environment_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_secret.repository_secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.repository_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_app_installation_repository.app_installation_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/app_installation_repository) | resource |
| [github_branch.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.default](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_branch_protection_v3.branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection_v3) | resource |
| [github_issue_label.label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.repository_autolink_reference](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_collaborator.collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_dependabot_security_updates.dependabot_security_updates](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates) | resource |
| [github_repository_deploy_key.deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_deploy_key.deploy_key_computed](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_environment.environment](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_environment_deployment_policy.deployment_policy](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) | resource |
| [github_repository_ruleset.ruleset](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |
| [github_repository_webhook.repository_webhook](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook) | resource |
| [github_team_repository.team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.team_repository_by_slug](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_variables"></a> [actions\_variables](#input\_actions\_variables) | Configure GitHub Actions variables for the repository. | `map(string)` | `{}` | no |
| <a name="input_admin_collaborators"></a> [admin\_collaborators](#input\_admin\_collaborators) | A list of users to add as collaborators granting them admin permission. | `list(string)` | `[]` | no |
| <a name="input_admin_team_ids"></a> [admin\_team\_ids](#input\_admin\_team\_ids) | A list of teams by id to grant admin permission to. | `list(string)` | `[]` | no |
| <a name="input_admin_teams"></a> [admin\_teams](#input\_admin\_teams) | A list of teams by name or slug to grant admin permission to. | `list(string)` | `[]` | no |
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Allow auto-merging pull requests on the repository. | `bool` | `null` | no |
| <a name="input_allow_forking"></a> [allow\_forking](#input\_allow\_forking) | Allow forking of this repository. | `bool` | `null` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | Allow merge commits on the repository. | `bool` | `null` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | Enable rebase merges on the repository. | `bool` | `null` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | Enable squash merges on the repository. | `bool` | `null` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | Always suggest updating pull request branches. | `bool` | `null` | no |
| <a name="input_app_installations"></a> [app\_installations](#input\_app\_installations) | A list of GitHub App IDs to be installed in this repository. | `set(string)` | `[]` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Set to false to not archive the repository instead of deleting on destroy. | `bool` | `true` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | Specifies if the repository should be archived. | `bool` | `false` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | Produce an initial commit in the repository. | `bool` | `null` | no |
| <a name="input_autolink_references"></a> [autolink\_references](#input\_autolink\_references) | Configure autolink references. | <pre>list(object({<br>    key_prefix          = string<br>    target_url_template = string<br>    is_alphanumeric     = optional(bool, true)<br>  }))</pre> | `[]` | no |
| <a name="input_branch_protections_v3"></a> [branch\_protections\_v3](#input\_branch\_protections\_v3) | A list of branch protections to apply to the repository. | `any` | `[]` | no |
| <a name="input_branch_protections_v4"></a> [branch\_protections\_v4](#input\_branch\_protections\_v4) | A list of v4 branch protections to apply to the repository. | `any` | `[]` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | A list of branches to be created in this repository. | `any` | `[]` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The name of the default branch of the repository. | `string` | `null` | no |
| <a name="input_defaults"></a> [defaults](#input\_defaults) | DEPRECATED. Please convert defaults to Terraform Module for\_each. | `any` | `{}` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | Delete the merged branch after merging a pull request. | `bool` | `null` | no |
| <a name="input_dependabot_security_updates_enabled"></a> [dependabot\_security\_updates\_enabled](#input\_dependabot\_security\_updates\_enabled) | Enable or disable Dependabot automated security fixes (pull requests) for the repository. Leave null to not manage this setting. | `bool` | `null` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | Configure deploy keys attached directly to the repository. | `any` | `[]` | no |
| <a name="input_deploy_keys_computed"></a> [deploy\_keys\_computed](#input\_deploy\_keys\_computed) | Configure computed deploy keys attached directly to the repository. | `any` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the repository. | `string` | `""` | no |
| <a name="input_encrypted_secrets"></a> [encrypted\_secrets](#input\_encrypted\_secrets) | Configure encrypted GitHub Actions secrets. | `map(string)` | `{}` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | Configure GitHub repository environments, used for deployment protection rules, keyed by environment name. | <pre>map(object({<br>    wait_timer          = optional(number)<br>    can_admins_bypass   = optional(bool, true)<br>    prevent_self_review = optional(bool, false)<br><br>    reviewers = optional(object({<br>      teams = optional(list(string), [])<br>      users = optional(list(string), [])<br>    }))<br><br>    deployment_branch_policy = optional(object({<br>      protected_branches     = bool<br>      custom_branch_policies = bool<br>    }))<br><br>    deployment_branch_policies = optional(list(object({<br>      branch_pattern = optional(string)<br>      tag_pattern    = optional(string)<br>    })), [])<br><br>    plaintext_secrets = optional(map(string), {})<br>    encrypted_secrets = optional(map(string), {})<br>    variables         = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_extra_topics"></a> [extra\_topics](#input\_extra\_topics) | The list of additional topics of the repository. | `list(string)` | `[]` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | Use the name of the template without the extension. For example, Haskell. | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Enable GitHub Discussions for the repository. | `bool` | `null` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Enable GitHub Issues for the repository. | `bool` | `null` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Enable GitHub Projects for the repository. | `bool` | `null` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Enable GitHub Wiki for the repository. | `bool` | `null` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | The website of the repository. | `string` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Tell GitHub that this is a template repository. | `bool` | `null` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | Configure GitHub issue labels. | <pre>list(object({<br>    name        = string<br>    description = string<br>    color       = string<br>  }))</pre> | `[]` | no |
| <a name="input_issue_labels_create"></a> [issue\_labels\_create](#input\_issue\_labels\_create) | Specify whether you want to force or suppress creation of issue labels. | `bool` | `null` | no |
| <a name="input_issue_labels_merge_with_github_labels"></a> [issue\_labels\_merge\_with\_github\_labels](#input\_issue\_labels\_merge\_with\_github\_labels) | Specify if you want to merge and control GitHub default issue labels. | `bool` | `null` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | Use the name of the license template without the extension. For example, mit or mpl-2.0. | `string` | `null` | no |
| <a name="input_maintain_collaborators"></a> [maintain\_collaborators](#input\_maintain\_collaborators) | A list of users to add as collaborators granting them maintain permission. | `list(string)` | `[]` | no |
| <a name="input_maintain_team_ids"></a> [maintain\_team\_ids](#input\_maintain\_team\_ids) | A list of teams by id to grant maintain permission to. | `list(string)` | `[]` | no |
| <a name="input_maintain_teams"></a> [maintain\_teams](#input\_maintain\_teams) | A list of teams by name or slug to grant maintain permission to. | `list(string)` | `[]` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | Can be PR\_BODY, PR\_TITLE, or BLANK. | `string` | `null` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | Can be PR\_TITLE or MERGE\_MESSAGE. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_pages"></a> [pages](#input\_pages) | The repository GitHub Pages configuration. | `any` | `null` | no |
| <a name="input_plaintext_secrets"></a> [plaintext\_secrets](#input\_plaintext\_secrets) | Configure plaintext GitHub Actions secrets. | `map(string)` | `{}` | no |
| <a name="input_private"></a> [private](#input\_private) | DEPRECATED: use visibility. | `bool` | `null` | no |
| <a name="input_pull_collaborators"></a> [pull\_collaborators](#input\_pull\_collaborators) | A list of users to add as collaborators granting them pull permission. | `list(string)` | `[]` | no |
| <a name="input_pull_team_ids"></a> [pull\_team\_ids](#input\_pull\_team\_ids) | A list of teams by id to grant pull permission to. | `list(string)` | `[]` | no |
| <a name="input_pull_teams"></a> [pull\_teams](#input\_pull\_teams) | A list of teams by name or slug to grant pull permission to. | `list(string)` | `[]` | no |
| <a name="input_push_collaborators"></a> [push\_collaborators](#input\_push\_collaborators) | A list of users to add as collaborators granting them push permission. | `list(string)` | `[]` | no |
| <a name="input_push_team_ids"></a> [push\_team\_ids](#input\_push\_team\_ids) | A list of teams by id to grant push permission to. | `list(string)` | `[]` | no |
| <a name="input_push_teams"></a> [push\_teams](#input\_push\_teams) | A list of teams by name or slug to grant push permission to. | `list(string)` | `[]` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | A list of repository rulesets to apply to the repository. | `any` | `[]` | no |
| <a name="input_security_and_analysis"></a> [security\_and\_analysis](#input\_security\_and\_analysis) | Configure GitHub Advanced Security and secret scanning features for the repository. Leave null to not manage this setting. | <pre>object({<br>    advanced_security               = optional(object({ status = string }))<br>    secret_scanning                 = optional(object({ status = string }))<br>    secret_scanning_push_protection = optional(object({ status = string }))<br>  })</pre> | `null` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | Can be PR\_BODY, COMMIT\_MESSAGES, or BLANK. | `string` | `null` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | Can be PR\_TITLE or COMMIT\_OR\_PR\_TITLE. | `string` | `null` | no |
| <a name="input_template"></a> [template](#input\_template) | Template repository to use. | <pre>object({<br>    owner      = string<br>    repository = string<br>  })</pre> | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | The list of topics of the repository. | `list(string)` | `null` | no |
| <a name="input_triage_collaborators"></a> [triage\_collaborators](#input\_triage\_collaborators) | A list of users to add as collaborators granting them triage permission. | `list(string)` | `[]` | no |
| <a name="input_triage_team_ids"></a> [triage\_team\_ids](#input\_triage\_team\_ids) | A list of teams by id to grant triage permission to. | `list(string)` | `[]` | no |
| <a name="input_triage_teams"></a> [triage\_teams](#input\_triage\_teams) | A list of teams by name or slug to grant triage permission to. | `list(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Can be public, private or internal (GHE only). The visibility parameter overrides the private parameter. Defaults to private if neither private nor visibility are set. | `string` | `null` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Set to false to disable security alerts for vulnerable dependencies. | `bool` | `null` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | Require contributors to sign off on web-based commits. | `bool` | `null` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | Configure repository webhooks. | `any` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions_variables"></a> [actions\_variables](#output\_actions\_variables) | List of repository-level Actions variable names. |
| <a name="output_app_installations"></a> [app\_installations](#output\_app\_installations) | A map of deploy app installations keyed by installation id. |
| <a name="output_branches"></a> [branches](#output\_branches) | A map of branch objects keyed by branch name. |
| <a name="output_collaborators"></a> [collaborators](#output\_collaborators) | A map of collaborator objects keyed by collaborator.name. |
| <a name="output_deploy_keys"></a> [deploy\_keys](#output\_deploy\_keys) | A map of deploy keys keyed by input id. |
| <a name="output_environments"></a> [environments](#output\_environments) | A map of environment names keyed by environment name. |
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | A string of the form 'orgname/reponame'. |
| <a name="output_git_clone_url"></a> [git\_clone\_url](#output\_git\_clone\_url) | URL that can be provided to git clone to clone the repository anonymously via the git protocol. |
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | URL to the repository on the web. |
| <a name="output_http_clone_url"></a> [http\_clone\_url](#output\_http\_clone\_url) | URL that can be provided to git clone to clone the repository via HTTPS. |
| <a name="output_issue_labels"></a> [issue\_labels](#output\_issue\_labels) | A map of issue labels keyed by label input id or name. |
| <a name="output_repository"></a> [repository](#output\_repository) | All attributes and arguments as returned by the github\_repository resource. |
| <a name="output_ruleset_ids"></a> [ruleset\_ids](#output\_ruleset\_ids) | A map of repository ruleset IDs keyed by the ruleset key. |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | List of secrets available. |
| <a name="output_ssh_clone_url"></a> [ssh\_clone\_url](#output\_ssh\_clone\_url) | URL that can be provided to git clone to clone the repository via SSH. |
| <a name="output_webhooks"></a> [webhooks](#output\_webhooks) | All attributes and arguments as returned by the github\_repository\_webhook resource. |

### Examples

```hcl
module "example_repository" {
  source = "../../"

  name        = "example-basic-repo"
  description = "Very basic example repository managed by Terraform."
  visibility  = "public"
  topics      = ["example", "terraform", "github"]
  has_issues  = true
  has_wiki    = false
  archived    = false
}
```

<!-- END_TF_DOCS -->


<!-- references -->

[repo_link]: https://github.com/rafalmasiarek/terraform-github-repository
[1]: https://www.terraform.io/
[2]: https://github.com/
[3]: https://github.com/github/gitignore
[4]: https://github.com/github/choosealicense.com/tree/gh-pages/_licenses
[5]: https://www.terraform.io/docs/providers/github/r/repository_webhook.html
[6]: https://www.terraform.io/docs/providers/github/r/actions_secret
[7]: https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference
[8]: https://github.com/hashicorp/terraform/issues/19898
[9]: https://github.com/hashicorp/terraform/issues/22449

