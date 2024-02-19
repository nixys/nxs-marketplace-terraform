# Object Storage Service (OBS)

## Introduction

This is a set of terraform modules for the SberCloud provider for building a Storage and creating Object Storage Service resources.

## Features

- Supported Buckets
- Supported Bucket ACL
- Supported Bucket Policy

## Settings

| Option | Type | Required | Default value | Description |
| --- | --- | --- | --- | --- |
| `general_project_id` | String | No | `null` | Default project |
| `general_region` | String | No | `null` | Default region |
| `buckets.enterprise_project_id` | String | No | var.general_project_id | The enterprise project id of the OBS bucket. Changing this creates a OBS bucket.  |
| `buckets.acl` | String | No | "private" | Specifies the ACL policy for a bucket. The predefined common policies are as follows: "private", "public-read", "public-read-write" and "log-delivery-write".  |
| `buckets.versioning` | Bool | No | true | Whether enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket.  |
| `buckets.storage_class` | String | No | "STANDARD" | Specifies the storage class of the bucket. OBS provides three storage classes: "STANDARD", "WARM" (Infrequent Access) and "COLD" (Archive).  |
| `buckets.quota` | Int | No | 0 | Specifies bucket storage quota. Must be a positive integer in the unit of byte. The maximum storage quota is 263 – 1 bytes. The default bucket storage quota is 0, indicating that the bucket storage quota is not limited.  |
| `buckets.force_destroy` | Bool | No | false | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error.   |
| `buckets.region` | String | No | var.general_region | Specified the region where this bucket will be created. If not specified, used the region by the provider.  |
| `buckets.kms_key_id` | String | No | null | Specifies the ID of a KMS key. If omitted, the default master key will be used.  |
| `buckets.kms_key_project_id` | String | No | null | Specifies the project ID to which the KMS key belongs. If omitted, the ID of the provider-level project will be used.  |
| `buckets.enable_logging` | Bool | Yes | true | Enables the creation of a bucket to store the main bucket's logs. |
| `buckets.multi_az` | Bool | No | true | Whether enable the multi-AZ mode for the bucket. When the multi-AZ mode is enabled, data in the bucket is duplicated and stored in multiple AZs.  |
| `buckets.policy_format` | String | No | null | Specifies the policy format, the supported values are obs and s3. |
| `buckets.website` | List | No | null | Specifies an array of one or more lifecycle_rules to attach additional settings to the bucket. |
| `buckets.cors_rule` | List | No | null | Specifies an array of one or more lifecycle_rules to attach additional settings to the bucket. |
| `buckets.lifecycle_rule` | List | No | null | Specifies an array of one or more lifecycle_rules to attach additional settings to the bucket. |
| `buckets.tags` | Map | No | null | A mapping of tags to assign to the bucket. Each tag is represented by one key-value pair. |
| `bucket_acls.bucket_name` | String | Yes | null | Specifies the ID of a KMS key. If omitted, the default master key will be used.  |
| `bucket_acls.region` | String | No | var.general_region | Specifies the ID of a KMS key. If omitted, the default master key will be used.  |
| `bucket_acls.owner_permission_access_to_bucket` | List | No | null | Specifies the bucket owner permission. If omitted, the current obs bucket acl owner permission will not be changed. |
| `bucket_acls.owner_permission_access_to_acl` | List | No | null | Specifies the bucket owner permission. If omitted, the current obs bucket acl owner permission will not be changed. |
| `bucket_acls.public_permission_access_to_bucket` | List | No | null | Specifies the public permission. |
| `bucket_acls.log_delivery_user_permission_access_to_bucket` | List | No | null | Specifies the log delivery user permission. |
| `bucket_acls.log_delivery_user_permission_access_to_acl` | List | No | null | Specifies the log delivery user permission. |
| `bucket_acls.account_permission` | List | No | null | Specifies an array of one or more access rights rules for a user account.  |
| `bucket_policys.bucket_name` | String | Yes | null | Specifies the name of the bucket to which to apply the policy.  |
| `bucket_policys.policy_format` | String | No | null | Specifies the policy format, the supported values are obs and s3. |
| `bucket_policys.region` | String | No | var.general_region | The region in which to create the OBS bucket policy resource. If omitted, the provider-level region will be used. Changing this creates a new OBS bucket policy resource. |
| `bucket_policys.policy` | String | Yes | null | Specifies the text of the bucket policy in JSON format.  |

## Example

Usage example located in this [directory](docs/example).
