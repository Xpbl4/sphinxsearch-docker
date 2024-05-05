Docker Sphinx search engine
=============================================

Docker image for SphinxSearch based on the Alpine Linux.

```
docker pull xpbl4/sphinxsearch:latest
```

### Docker Compose Example
You can use this image in docker-compose-powered app:

```yaml
version: "2"
services:
  sphinx:
    image: xpbl4/sphinxsearch:lastest
    ports:
      - 9306:9306
      - 9312:9312
    volumes:
      - "./sphinx.conf:/etc/sphinx/sphinx.conf"
      - "./data:/var/lib/sphinx"
```

### Creating the Indexes
With docker-compose:
```bash
docker-compose run --rm sphinx indexer --all
```

### Rotating the Indexes
The docker container must be running for rotating to work.

With docker-compose:
```bash
docker-compose exec sphinx indexer --all --rotate
```

## Tags available

* 2.2.11, latest