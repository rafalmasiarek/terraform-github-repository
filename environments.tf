locals {
  environment_deployment_policies_flat = flatten([
    for env_name, env in var.environments : [
      for idx, policy in try(env.deployment_branch_policies, []) : {
        key            = "${env_name}::${idx}"
        environment    = env_name
        branch_pattern = try(policy.branch_pattern, null)
        tag_pattern    = try(policy.tag_pattern, null)
      }
    ]
  ])

  environment_deployment_policies_map = { for p in local.environment_deployment_policies_flat : p.key => p }

  environment_secrets_flat = flatten([
    for env_name, env in var.environments : concat(
      [
        for secret_name, value in try(env.plaintext_secrets, {}) : {
          key             = "${env_name}::${secret_name}"
          environment     = env_name
          secret_name     = secret_name
          plaintext_value = value
          encrypted_value = null
        }
      ],
      [
        for secret_name, value in try(env.encrypted_secrets, {}) : {
          key             = "${env_name}::${secret_name}"
          environment     = env_name
          secret_name     = secret_name
          plaintext_value = null
          encrypted_value = value
        }
      ]
    )
  ])

  environment_secrets_map = { for s in local.environment_secrets_flat : s.key => s }

  environment_variables_flat = flatten([
    for env_name, env in var.environments : [
      for variable_name, value in try(env.variables, {}) : {
        key           = "${env_name}::${variable_name}"
        environment   = env_name
        variable_name = variable_name
        value         = value
      }
    ]
  ])

  environment_variables_map = { for v in local.environment_variables_flat : v.key => v }
}

resource "github_repository_environment" "environment" {
  for_each = var.environments

  depends_on = [
    github_repository_collaborator.collaborator,
    github_team_repository.team_repository,
    github_team_repository.team_repository_by_slug,
  ]

  repository          = github_repository.repository.name
  environment         = each.key
  wait_timer          = try(each.value.wait_timer, null)
  can_admins_bypass   = try(each.value.can_admins_bypass, true)
  prevent_self_review = try(each.value.prevent_self_review, false)

  dynamic "reviewers" {
    for_each = try(each.value.reviewers, null) != null ? [each.value.reviewers] : []

    content {
      teams = try(reviewers.value.teams, [])
      users = try(reviewers.value.users, [])
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = try(each.value.deployment_branch_policy, null) != null ? [each.value.deployment_branch_policy] : []

    content {
      protected_branches     = deployment_branch_policy.value.protected_branches
      custom_branch_policies = deployment_branch_policy.value.custom_branch_policies
    }
  }
}

resource "github_repository_environment_deployment_policy" "deployment_policy" {
  for_each = local.environment_deployment_policies_map

  repository     = github_repository.repository.name
  environment    = github_repository_environment.environment[each.value.environment].environment
  branch_pattern = each.value.branch_pattern
  tag_pattern    = each.value.tag_pattern
}

resource "github_actions_environment_secret" "environment_secret" {
  for_each = local.environment_secrets_map

  repository      = github_repository.repository.name
  environment     = github_repository_environment.environment[each.value.environment].environment
  secret_name     = each.value.secret_name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
}

resource "github_actions_environment_variable" "environment_variable" {
  for_each = local.environment_variables_map

  repository    = github_repository.repository.name
  environment   = github_repository_environment.environment[each.value.environment].environment
  variable_name = each.value.variable_name
  value         = each.value.value
}
