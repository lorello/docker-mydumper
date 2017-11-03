#!/bin/bash
set -eu
set -o pipefail

echo "Running mydumper $MYDUMPER_VERSION"

ORIGIN_DB_SKIP=${ORIGIN_DB_SKIP:-test}
LOG_PATH=${LOG_PATH:-"/dumpdir"}
LOCK_TYPE=${LOCK_TYPE:-"--less-locking --trx-consistency-only"}
THREADS=${THREADS:-2}
CHUNK_SIZE=${CHUNK_SIZE:-5120}
LONG_QUERY_GUARD=${LONG_QUERY_GUARD:-3600}

mydumper --database ${ORIGIN_DB_NAME} \
    --outputdir /dumpdir \
    --regex "^(?!($DB_TO_SKIP))" \
    --build-empty-files \
    --user ${ORIGIN_DB_USER} --pass ${ORIGIN_DB_PASS} \
    --host ${ORIGIN_DB_HOST} --port ${ORIGIN_DB_PORT} \
    --triggers --events --routines \
    --chunk-filesize ${CHUNK_SIZE} \
    --compress \
    --long-query-guard ${LONG_QUERY_GUARD} --kill-long-queries \
    --success-on-1146 \
    $LOCK_TYPE \
    --threads ${THREADS} \
    --verbose 3 2>&1 | ts -i | tee -a $LOG_PATH/mydumper-$(date +%F-%R).log 
