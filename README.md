# Deploying NGINX as a Microservice on GCP/GKE

This project is aimed at using terraform to deploy nginx docker image as a microservice to a GKE cluster running on GCP. In this project Google Cloud Storage is required as a backend.

## Requirements

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="requirement_google"></a> [google](#requirement_google) | 4.54.0  |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | 4.54.0  |
| <a name="provider_helm"></a> [helm](#provider_helm)       | 2.9.0   |
| <a name="provider_null"></a> [null](#provider_null)       | 3.2.1   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                            | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [google_artifact_registry_repository.reece-repository](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/artifact_registry_repository)             | resource    |
| [google_artifact_registry_repository_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/artifact_registry_repository_iam_policy) | resource    |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/compute_network)                                                   | resource    |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/compute_router)                                                   | resource    |
| [google_compute_subnetwork.pri-sub](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/compute_subnetwork)                                          | resource    |
| [google_container_cluster.private-cluster](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/container_cluster)                                    | resource    |
| [google_container_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/container_node_pool)                                      | resource    |
| [google_project_iam_member.myaccount](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/project_iam_member)                                        | resource    |
| [google_project_service.artifactregistry](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/project_service)                                       | resource    |
| [google_project_service.compute](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/project_service)                                                | resource    |
| [google_project_service.container](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/project_service)                                              | resource    |
| [google_service_account.myaccount](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/resources/service_account)                                              | resource    |
| [helm_release.nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                                                                      | resource    |
| [null_resource.provisioner](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource)                                                              | resource    |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/data-sources/client_config)                                                 | data source |
| [google_iam_policy.admin](https://registry.terraform.io/providers/hashicorp/google/4.54.0/docs/data-sources/iam_policy)                                                         | data source |

## Usage
### Get the Code
Clone the repo using

### Deploy

To launch the required infrastructure and deploy nginx as a microservice, run;
- `terraform init` - to initialize your working directory. 
- `terraform plan`
- `terraform apply -auto-approve`

### Destroy

To destroy the infrastructure created, run
`terraform destroy -auto-approve`

### Sources
This project was inspired by Temiloluwa A.