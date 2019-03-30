#!/bin/bash
set -o pipefail

while true
do
    echo '=== Refreshing lists...'
    ./list.sh
    echo '=== Sleeping for 15min...'
    sleep 900
done