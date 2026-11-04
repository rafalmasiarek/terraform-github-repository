locals {
  homepage_url                = var.homepage_url == null ? lookup(var.defaults, "homepage_url", "") : var.homepage_url
  private                     = var.private == null ? lookup(var.defaults, "private", true) : var.private
  private_visibility          = local.private ? "private" : "public"
  visibility                  = var.visibility == null ? lookup(var.defaults, "visibility", local.private_visibility) : var.visibility
  has_issues                  = var.has_issues == null ? lookup(var.defaults, "has_issues", false) : var.has_issues
  has_projects                = var.has_projects == null ? lookup(var.defaults, "has_projects", false) : var.has_projects
  has_wiki                    = var.has_wiki == null ? lookup(var.defaults, "has_wiki", false) : var.has_wiki
  has_discussions             = var.has_discussions == null ? lookup(var.defaults, "has_discussions", false) : var.has_discussions
  allow_merge_commit          = var.allow_merge_commit == null ? lookup(var.defaults, "allow_merge_commit", true) : var.allow_merge_commit
  allow_rebase_merge          = var.allow_rebase_merge == null ? lookup(var.defaults, "allow_rebase_merge", false) : var.allow_rebase_merge
  allow_squash_merge          = var.allow_squash_merge == null ? lookup(var.defaults, "allow_squash_merge", false) : var.allow_squash_merge
  allow_auto_merge            = var.allow_auto_merge == null ? lookup(var.defaults, "allow_auto_merge", false) : var.allow_auto_merge
  allow_update_branch         = var.allow_update_branch == null ? lookup(var.defaults, "allow_update_branch", false) : var.allow_update_branch
  allow_forking               = var.allow_forking == null ? lookup(var.defaults, "allow_forking", true) : var.allow_forking
  delete_branch_on_merge      = var.delete_branch_on_merge == null ? lookup(var.defaults, "delete_branch_on_merge", true) : var.delete_branch_on_merge
  is_template                 = var.is_template == null ? lookup(var.defaults, "is_template", false) : var.is_template
  auto_init                   = var.auto_init == null ? lookup(var.defaults, "auto_init", true) : var.auto_init
  gitignore_template          = var.gitignore_template == null ? lookup(var.defaults, "gitignore_template", "") : var.gitignore_template
  license_template            = var.license_template == null ? lookup(var.defaults, "license_template", "") : var.license_template
  default_branch              = var.default_branch == null ? lookup(var.defaults, "default_branch", null) : var.default_branch
  merge_commit_title          = var.merge_commit_title == null ? lookup(var.defaults, "merge_commit_title", "MERGE_MESSAGE") : var.merge_commit_title
  merge_commit_message        = var.merge_commit_message == null ? lookup(var.defaults, "merge_commit_message", "PR_TITLE") : var.merge_commit_message
  squash_merge_commit_title   = var.squash_merge_commit_title == null ? lookup(var.defaults, "squash_merge_commit_title", "COMMIT_OR_PR_TITLE") : var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message == null ? lookup(var.defaults, "squash_merge_commit_message", "COMMIT_MESSAGES") : var.squash_merge_commit_message
  web_commit_signoff_required = var.web_commit_signoff_required == null ? lookup(var.defaults, "web_commit_signoff_required", false) : var.web_commit_signoff_required
  standard_topics             = var.topics == null ? lookup(var.defaults, "topics", []) : var.topics
  topics                      = concat(local.standard_topics, var.extra_topics)
  template                    = var.template == null ? [] : [var.template]
  issue_labels_create         = var.issue_labels_create == null ? lookup(var.defaults, "issue_labels_create", local.issue_labels_create_computed) : var.issue_labels_create

  issue_labels_create_computed = local.has_issues || length(var.issue_labels) > 0

  var_gh_labels = var.issue_labels_merge_with_github_labels
  gh_labels     = local.var_gh_labels == null ? lookup(var.defaults, "issue_labels_merge_with_github_labels", true) : local.var_gh_labels

  issue_labels_merge_with_github_labels = local.gh_labels
  vulnerability_alerts = var.vulnerability_alerts != null ? var.vulnerability_alerts : (
    var.dependabot_security_updates_enabled == true ? true : (local.private ? false : true)
  )

  pages = var.pages == null ? null : merge(
    {
      build_type = "legacy"
      cname      = null
      path       = "/"
    },
    var.pages
  )

  branch_protections_v3 = [
    for b in var.branch_protections_v3 : merge({
      branch                          = null
      enforce_admins                  = null
      require_conversation_resolution = null
      require_signed_commits          = null
      required_status_checks          = {}
      required_pull_request_reviews   = {}
      restrictions                    = {}
    }, b)
  ]

  required_status_checks_v3 = [
    for b in local.branch_protections_v3 :
    length(keys(b.required_status_checks)) > 0 ? [
      merge({
        strict   = null
        contexts = []
        checks   = []
      }, b.required_status_checks)
    ] : []
  ]

  required_status_checks_v3_normalized = [
    for checks_list in local.required_status_checks_v3 : [
      for item in checks_list : {
        strict   = try(item.strict, null)
        contexts = length(try(item.checks, [])) > 0 ? item.checks : try(item.contexts, [])
      }
    ]
  ]

  required_pull_request_reviews = [
    for b in local.branch_protections_v3 :
    length(keys(b.required_pull_request_reviews)) > 0 ? [
      merge({
        dismiss_stale_reviews           = true
        dismissal_users                 = []
        dismissal_teams                 = []
        dismissal_apps                  = []
        require_code_owner_reviews      = null
        required_approving_review_count = null
        require_last_push_approval      = null
        bypass_pull_request_allowances  = {}
      }, b.required_pull_request_reviews)
    ] : []
  ]

  restrictions = [
    for b in local.branch_protections_v3 :
    length(keys(b.restrictions)) > 0 ? [
      merge({
        users = []
        teams = []
        apps  = []
      }, b.restrictions)
    ] : []
  ]

  branch_protections_v4_map = { for idx, e in var.branch_protections_v4 : try(e._key, e.pattern) => idx }

  rulesets = [
    for idx, rs in var.rulesets : merge({
      target                   = "branch"
      enforcement              = "active"
      conditions               = {}
      bypass_actors            = []
      rules                    = {}
      do_not_enforce_on_create = null
    }, rs)
  ]

  rulesets_map = {
    for idx, rs in local.rulesets : format("%02d-%s", idx, rs.name) => rs
  }

  branches_map = { for b in var.branches : b.name => b }

  github_default_issue_labels = local.issue_labels_merge_with_github_labels ? [
    {
      name        = "bug"
      description = "Something isn't working"
      color       = "d73a4a"
    },
    {
      name        = "documentation"
      description = "Improvements or additions to documentation"
      color       = "0075ca"
    },
    {
      name        = "duplicate"
      description = "This issue or pull request already exists"
      color       = "cfd3d7"
    },
    {
      name        = "enhancement"
      description = "New feature or request"
      color       = "a2eeef"
    },
    {
      name        = "good first issue"
      description = "Good for newcomers"
      color       = "7057ff"
    },
    {
      name        = "help wanted"
      description = "Extra attention is needed"
      color       = "008672"
    },
    {
      name        = "invalid"
      description = "This doesn't seem right"
      color       = "e4e669"
    },
    {
      name        = "question"
      description = "Further information is requested"
      color       = "d876e3"
    },
    {
      name        = "wontfix"
      description = "This will not be worked on"
      color       = "ffffff"
    }
  ] : []

  github_issue_labels = { for i in local.github_default_issue_labels : i.name => i }

  module_issue_labels = { for i in var.issue_labels : lookup(i, "id", lower(i.name)) => merge({
    description = null
  }, i) }

  issue_labels = merge(local.github_issue_labels, local.module_issue_labels)

  collab_admin    = { for i in var.admin_collaborators : i => "admin" }
  collab_push     = { for i in var.push_collaborators : i => "push" }
  collab_pull     = { for i in var.pull_collaborators : i => "pull" }
  collab_triage   = { for i in var.triage_collaborators : i => "triage" }
  collab_maintain = { for i in var.maintain_collaborators : i => "maintain" }

  collaborators = merge(
    local.collab_admin,
    local.collab_push,
    local.collab_pull,
    local.collab_triage,
    local.collab_maintain,
  )

  team_id_admin    = [for i in var.admin_team_ids : { team_id = i, permission = "admin" }]
  team_id_push     = [for i in var.push_team_ids : { team_id = i, permission = "push" }]
  team_id_pull     = [for i in var.pull_team_ids : { team_id = i, permission = "pull" }]
  team_id_triage   = [for i in var.triage_team_ids : { team_id = i, permission = "triage" }]
  team_id_maintain = [for i in var.maintain_team_ids : { team_id = i, permission = "maintain" }]

  team_ids = concat(
    local.team_id_admin,
    local.team_id_push,
    local.team_id_pull,
    local.team_id_triage,
    local.team_id_maintain,
  )

  team_admin    = [for i in var.admin_teams : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "admin" }]
  team_push     = [for i in var.push_teams : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "push" }]
  team_pull     = [for i in var.pull_teams : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "pull" }]
  team_triage   = [for i in var.triage_teams : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "triage" }]
  team_maintain = [for i in var.maintain_teams : { slug = replace(lower(i), "/[^a-z0-9_]/", "-"), permission = "maintain" }]

  teams = { for i in concat(
    local.team_admin,
    local.team_push,
    local.team_pull,
    local.team_triage,
    local.team_maintain,
  ) : i.slug => i }

  deploy_keys_computed_temp = [
    for d in var.deploy_keys_computed : try({ key = tostring(d) }, d)
  ]

  deploy_keys_computed = [
    for d in local.deploy_keys_computed_temp : merge({
      title     = length(split(" ", d.key)) > 2 ? element(split(" ", d.key), 2) : md5(d.key)
      read_only = true
    }, d)
  ]

  deploy_keys_temp = [
    for d in var.deploy_keys : try({ key = tostring(d) }, d)
  ]

  deploy_keys = {
    for d in local.deploy_keys_temp : lookup(d, "id", md5(d.key)) => merge({
      title     = length(split(" ", d.key)) > 2 ? element(split(" ", d.key), 2) : md5(d.key)
      read_only = true
    }, d)
  }

  autolink_references = { for i in var.autolink_references : lookup(i, "id", lower(i.key_prefix)) => merge({
    target_url_template = null
  }, i) }

  deploy_keys_output = merge({
    for i, d in github_repository_deploy_key.deploy_key_computed :
    lookup(local.deploy_keys_computed_temp[i], "id", md5(d.key)) => d
  }, github_repository_deploy_key.deploy_key)
}
