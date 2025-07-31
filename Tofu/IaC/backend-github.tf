# Backend configuration for GitHub (DEPRECATED - Now using local backend)
# This file is kept for reference only
# The actual backend is now configured in backend.tf as local

terraform {
  backend "http" {
    # Example configuration for GitHub as backend (NOT USED)
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