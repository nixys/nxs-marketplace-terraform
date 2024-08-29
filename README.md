# nxs-marketplace-terraform

![Terraform git](https://github.com/nixys/nxs-marketplace-terraform/assets/84950037/4a0dcbc6-ec7e-462e-824b-ce4d06e041da)

## Introduction
This repository contains [Terraform](https://www.terraform.io/) modules for easy deployment and configures of core resources.

## Features

* Support for different software versions
* Support next clouds (Amazon Web Services, Google Cloud Platform, SberCloud, YandexCloud)

## Who can use the tool

* Developers
* System administrators
* DevOps engineers

## Quickstart

For use this module you need to installed Terraform package. Set up the Terraform file, then init, plan and run module:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Module Variables
The available variables are listed in each modules's README file, along with their default values.

### Modules:

<details><summary>Amazon Web Services</summary>

1. [VPC](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Amazon%20Web%20Services/VPC/README.md) - create resources in VPC

</details>

<details><summary>Google Cloud Platform</summary>

1. [Networking](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/Networking/README.md) - create resources in Network
2. [Compute-Engine](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/Compute-Engine/README.md) - create resources in Compute
3. [SQL](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/SQL/README.md) - create resources in SQL
4. [Net-Services](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/Net-Services/README.md) - create resources in Net-Services
5. [Kubernetes-Engine](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/Kubernetes-Engine/README.md) - create resources in Kubernetes
6. [Memorystore](https://github.com/nixys/nxs-marketplace-terraform/blob/main/Google%20Cloud%20Platform/Memorystore/README.md) - create resources in Memorystore

</details>

<details><summary>SberCloud</summary>

1. [Enterprise Project Management Service](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Enterprise-Project-Management-Service/README.md) - create resources in Enterprise Project Management Service
2. [Network](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Network/README.md) - create resources in Network
3. [Computing](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Computing/README.md) - create resources in Computing
4. [Database](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Database/README.md) - create resources in Database
5. [Storage](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Storage/README.md) - create resources in Storage
6. [Application](https://github.com/nixys/nxs-marketplace-terraform/blob/main/SberCloud/Application/README.md) - create resources in Application

</details>

<details><summary>Yandex Cloud</summary>

1. [VPC](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/VPC/README.md) - create resources in Virtual Private Cloud
2. [Compute](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Compute/README.md) - create resources in Compute Cloud
3. [Managed-kubernetes](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-kubernetes/README.md) - create resources in Managed Service for Kubernetes
4. [Managed-mysql](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-mysql/README.md) - create resources in Managed Service for MySQL
5. [Managed-postgresql](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-postgresql/README.md) - create resources in Managed Service for PostgreSQL
6. [Network-load-balancer](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Network-load-balancer/README.md) - create resources in Network Load Balancer
7. [Storage](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Storage/README.md) - create resources in Object Storage
8. [Managed-opensearch](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-opensearch/README.md) - create resources in Managed Service for OpenSearch
9. [Managed-redis](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-redis/README.md) - create resources in Managed Service for Redis
10. [Managed-clickhouse](https://github.com/nixys/nxs-marketplace-terraform/blob/main/YandexCloud/Managed-clickhouse/README.md) - create resources in Managed Service for ClickHouse

</details>

## Roadmap

Following features are already in backlog for our development team and will be released soon:

* AWS (modules: VPC, EC2, EKS)

## Feedback

For support and feedback please contact me:
* telegram: [@Gacblk](https://t.me/gacblk)
* e-mail: a.gacenko@nixys.io

For news and discussions subscribe the channels:

* Telegram community (news): [@nxs_marketplace_terraform](https://t.me/nxs_marketplace_terraform)
* Telegram community (chat): [@nxs_marketplace_terraform_chat](https://t.me/nxs_marketplace_terraform_chat)

## License
nxs-marketplace-terraform is released under the [Apache License 2.0](https://github.com/nixys/nxs-marketplace-terraform/blob/main/LICENSE).
