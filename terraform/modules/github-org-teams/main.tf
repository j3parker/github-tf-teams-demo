module "teams" {
    source = "../../../teams"

    org = var.org
}

resource "github_team" "teams" {
    provider = github.dummy

    for_each = module.teams.teams

    name        = each.key
    description = try(each.value.description, "")
    privacy     = "closed"
}

locals {
    # Flatten the team memberships into one big object mapping a constructed unique
    # key to the member name + team id for the purposes of for_each.
    # This also filters out non-org members so that we don't accidentally invite
    # former employees into the org.
    team_members = merge([for team_name,team in module.teams.teams :
        {for member in team.members : "${team_name}/${member}" => {
            team_id = github_team.teams[team_name].id
            member  = member
        } if contains(var.org_members, member)}
    ]...)
}

resource "github_team_membership" "members" {
    provider = github.dummy
    for_each = local.team_members
    team_id  = each.value.team_id
    username = each.value.member
    role     = "member"
}