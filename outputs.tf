output "full_name" {
  value       = github_repository.repository.full_name
  description = "A string of the form 'orgname/reponame'."
}

output "html_url" {
  value       = github_repository.repository.html_url
  description = "URL to the repository on the web."
}

output "ssh_clone_url" {
  value       = github_repository.repository.ssh_clone_url
  description = "URL that can be provided to git clone to clone the repository via SSH."
}

output "http_clone_url" {
  value       = github_repository.repository.http_clone_url
  description = "URL that can be provided to git clone to clone the repository via HTTPS."
}

output "git_clone_url" {
  value       = github_repository.repository.git_clone_url
  description = "URL that can be provided to git clone to clone the repository anonymously via the git protocol."
}

output "repository" {
  value       = github_repository.repository
  description = "All attributes and arguments as returned by the github_repository resource."
}

output "branches" {
  value       = github_branch.branch
  description = "A map of branch objects keyed by branch name."
}

output "ruleset_ids" {
  value       = { for k, v in github_repository_ruleset.ruleset : k => v.id }
  description = "A map of repository ruleset IDs keyed by the ruleset key."
}

output "collaborators" {
  value       = github_repository_collaborator.collaborator
  description = "A map of collaborator objects keyed by collaborator.name."
}

output "issue_labels" {
  value       = github_issue_label.label
  description = "A map of issue labels keyed by label input id or name."
}

output "deploy_keys" {
  value       = local.deploy_keys_output
  description = "A map of deploy keys keyed by input id."
}

output "webhooks" {
  value       = github_repository_webhook.repository_webhook
  sensitive   = true
  description = "All attributes and arguments as returned by the github_repository_webhook resource."
}

output "secrets" {
  value       = [for secret in github_actions_secret.repository_secret : secret.secret_name]
  description = "List of secrets available."
}

output "app_installations" {
  value       = github_app_installation_repository.app_installation_repository
  description = "A map of deploy app installations keyed by installation id."
}

output "actions_variables" {
  value       = [for v in github_actions_variable.repository_variable : v.variable_name]
  description = "List of repository-level Actions variable names."
}

output "environments" {
  value       = { for k, v in github_repository_environment.environment : k => v.environment }
  description = "A map of environment names keyed by environment name."
}
