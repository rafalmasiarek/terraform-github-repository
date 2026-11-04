resource "github_repository" "repository" {
  name                        = var.name
  description                 = var.description
  homepage_url                = local.homepage_url
  visibility                  = local.visibility
  has_issues                  = local.has_issues
  has_projects                = local.has_projects
  has_wiki                    = local.has_wiki
  has_discussions             = local.has_discussions
  allow_merge_commit          = local.allow_merge_commit
  allow_rebase_merge          = local.allow_rebase_merge
  allow_squash_merge          = local.allow_squash_merge
  allow_auto_merge            = local.allow_auto_merge
  allow_update_branch         = local.allow_update_branch
  allow_forking               = local.allow_forking
  delete_branch_on_merge      = local.delete_branch_on_merge
  is_template                 = local.is_template
  auto_init                   = local.auto_init
  gitignore_template          = local.gitignore_template
  license_template            = local.license_template
  merge_commit_title          = local.merge_commit_title
  merge_commit_message        = local.merge_commit_message
  squash_merge_commit_title   = local.squash_merge_commit_title
  squash_merge_commit_message = local.squash_merge_commit_message
  web_commit_signoff_required = local.web_commit_signoff_required
  archived                    = var.archived
  topics                      = local.topics

  archive_on_destroy   = var.archive_on_destroy
  vulnerability_alerts = local.vulnerability_alerts

  dynamic "template" {
    for_each = local.template

    content {
      owner      = template.value.owner
      repository = template.value.repository
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.security_and_analysis != null ? [var.security_and_analysis] : []

    content {
      dynamic "advanced_security" {
        for_each = try(security_and_analysis.value.advanced_security, null) != null ? [security_and_analysis.value.advanced_security] : []

        content {
          status = advanced_security.value.status
        }
      }

      dynamic "code_security" {
        for_each = try(security_and_analysis.value.code_security, null) != null ? [security_and_analysis.value.code_security] : []

        content {
          status = code_security.value.status
        }
      }

      dynamic "secret_scanning" {
        for_each = try(security_and_analysis.value.secret_scanning, null) != null ? [security_and_analysis.value.secret_scanning] : []

        content {
          status = secret_scanning.value.status
        }
      }

      dynamic "secret_scanning_ai_detection" {
        for_each = try(security_and_analysis.value.secret_scanning_ai_detection, null) != null ? [security_and_analysis.value.secret_scanning_ai_detection] : []

        content {
          status = secret_scanning_ai_detection.value.status
        }
      }

      dynamic "secret_scanning_non_provider_patterns" {
        for_each = try(security_and_analysis.value.secret_scanning_non_provider_patterns, null) != null ? [security_and_analysis.value.secret_scanning_non_provider_patterns] : []

        content {
          status = secret_scanning_non_provider_patterns.value.status
        }
      }

      dynamic "secret_scanning_push_protection" {
        for_each = try(security_and_analysis.value.secret_scanning_push_protection, null) != null ? [security_and_analysis.value.secret_scanning_push_protection] : []

        content {
          status = secret_scanning_push_protection.value.status
        }
      }
    }
  }

  dynamic "pages" {
    for_each = local.pages != null ? [local.pages] : []

    content {
      build_type = try(pages.value.build_type, "legacy")
      cname      = try(pages.value.cname, null)

      dynamic "source" {
        for_each = try(pages.value.build_type, "legacy") == "legacy" ? [true] : []

        content {
          branch = pages.value.branch
          path   = try(pages.value.path, "/")
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      license_template,
      gitignore_template,
      template,
    ]
  }
}

resource "github_branch" "branch" {
  for_each = local.branches_map

  repository    = github_repository.repository.name
  branch        = each.key
  source_branch = try(each.value.source_branch, null)
  source_sha    = try(each.value.source_sha, null)
}

resource "github_branch_default" "default" {
  count = local.default_branch != null ? 1 : 0

  repository = github_repository.repository.name
  branch     = local.default_branch

  depends_on = [github_branch.branch]
}

resource "github_branch_protection" "branch_protection" {
  for_each = local.branch_protections_v4_map

  depends_on = [
    github_repository_collaborator.collaborator,
    github_team_repository.team_repository,
    github_team_repository.team_repository_by_slug,
    github_branch.branch,
  ]

  repository_id = github_repository.repository.node_id
  pattern       = var.branch_protections_v4[each.value].pattern

  allows_deletions                = try(var.branch_protections_v4[each.value].allows_deletions, false)
  allows_force_pushes             = try(var.branch_protections_v4[each.value].allows_force_pushes, false)
  enforce_admins                  = try(var.branch_protections_v4[each.value].enforce_admins, true)
  require_conversation_resolution = try(var.branch_protections_v4[each.value].require_conversation_resolution, false)
  require_signed_commits          = try(var.branch_protections_v4[each.value].require_signed_commits, false)
  required_linear_history         = try(var.branch_protections_v4[each.value].required_linear_history, false)
  force_push_bypassers            = try(var.branch_protections_v4[each.value].force_push_bypassers, [])
  lock_branch                     = try(var.branch_protections_v4[each.value].lock_branch, false)

  dynamic "restrict_pushes" {
    for_each = try([var.branch_protections_v4[each.value].restrict_pushes], [])

    content {
      blocks_creations = try(restrict_pushes.value.blocks_creations, true)
      push_allowances  = try(restrict_pushes.value.push_allowances, [])
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = try([var.branch_protections_v4[each.value].required_pull_request_reviews], [])

    content {
      dismiss_stale_reviews           = try(required_pull_request_reviews.value.dismiss_stale_reviews, true)
      restrict_dismissals             = try(required_pull_request_reviews.value.restrict_dismissals, null)
      dismissal_restrictions          = try(required_pull_request_reviews.value.dismissal_restrictions, [])
      pull_request_bypassers          = try(required_pull_request_reviews.value.pull_request_bypassers, [])
      require_code_owner_reviews      = try(required_pull_request_reviews.value.require_code_owner_reviews, true)
      required_approving_review_count = try(required_pull_request_reviews.value.required_approving_review_count, 0)
      require_last_push_approval      = try(required_pull_request_reviews.value.require_last_push_approval, false)
    }
  }

  dynamic "required_status_checks" {
    for_each = try([var.branch_protections_v4[each.value].required_status_checks], [])

    content {
      strict   = try(required_status_checks.value.strict, false)
      contexts = try(required_status_checks.value.contexts, [])
    }
  }
}

resource "github_branch_protection_v3" "branch_protection" {
  count = length(local.branch_protections_v3)

  depends_on = [
    github_repository_collaborator.collaborator,
    github_team_repository.team_repository,
    github_team_repository.team_repository_by_slug,
    github_branch.branch,
  ]

  repository                      = github_repository.repository.name
  branch                          = local.branch_protections_v3[count.index].branch
  enforce_admins                  = local.branch_protections_v3[count.index].enforce_admins
  require_conversation_resolution = local.branch_protections_v3[count.index].require_conversation_resolution
  require_signed_commits          = local.branch_protections_v3[count.index].require_signed_commits

  dynamic "required_status_checks" {
    for_each = local.required_status_checks_v3_normalized[count.index]

    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = local.required_pull_request_reviews[count.index]

    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      dismissal_users                 = required_pull_request_reviews.value.dismissal_users
      dismissal_teams                 = [for t in required_pull_request_reviews.value.dismissal_teams : replace(lower(t), "/[^a-z0-9_]/", "-")]
      dismissal_apps                  = required_pull_request_reviews.value.dismissal_apps
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval

      dynamic "bypass_pull_request_allowances" {
        for_each = length(keys(required_pull_request_reviews.value.bypass_pull_request_allowances)) > 0 ? [required_pull_request_reviews.value.bypass_pull_request_allowances] : []

        content {
          users = try(bypass_pull_request_allowances.value.users, [])
          teams = try(bypass_pull_request_allowances.value.teams, [])
          apps  = try(bypass_pull_request_allowances.value.apps, [])
        }
      }
    }
  }

  dynamic "restrictions" {
    for_each = local.restrictions[count.index]

    content {
      users = restrictions.value.users
      teams = [for t in restrictions.value.teams : replace(lower(t), "/[^a-z0-9_]/", "-")]
      apps  = restrictions.value.apps
    }
  }
}

resource "github_repository_ruleset" "ruleset" {
  for_each = local.rulesets_map

  name        = each.value.name
  target      = each.value.target
  enforcement = each.value.enforcement
  repository  = github_repository.repository.name

  dynamic "conditions" {
    for_each = (
      each.value.target != "push" ||
      try(each.value.conditions.ref_name, null) != null
    ) ? [true] : []

    content {
      ref_name {
        include = try(each.value.conditions.ref_name.include, ["~DEFAULT_BRANCH"])
        exclude = try(each.value.conditions.ref_name.exclude, [])
      }
    }
  }

  dynamic "bypass_actors" {
    for_each = try(each.value.bypass_actors, [])

    content {
      actor_id    = try(bypass_actors.value.actor_id, null)
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = try(bypass_actors.value.bypass_mode, "always")
    }
  }

  rules {
    creation                      = try(each.value.rules.creation, false)
    update                        = try(each.value.rules.update, false)
    update_allows_fetch_and_merge = try(each.value.rules.update_allows_fetch_and_merge, null)
    deletion                      = try(each.value.rules.deletion, false)
    required_linear_history       = try(each.value.rules.required_linear_history, false)
    required_signatures           = try(each.value.rules.required_signatures, false)
    non_fast_forward              = try(each.value.rules.non_fast_forward, false)

    dynamic "branch_name_pattern" {
      for_each = try(each.value.rules.branch_name_pattern, null) != null ? [each.value.rules.branch_name_pattern] : []

      content {
        operator = branch_name_pattern.value.operator
        pattern  = branch_name_pattern.value.pattern
        name     = try(branch_name_pattern.value.name, null)
        negate   = try(branch_name_pattern.value.negate, null)
      }
    }

    dynamic "tag_name_pattern" {
      for_each = try(each.value.rules.tag_name_pattern, null) != null ? [each.value.rules.tag_name_pattern] : []

      content {
        operator = tag_name_pattern.value.operator
        pattern  = tag_name_pattern.value.pattern
        name     = try(tag_name_pattern.value.name, null)
        negate   = try(tag_name_pattern.value.negate, null)
      }
    }

    dynamic "commit_author_email_pattern" {
      for_each = try(each.value.rules.commit_author_email_pattern, null) != null ? [each.value.rules.commit_author_email_pattern] : []

      content {
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
        name     = try(commit_author_email_pattern.value.name, null)
        negate   = try(commit_author_email_pattern.value.negate, null)
      }
    }

    dynamic "required_status_checks" {
      for_each = try(each.value.rules.required_status_checks, null) != null ? [each.value.rules.required_status_checks] : []

      content {
        do_not_enforce_on_create             = try(required_status_checks.value.do_not_enforce_on_create, null)
        strict_required_status_checks_policy = try(required_status_checks.value.strict_required_status_checks_policy, null)

        dynamic "required_check" {
          for_each = try(required_status_checks.value.required_check, [])

          content {
            context        = required_check.value.context
            integration_id = try(required_check.value.integration_id, null)
          }
        }
      }
    }

    dynamic "required_deployments" {
      for_each = try(each.value.rules.required_deployments, null) != null ? [each.value.rules.required_deployments] : []

      content {
        required_deployment_environments = try(required_deployments.value.required_deployment_environments, [])
      }
    }

    dynamic "pull_request" {
      for_each = try(each.value.rules.pull_request, null) != null ? [each.value.rules.pull_request] : []

      content {
        dismiss_stale_reviews_on_push     = try(pull_request.value.dismiss_stale_reviews_on_push, null)
        require_code_owner_review         = try(pull_request.value.require_code_owner_review, null)
        require_last_push_approval        = try(pull_request.value.require_last_push_approval, null)
        required_approving_review_count   = try(pull_request.value.required_approving_review_count, null)
        required_review_thread_resolution = try(pull_request.value.required_review_thread_resolution, null)
        allowed_merge_methods             = try(pull_request.value.allowed_merge_methods, null)

        dynamic "required_reviewers" {
          for_each = try(pull_request.value.required_reviewers, null) != null ? [pull_request.value.required_reviewers] : []

          content {
            file_patterns     = required_reviewers.value.file_patterns
            minimum_approvals = try(required_reviewers.value.minimum_approvals, 0)

            dynamic "reviewer" {
              for_each = try(required_reviewers.value.reviewer, null) != null ? [required_reviewers.value.reviewer] : []

              content {
                id   = reviewer.value.id
                type = try(reviewer.value.type, "Team")
              }
            }
          }
        }
      }
    }

    dynamic "required_code_scanning" {
      for_each = try(each.value.rules.required_code_scanning, null) != null ? [each.value.rules.required_code_scanning] : []

      content {
        dynamic "required_code_scanning_tool" {
          for_each = try(required_code_scanning.value.required_code_scanning_tool, [])

          content {
            tool                      = try(required_code_scanning_tool.value.tool, null)
            alerts_threshold          = try(required_code_scanning_tool.value.alerts_threshold, null)
            security_alerts_threshold = try(required_code_scanning_tool.value.security_alerts_threshold, null)
          }
        }
      }
    }

    dynamic "commit_message_pattern" {
      for_each = try(each.value.rules.commit_message_pattern, null) != null ? [each.value.rules.commit_message_pattern] : []

      content {
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
        name     = try(commit_message_pattern.value.name, null)
        negate   = try(commit_message_pattern.value.negate, null)
      }
    }

    dynamic "committer_email_pattern" {
      for_each = try(each.value.rules.committer_email_pattern, null) != null ? [each.value.rules.committer_email_pattern] : []

      content {
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
        name     = try(committer_email_pattern.value.name, null)
        negate   = try(committer_email_pattern.value.negate, null)
      }
    }

    dynamic "file_path_restriction" {
      for_each = try(each.value.rules.file_path_restriction, null) != null ? [each.value.rules.file_path_restriction] : []

      content {
        restricted_file_paths = try(file_path_restriction.value.restricted_file_paths, [])
      }
    }

    dynamic "file_extension_restriction" {
      for_each = try(each.value.rules.file_extension_restriction, null) != null ? [each.value.rules.file_extension_restriction] : []

      content {
        restricted_file_extensions = try(file_extension_restriction.value.restricted_file_extensions, [])
      }
    }

    dynamic "max_file_path_length" {
      for_each = try(each.value.rules.max_file_path_length, null) != null ? [each.value.rules.max_file_path_length] : []

      content {
        max_file_path_length = try(max_file_path_length.value.max_file_path_length, null)
      }
    }

    dynamic "max_file_size" {
      for_each = try(each.value.rules.max_file_size, null) != null ? [each.value.rules.max_file_size] : []

      content {
        max_file_size = try(max_file_size.value.max_file_size, null)
      }
    }

    dynamic "merge_queue" {
      for_each = try(each.value.rules.merge_queue, null) != null ? [each.value.rules.merge_queue] : []

      content {
        check_response_timeout_minutes    = try(merge_queue.value.check_response_timeout_minutes, null)
        grouping_strategy                 = try(merge_queue.value.grouping_strategy, null)
        max_entries_to_build              = try(merge_queue.value.max_entries_to_build, null)
        max_entries_to_merge              = try(merge_queue.value.max_entries_to_merge, null)
        merge_method                      = try(merge_queue.value.merge_method, null)
        min_entries_to_merge              = try(merge_queue.value.min_entries_to_merge, null)
        min_entries_to_merge_wait_minutes = try(merge_queue.value.min_entries_to_merge_wait_minutes, null)
      }
    }

    dynamic "copilot_code_review" {
      for_each = try(each.value.rules.copilot_code_review, null) != null ? [each.value.rules.copilot_code_review] : []

      content {
        review_on_push             = try(copilot_code_review.value.review_on_push, null)
        review_draft_pull_requests = try(copilot_code_review.value.review_draft_pull_requests, null)
      }
    }
  }
}

resource "github_issue_label" "label" {
  for_each = local.issue_labels_create ? local.issue_labels : {}

  repository  = github_repository.repository.name
  name        = each.value.name
  description = each.value.description
  color       = each.value.color
}

resource "github_repository_collaborator" "collaborator" {
  for_each = local.collaborators

  repository = github_repository.repository.name
  username   = each.key
  permission = each.value
}

resource "github_team_repository" "team_repository" {
  count = length(local.team_ids)

  repository = github_repository.repository.name
  team_id    = local.team_ids[count.index].team_id
  permission = local.team_ids[count.index].permission
}

resource "github_team_repository" "team_repository_by_slug" {
  for_each = local.teams

  repository = github_repository.repository.name
  team_id    = each.value.slug
  permission = each.value.permission
}

resource "github_repository_deploy_key" "deploy_key_computed" {
  count = length(local.deploy_keys_computed)

  repository = github_repository.repository.name
  title      = local.deploy_keys_computed[count.index].title
  key        = local.deploy_keys_computed[count.index].key
  read_only  = local.deploy_keys_computed[count.index].read_only
}

resource "github_repository_deploy_key" "deploy_key" {
  for_each = local.deploy_keys

  repository = github_repository.repository.name
  title      = each.value.title
  key        = each.value.key
  read_only  = each.value.read_only
}

resource "github_repository_webhook" "repository_webhook" {
  count = length(var.webhooks)

  repository = github_repository.repository.name
  active     = try(var.webhooks[count.index].active, true)
  events     = var.webhooks[count.index].events

  configuration {
    url          = var.webhooks[count.index].url
    content_type = try(var.webhooks[count.index].content_type, "json")
    insecure_ssl = try(var.webhooks[count.index].insecure_ssl, false)
    secret       = try(var.webhooks[count.index].secret, null)
  }
}

resource "github_repository_autolink_reference" "repository_autolink_reference" {
  for_each = local.autolink_references

  repository          = github_repository.repository.name
  key_prefix          = each.value.key_prefix
  target_url_template = each.value.target_url_template
  is_alphanumeric     = each.value.is_alphanumeric
}

resource "github_app_installation_repository" "app_installation_repository" {
  for_each = var.app_installations

  repository      = github_repository.repository.name
  installation_id = each.value
}

resource "github_repository_dependabot_security_updates" "dependabot_security_updates" {
  count = var.dependabot_security_updates_enabled == null ? 0 : 1

  repository = github_repository.repository.name
  enabled    = var.dependabot_security_updates_enabled
}

resource "github_actions_variable" "repository_variable" {
  for_each = var.actions_variables

  repository    = github_repository.repository.name
  variable_name = each.key
  value         = each.value
}
