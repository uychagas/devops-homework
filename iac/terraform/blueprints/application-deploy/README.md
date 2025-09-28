## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | 3.6.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.6.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_image.app_image](https://registry.terraform.io/providers/kreuzwerker/docker/3.6.1/docs/resources/image) | resource |
| [helm_release.application](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.rails_app_hash](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The application name | `string` | n/a | yes |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | The name of the namespace to create | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_chart"></a> [chart](#output\_chart) | Path or chart reference used for the Helm release (local path or chart identifier). |
| <a name="output_name"></a> [name](#output\_name) | Release name given to the Helm deployment. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Kubernetes namespace where the Helm release was installed. |
| <a name="output_notes"></a> [notes](#output\_notes) | Release notes returned by Helm after install/upgrade (may contain helpful instructions or URLs). |
| <a name="output_revision"></a> [revision](#output\_revision) | Helm release revision number representing the current revision of the deployed chart. |
