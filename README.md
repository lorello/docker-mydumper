# docker-mydumper

Lorello dockerized mydumper tool from percona.

Current docker image needed because nobody has the latest build from sources (v 0.9.3)

## Docker hub

* https://hub.docker.com/r/lorello/mydumper
* docker pull lorello/mydumper

## Useful links

* https://www.percona.com/blog/2015/11/12/logical-mysql-backup-tool-mydumper-0-9-1-now-available/
* https://www.percona.com/blog/2015/09/21/containing-logical-backups-mydumper-docker/
* https://launchpad.net/mydumper
* https://github.com/maxbube/mydumper

## Environmental variables

* `ORIGIN_DB_NAME`
* `ORIGIN_DB_HOST`
* `ORIGIN_DB_PORT`
* `ORIGIN_DB_PASS`
* `ORIGIN_DB_USER`
* `ORIGIN_DB_SKIP`, is a regex, pass multiple values using `(db1|db2.table)` [default: test]
* `LOG_PATH` [default: /dumpdir]
* `LOCK_TYPE`, you can pass `--no-locks` tto skip locking [default: --less-locking --trx-consistency-only]
* `THREADS` [default: 2]
* `CHUNK_SIZE` [default: 5120] M
* `ONG_QUERY_GUARD` [default: 3600] seconds
* `DEST_DB_NAME`
* `DEST_DB_HOST`
* `DEST_DB_PORT`
* `DEST_DB_PASS`
* `DEST_DB_USER`

## Usage mode

Try to have a folder writable by everyone in your pc since the image runs as `root` user.
```bash
$ sudo mkdir /tmp/dumpdir
$ sudo chmod 0777 /tmp/dumpdir
$ docker run --env-file=~/.env -v "/tmp/dumpdir:/dumpdir:rw"
```
The `env-file` is a simple txt file with the following format:
```
ORIGIN_DB_NAME=...
ORIGIN_DB_HOST=...
ORIGIN_DB_PORT=...
ORIGIN_DB_PASS=...
ORIGIN_DB_USER=...
DEST_DB_NAME=...
DEST_DB_HOST=...
DEST_DB_PORT=...
DEST_DB_PASS=...
DEST_DB_USER=...
```
using the previous `env-file` example you can setup all the variables that you need to execute the dump of you database.

> Replace the `...` with your information.
