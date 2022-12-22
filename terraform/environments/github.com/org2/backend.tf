# This file is "boilerplate" but abridged

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

variable "github_app_pem_file" {
  type = string
}

locals {
  org = "org2"
}

provider "github" {
  alias = "dummy"
  owner = local.org

  app_auth {
    id              = "123456"
    installation_id = "11112222333"
    pem_file        = var.github_app_pem_file
  }
}