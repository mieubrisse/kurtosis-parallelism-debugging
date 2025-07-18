#!/usr/bin/env bash

set -euo pipefail

if [ "${#}" -ne 4 ]; then
    echo "${0} filepath read_genesis read_osaka check_if_osaka"
fi

filepath="${1}"
read_genesis="${2}"
read_osaka="${3}"
check_if_osaka="${4}"

service_ids=(
    "${read_genesis}"
    "${read_osaka}"
    "${check_if_osaka}"
)

# metrics=(
#     "filesArtifactExpansion"
#     "createAndStartContainer"
#     "createStartServiceOperation"
# )


metrics=(
    "finished files artifacts expansion"
    "creating and starting container"
    "createStartServiceOperation"
)

for service_id in "${service_ids[@]}"; do
    echo "------ ${service_id} -------"
    for metric in "${metrics[@]}"; do
        grep "IN START SERVICE OPERATION" "${filepath}" | grep "${service_id}" | grep "${metric}" | grep "took" | sed "s/.*took //g"
        # grep "IN START SERVICE OPERATION" "${filepath}" | grep "${service_id}" | grep "${metric}" 
    done
done

