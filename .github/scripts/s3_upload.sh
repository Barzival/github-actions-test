#!/usr/bin/env bash

bucket=$S3_APP_BUCKET
workspace_dir=`pwd`


s3_upload() {
    cd ${workspace_dir}/app/

    local app=${1}
    local version=${2}

    local package_dir="./services/${app}/package"
    rm -rf ${package_dir}
    mkdir -p ${package_dir}

    cp ./bin/${app} ${package_dir}/

    cd ${package_dir}

    tar -czf ${app}-${version}.tar.gz ./*

    aws s3 cp ${app}-${version}.tar.gz s3://${bucket}/applications/backend/${app}/
}

source .github/scripts/all_services.sh

push_tag() {
    local tag=${1}

    for service_name in "${all_services[@]}"
    do
        s3_upload ${service_name} ${tag}
    done
}

if [[ -n "$GITHUB_REF_NAME" ]]; then
    push_tag $GITHUB_REF_NAME
fi