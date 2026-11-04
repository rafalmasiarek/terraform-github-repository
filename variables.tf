variable "name" {
  description = "The name of the repository."
  type        = string
}

variable "branches" {
  description = "A list of branches to be created in this repository."
  type        = any
  default     = []
}

variable "defaults" {
  description = "DEPRECATED. Please convert defaults to Terraform Module for_each."
  type        = any
  default     = {}
}

variable "description" {
  description = "A description of the repository."
  type        = string
  default     = ""
}

variable "homepage_url" {
  description = "The website of the repository."
  type        = string
  default     = null
}

variable "private" {
  description = "DEPRECATED: use visibility."
  type        = bool
  default     = null
}

variable "visibility" {
  description = "Can be public, private or internal (GHE only). The visibility parameter overrides the private parameter. Defaults to private if neither private nor visibility are set."
  type        = string
  default     = null
}

variable "has_issues" {
  description = "Enable GitHub Issues for the repository."
  type        = bool
  default     = null
}

variable "has_projects" {
  description = "Enable GitHub Projects for the repository."
  type        = bool
  default     = null
}

variable "has_wiki" {
  description = "Enable GitHub Wiki for the repository."
  type        = bool
  default     = null
}

variable "has_discussions" {
  description = "Enable GitHub Discussions for the repository."
  type        = bool
  default     = null
}

variable "allow_merge_commit" {
  description = "Allow merge commits on the repository."
  type        = bool
  default     = null
}

variable "allow_squash_merge" {
  description = "Enable squash merges on the repository."
  type        = bool
  default     = null
}

variable "allow_rebase_merge" {
  description = "Enable rebase merges on the repository."
  type        = bool
  default     = null
}

variable "allow_auto_merge" {
  description = "Allow auto-merging pull requests on the repository."
  type        = bool
  default     = null
}

variable "allow_update_branch" {
  description = "Always suggest updating pull request branches."
  type        = bool
  default     = null
}

variable "allow_forking" {
  description = "Allow forking of this repository."
  type        = bool
  default     = null
}

variable "delete_branch_on_merge" {
  description = "Delete the merged branch after merging a pull request."
  type        = bool
  default     = null
}

variable "auto_init" {
  description = "Produce an initial commit in the repository."
  type        = bool
  default     = null
}

variable "pages" {
  description = "The repository GitHub Pages configuration."
  type        = any
  default     = null
}

variable "gitignore_template" {
  description = "Use the name of the template without the extension. For example, Haskell."
  type        = string
  default     = null
}

variable "is_template" {
  description = "Tell GitHub that this is a template repository."
  type        = bool
  default     = null
}

variable "license_template" {
  description = "Use the name of the license template without the extension. For example, mit or mpl-2.0."
  type        = string
  default     = null
}

variable "default_branch" {
  description = "The name of the default branch of the repository."
  type        = string
  default     = null
}

variable "merge_commit_title" {
  description = "Can be PR_TITLE or MERGE_MESSAGE."
  type        = string
  default     = null
}

variable "merge_commit_message" {
  description = "Can be PR_BODY, PR_TITLE, or BLANK."
  type        = string
  default     = null
}

variable "squash_merge_commit_title" {
  description = "Can be PR_TITLE or COMMIT_OR_PR_TITLE."
  type        = string
  default     = null
}

variable "squash_merge_commit_message" {
  description = "Can be PR_BODY, COMMIT_MESSAGES, or BLANK."
  type        = string
  default     = null
}

variable "web_commit_signoff_required" {
  description = "Require contributors to sign off on web-based commits."
  type        = bool
  default     = null
}

variable "archived" {
  description = "Specifies if the repository should be archived."
  type        = bool
  default     = false
}

variable "topics" {
  description = "The list of topics of the repository."
  type        = list(string)
  default     = null
}

variable "extra_topics" {
  description = "The list of additional topics of the repository."
  type        = list(string)
  default     = []
}

variable "template" {
  description = "Template repository to use."
  type = object({
    owner      = string
    repository = string
  })
  default = null
}

variable "admin_collaborators" {
  description = "A list of users to add as collaborators granting them admin permission."
  type        = list(string)
  default     = []
}

variable "push_collaborators" {
  description = "A list of users to add as collaborators granting them push permission."
  type        = list(string)
  default     = []
}

variable "pull_collaborators" {
  description = "A list of users to add as collaborators granting them pull permission."
  type        = list(string)
  default     = []
}

variable "triage_collaborators" {
  description = "A list of users to add as collaborators granting them triage permission."
  type        = list(string)
  default     = []
}

