# creates some kind of terraform naming convention
# until proven otherwise, assuming witchcraft
#
module "label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=master"
  namespace = "weedmaps"
  stage     = "dev"
  name      = "weedmaps-forum"
}
