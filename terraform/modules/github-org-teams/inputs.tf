terraform {
  required_providers {
    github = {
      source = "integrations/github"

      configuration_aliases = [github.dummy]
    }
  }
}

variable "org" {
    type = string
}

variable "org_members" {
    type = set(string)
}