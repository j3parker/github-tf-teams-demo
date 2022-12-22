# This file collects the data from the .yml files
# You can import it as a module elsewhere in TF and reat the teams output.
# The org input is used to filter to a specific org.

variable "org" {
    type = string
}

locals {
    files = fileset(path.module, "*.yml")

    data = [for file in local.files :
        yamldecode(file("${path.module}/${file}"))
    ]

    teams = {for data in local.data :
        data.name => data
        if contains(data.orgs, var.org)
    }
}

output "teams" {
    value = local.teams
}