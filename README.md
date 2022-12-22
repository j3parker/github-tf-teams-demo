# github-tf-teams-demo

Demo of how you could use TF to maintain GitHub teams

## Layout

* `teams/`: Teams are defined in individual `.yml` files and collected in `data.tf`. This folder is itself a Terraform module. Most users edit the .yml files in here without thinking explicitly about Terraform.
* `terraform/`: This is the folder where the actual Terraform exists. Most users ignore this folder as an implementation detail.
  * `environments/`
    * `github.com/`
      * `org1/`: This is a Terraform environment for the hypothetical https://github.com/org1. It has its own independent state file etc.
      * `org2/`: Another hypothetical org.
  * `modules/`: This is where reusable modules go
    * `github-org-teams/`: This is the module that creates/owns the actual org team resources.

Note that we [filter the users from the teams yml to only real org members](https://github.com/j3parker/github-tf-teams-demo/blob/main/terraform/modules/github-org-teams/main.tf#L18-L27). This prevents us from enrolling external people into the org after they've left. If you wanted to also support those then the yml should have a specific section for external collaborators. This has the consequence of silently ignoring team members that are invalid -- it would be possible to instead cause the build to fail if you wished.