variable "maintain_collaborators" {
  description = "A list of users to add as collaborators granting them maintain permission."
  type        = list(string)
  default     = []
}

variable "admin_team_ids" {
  description = "A list of teams by id to grant admin permission to."
  type        = list(string)
  default     = []
}

variable "push_team_ids" {
  description = "A list of teams by id to grant push permission to."
  type        = list(string)
  default     = []
}

variable "pull_team_ids" {
  description = "A list of teams by id to grant pull permission to."
  type        = list(string)
  default     = []
}

variable "triage_team_ids" {
  description = "A list of teams by id to grant triage permission to."
  type        = list(string)
  default     = []
}

variable "maintain_team_ids" {
  description = "A list of teams by id to grant maintain permission to."
  type        = list(string)
  default     = []
}

variable "admin_teams" {
  description = "A list of teams by name or slug to grant admin permission to."
  type        = list(string)
  default     = []
}

variable "push_teams" {
  description = "A list of teams by name or slug to grant push permission to."
  type        = list(string)
  default     = []
}

variable "pull_teams" {
  description = "A list of teams by name or slug to grant pull permission to."
  type        = list(string)
  default     = []
}

variable "triage_teams" {
  description = "A list of teams by name or slug to grant triage permission to."
  type        = list(string)
  default     = []
}

variable "maintain_teams" {
  description = "A list of teams by name or slug to grant maintain permission to."
  type        = list(string)
  default     = []
}

variable "branch_protections_v3" {
  description = "A list of branch protections to apply to the repository."
  type        = any
  default     = []
}

variable "branch_protections_v4" {
  description = "A list of v4 branch protections to apply to the repository."
  type        = any
  default     = []

  validation {
    condition = alltrue(
      [
        for cfg in var.branch_protections_v4 : try(
          cfg.required_pull_request_reviews.required_approving_review_count >= 0
          && cfg.required_pull_request_reviews.required_approving_review_count <= 6,
          true
        )
      ]
    )
    error_message = "The value for branch_protections_v4.required_pull_request_reviews.required_approving_review_count must be between 0 and 6, inclusively."
  }
}

variable "rulesets" {
  description = "A list of repository rulesets to apply to the repository."
  type        = any
  default     = []

  validation {
    condition     = alltrue([for r in var.rulesets : try(r.name != "", false)])
    error_message = "Each ruleset must set a non-empty name."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      contains(["branch", "tag", "push"], try(r.target, "branch"))
    ])
    error_message = "Ruleset target must be \"branch\", \"tag\", or \"push\"."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      contains(["disabled", "active", "evaluate"], try(r.enforcement, "active"))
    ])
    error_message = "Ruleset enforcement must be \"disabled\", \"active\", or \"evaluate\"."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      alltrue([
        for actor in try(r.bypass_actors, []) :
        contains(["Integration", "Team", "User", "OrganizationAdmin", "RepositoryRole", "DeployKey"], try(actor.actor_type, ""))
      ])
    ])
    error_message = "Each bypass_actors.actor_type must be Integration, Team, User, OrganizationAdmin, RepositoryRole, or DeployKey."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      try(r.rules.commit_message_pattern == null, true) || (
        contains(["starts_with", "ends_with", "contains", "regex"], r.rules.commit_message_pattern.operator) &&
        length(try(r.rules.commit_message_pattern.pattern, "")) > 0
      )
    ])
    error_message = "rules.commit_message_pattern requires operator \"starts_with\", \"ends_with\", \"contains\", or \"regex\" and a non-empty pattern."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      try(r.rules.branch_name_pattern == null, true) || (
        contains(["starts_with", "ends_with", "contains", "regex"], r.rules.branch_name_pattern.operator) &&
        length(try(r.rules.branch_name_pattern.pattern, "")) > 0
      )
    ])
    error_message = "rules.branch_name_pattern requires operator \"starts_with\", \"ends_with\", \"contains\", or \"regex\" and a non-empty pattern."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      try(r.rules.tag_name_pattern == null, true) || (
        contains(["starts_with", "ends_with", "contains", "regex"], r.rules.tag_name_pattern.operator) &&
        length(try(r.rules.tag_name_pattern.pattern, "")) > 0
      )
    ])
    error_message = "rules.tag_name_pattern requires operator \"starts_with\", \"ends_with\", \"contains\", or \"regex\" and a non-empty pattern."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      try(r.rules.commit_author_email_pattern == null, true) || (
        contains(["starts_with", "ends_with", "contains", "regex"], r.rules.commit_author_email_pattern.operator) &&
        length(try(r.rules.commit_author_email_pattern.pattern, "")) > 0
      )
    ])
    error_message = "rules.commit_author_email_pattern requires operator \"starts_with\", \"ends_with\", \"contains\", or \"regex\" and a non-empty pattern."
  }

  validation {
    condition = alltrue([
      for r in var.rulesets :
      try(r.rules.committer_email_pattern == null, true) || (
        contains(["starts_with", "ends_with", "contains", "regex"], r.rules.committer_email_pattern.operator) &&
        length(try(r.rules.committer_email_pattern.pattern, "")) > 0
      )
    ])
    error_message = "rules.committer_email_pattern requires operator \"starts_with\", \"ends_with\", \"contains\", or \"regex\" and a non-empty pattern."
  }
}

