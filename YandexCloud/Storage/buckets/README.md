# buckets

## Introduction

This is a set of terraform modules for the Yandex Cloud provider for building a Storage and creating any different storage resources

## Features

- Supported buckets

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `buckets.max_size` | Int | No | 1048576 | The size of bucket, in bytes. See size limiting for more information. |
| `buckets.acl` | String | No | "private" | The predefined ACL to apply. Defaults to private. Conflicts with grant. |
| `buckets.versioning_enabled` | Bool | No | true | Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket. |
| `buckets.enable_logging` | Bool | Yes | - | Enable logging in another log's bucket. |
| `buckets.default_storage_class` | String | No | "COLD" | Storage class which is used for storing objects by default. Available values are: "STANDARD", "COLD", "ICE". Default is "STANDARD". See storage class for more inforamtion. |
| `buckets.object_lock_enabled` | String | No | - | Enable object locking in a bucket. Require versioning to be enabled. |
| `buckets.object_lock_configuration_mode` | String | Yes | - | Specifies a type of object lock. One of ["GOVERNANCE", "COMPLIANCE"]. |
| `buckets.object_lock_configuration_years` | String | No | - | Specifies a retention period in years after uploading an object version. It must be a positive integer. You can't set it simultaneously with days. |
| `buckets.object_lock_configuration_days` | String | No | - | Specifies a retention period in days after uploading an object version. It must be a positive integer. You can't set it simultaneously with years. |
| `buckets.kms_master_key_id` | String | No | null | The KMS master key ID used for the SSE-KMS encryption. |
| `buckets.sse_algorithm` | String | Yes | "aws:kms" | The server-side encryption algorithm to use. Single valid value is aws:kms |
| `buckets.website` | List | No | [] | A website object |
| `buckets.grant` | List | No | [] | An ACL policy grant. Conflicts with acl. |
| `buckets.cors_rule` | List | No | [] | A rule of Cross-Origin Resource Sharing |
| `buckets.lifecycle_rule` | List | No | [] | A configuration of object lifecycle management |
| `buckets.policy` | String | No | null | The policy object should contain the only field with the text of the policy. |
| `buckets.https` | List | No | [] | Manages https certificates for bucket. |
| `buckets.anonymous_access_flags_read` | Bool | No | true | Allows to read objects in bucket anonymously. |
| `buckets.anonymous_access_flags_list` | Bool | No | false | Allows to list object in bucket anonymously. |
| `buckets.anonymous_access_flags_config_read` | Bool | No | true | Allows to config read in bucket anonymously. |
| `buckets.tags` | Map | No | {} | The tags object for setting tags (or labels) for bucket. |

## Example

Usage example located in this [directory](docs/example).
