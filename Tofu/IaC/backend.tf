terraform {
  backend "http" {
    # Configuration will be provided via command line in GitHub Actions
    # for greater flexibility between different environments
  }
}