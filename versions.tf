terraform {
  required_version = ">= 1.5.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.13.0, < 7.0.0"
    }
  }
}
