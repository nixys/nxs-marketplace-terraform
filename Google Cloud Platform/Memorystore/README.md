# Memorystore

## Introduction

This is a set of terraform modules for the Google Cloud Platform provider for building a Memorystore and creating any different memorystore resources

## Modules

| Modules | Settings | Resources | Description |
| --- | ---  | --- | --- |
| `memcached` |[memcached](memcached/README.md)| - google_memcache_instance | memcached settings |
| `redis` |[redis](redis/README.md)| - google_redis_instance<br> - google_redis_cluster | redis settings |
