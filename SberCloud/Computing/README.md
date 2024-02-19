# Computing

## Introduction

This is a set of terraform modules for the SberCloud provider for building a computing and creating any different computing resources

## Modules

| Modules | Settings | Resources | Description |
| --- | ---  | --- | --- |
| `cce` |[cce](cce/README.md)| - sbercloud_cce_cluster<br> - sbercloud_cce_node<br> - sbercloud_cce_node_pool<br> - sbercloud_cce_addon<br> - sbercloud_cce_pvc<br> - sbercloud_cce_namespace | CCE settings |
| `ecs` |[ecs](ecs/README.md)| - sbercloud_compute_servergroup<br> - sbercloud_compute_interface_attach<br> - sbercloud_evs_volume<br> - sbercloud_compute_keypair<br> - sbercloud_compute_instance<br> - sbercloud_compute_volume_attach<br> - sbercloud_compute_eip_associate | ECS settings |
