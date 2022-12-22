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