variable "issue_labels_merge_with_github_labels" {
  description = "Specify if you want to merge and control GitHub default issue labels."
  type        = bool
  default     = null
}

variable "issue_labels_create" {
  description = "Specify whether you want to force or suppress creation of issue labels."
  type        = bool
  default     = null
}

variable "issue_labels" {
  description = "Configure GitHub issue labels."
  type = list(object({
    name        = string
    description = string
    color       = string
  }))
  default = []
}

variable "deploy_keys" {
  description = "Configure deploy keys attached directly to the repository."
  type        = any
  default     = []
}

variable "deploy_keys_computed" {
  description = "Configure computed deploy keys attached directly to the repository."
  type        = any
  default     = []
}

variable "webhooks" {
  description = "Configure repository webhooks."
  type        = any
  default     = []
}

variable "plaintext_secrets" {
  description = "Configure plaintext GitHub Actions secrets."
  type        = map(string)
  default     = {}
}

variable "encrypted_secrets" {
  description = "Configure encrypted GitHub Actions secrets."
  type        = map(string)
  default     = {}
}

variable "autolink_references" {
  description = "Configure autolink references."
  type = list(object({
    key_prefix          = string
    target_url_template = string
    is_alphanumeric     = optional(bool, true)
  }))
  default = []
}

variable "vulnerability_alerts" {
  description = "Set to false to disable security alerts for vulnerable dependencies."
  type        = bool
  default     = null
}

variable "archive_on_destroy" {
  description = "Set to false to not archive the repository instead of deleting on destroy."
  type        = bool
  default     = true
}

variable "security_and_analysis" {
  description = "Configure GitHub Advanced Security and secret scanning features for the repository. Leave null to not manage this setting."
  type = object({
    advanced_security                     = optional(object({ status = string }))
    code_security                         = optional(object({ status = string }))
    secret_scanning                       = optional(object({ status = string }))
    secret_scanning_ai_detection          = optional(object({ status = string }))
    secret_scanning_non_provider_patterns = optional(object({ status = string }))
    secret_scanning_push_protection       = optional(object({ status = string }))
  })
  default = null

  validation {
    condition = var.security_and_analysis == null ? true : alltrue([
      for block in [
        try(var.security_and_analysis.advanced_security, null),
        try(var.security_and_analysis.code_security, null),
        try(var.security_and_analysis.secret_scanning, null),
        try(var.security_and_analysis.secret_scanning_ai_detection, null),
        try(var.security_and_analysis.secret_scanning_non_provider_patterns, null),
        try(var.security_and_analysis.secret_scanning_push_protection, null),
      ] : block == null || contains(["enabled", "disabled"], block.status)
    ])
    error_message = "Each security_and_analysis.*.status must be \"enabled\" or \"disabled\"."
  }
}

variable "dependabot_security_updates_enabled" {
  description = "Enable or disable Dependabot automated security fixes (pull requests) for the repository. Leave null to not manage this setting."
  type        = bool
  default     = null
}

variable "actions_variables" {
  description = "Configure GitHub Actions variables for the repository."
  type        = map(string)
  default     = {}
}

variable "environments" {
  description = "Configure GitHub repository environments, used for deployment protection rules, keyed by environment name."
  type = map(object({
    wait_timer          = optional(number)
    can_admins_bypass   = optional(bool, true)
    prevent_self_review = optional(bool, false)

    reviewers = optional(object({
      teams = optional(list(string), [])
      users = optional(list(string), [])
    }))

    deployment_branch_policy = optional(object({
      protected_branches     = bool
      custom_branch_policies = bool
    }))

    deployment_branch_policies = optional(list(object({
      branch_pattern = optional(string)
      tag_pattern    = optional(string)
    })), [])

    plaintext_secrets = optional(map(string), {})
    encrypted_secrets = optional(map(string), {})
    variables         = optional(map(string), {})
  }))
  default = {}
}

variable "app_installations" {
  description = "A list of GitHub App IDs to be installed in this repository."
  type        = set(string)
  default     = []
}
