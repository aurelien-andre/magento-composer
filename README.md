# Composer

Version 2

## Requirements

| Service           | Version |
| ----------------- | ------- |
| OS Unix           | *       |
| Docker            | 20      |
| Docker-Compose    | 1.28    |

## Image

| Service           | Version       |
| ----------------- | ------------- |
| OS                | bullseye-slim |
| Php               | 7.4           |

## Usage

```yaml
version: '3.8'

services:

  composer:
    image: aurelienandre/magento-composer:latest
    command: install --prefer-dist --no-progress --no-interaction
    environment:
      - MAGENTO_USERNAME=foo
      - MAGENTO_PASSWORD=bar
    volumes:
      - ./src:/app:rw,delegated
```

```shell
docker-compose run --rm composer help
```
