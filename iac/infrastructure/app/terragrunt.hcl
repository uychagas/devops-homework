terraform {
  source = "iac/terraform/blueprints/application-deploy"
}

inputs = {
  namespace_name = "devops-homework"
  app_name       = "rails-app"
}
