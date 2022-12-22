data "github_organization" "this" {
    provider = github.dummy
    name     = local.org
}

module "teams" {
    source = "../../../modules/github-org-teams"
    
    org = local.org

    org_members = data.github_organization.this.members
    
    providers = {
        github.dummy = github.dummy
    }
}