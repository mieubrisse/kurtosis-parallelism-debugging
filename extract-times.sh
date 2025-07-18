#!/usr/bin/env bash

set -euo pipefail

filepath="${1}"

# metrics=(
#     "filesArtifactExpansion"
#     "createAndStartContainer"
#     "createStartServiceOperation"
# )

service_names=(
    "read-genesis-validators-root"
    "read-osaka-time"
    "check-osaka-enabled"
)

service_ids=(
    "${2}"
    "${3}"
    "${4}"
)

# service_ids=()
# for service_name in "${service_names[@]}"; do
#     service_id="$(grep -A1 "finished registering services \[${service_name}\]" "${filepath}" | tail -1 | sed "s/.*Starting service '\(.*\)'/\1/g")"
#     service_ids+=("${service_id:0:8}")
#     echo "${service_name} -> ${service_id:0:8}"
# done


metrics=(
    "filesArtifactsExpansion"
    "createAndStartContainer"
    "fetchImage"
    "getNetworksByFilterArgs"
    "containerCreate"
    "connectContainerToNetwork"
    "createStartServiceOperation"
)

for service_id in "${service_ids[@]}"; do
    if [ -z "${service_id}" ]; then
        echo "Empty service ID"
        exit 1
    fi

    echo "------ ${service_id} -------"
    for metric in "${metrics[@]}"; do
        grep "IN" "${filepath}" | grep "${service_id}" | grep "finished ${metric}" | grep "took" | sed "s/.*took //g"
    done
done

