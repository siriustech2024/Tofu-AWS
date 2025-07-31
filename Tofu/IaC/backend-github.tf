# Backend configuration for GitHub
# This file can be used as a reference to configure the backend
# The actual backend will be configured via command line in workflows

terraform {
  backend "http" {
    # Example configuration for GitHub as backend
    # address = "https://api.github.com/repos/OWNER/REPO/state/default"
    # lock_address = "https://api.github.com/repos/OWNER/REPO/state/default/lock"
    # unlock_address = "https://api.github.com/repos/OWNER/REPO/state/default/lock"
    # username = "GITHUB_USERNAME"
    # password = "GITHUB_TOKEN"
    # lock_method = "POST"
    # unlock_method = "DELETE"
    # retry_wait_min = "5"
  }
} 