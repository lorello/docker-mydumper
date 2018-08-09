# docker-mydumper

dockerized mydumper tool from percona.

Current docker image needed because nobody has the latest build from sources (v 0.9.5)

## Example usage

Supposing that:
- mysql server runs in docker network `backplane`
- the name of the container is *mysql*
- the final backup dir is `/var/backups/mydumper`
- `backup/XXXX` are valid credentials to access mysql tables

A command to perform a backup is:
 
```
docker run -it --rm \
    --net=backplane \
    --volume /var/backups/mydumper:/var/tmp \
    lorello/mydumper:0.9.5 \
        --host mysql --user backup --password XXXX \
        --compress --verbose 3 \
        --outputdir /var/tmp
```

## Docker hub

* https://hub.docker.com/r/lorello/mydumper
* docker pull lorello/mydumper

## Useful links

* https://www.percona.com/blog/2015/11/12/logical-mysql-backup-tool-mydumper-0-9-1-now-available/
* https://www.percona.com/blog/2015/09/21/containing-logical-backups-mydumper-docker/
* https://launchpad.net/mydumper
* https://github.com/maxbube/mydumper


