# Enterprise Project Management Service (EPS)

## Introduction

This is a set of terraform modules for the sbercloud provider for creating a Enterprise Projects and project management.

## Features

- Create Enterprise Project
- Disable/Enable Enterprise Project

## Settings

| Option | Type | Required | Default value |Description |
| --- | ---  | --- | --- | --- |
| `enterprise_projects.name` | String | Yes | - | **You can specify your own value for the name parameter. If you do not specify it, then the name will be the key of the element in the map.** Specifies the route table name. The value is a string of no more than 64 characters that can contain letters, digits, underscores (_), hyphens (-), and periods (.). |
| `enterprise_projects.description` | String | Yes | - | Specifies the VPC ID for which a route table is to be added. |
| `enterprise_projects.enable` | String | No | "true" | When creating an Enterprise Project, it has the default status of true; deleting a resource does not lead to deleting the entity; you can only disable the project through this parameter. |

## Example

Usage example located in this [directory](docs/example).
