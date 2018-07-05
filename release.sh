#!/usr/bin/env bash
node=(6.10.3 8.10.0)
serverless=(1.27.3 1.28.0)

IMAGE_NAME=aproint/aws-codebuild-serverless

for node_version in "${node[@]}"
do
    node_major=$(echo $node_version | awk -F. '{print $1}')
    tag_node="node${node_major}"
    for serverless_version in "${serverless[@]}"
    do
        #extract major version from sls, i.e. 1.27 from 1.27.3
        sls_minor=$(echo $serverless_version | awk 'BEGIN{FS=OFS="."}{NF--; print}')
        tag_all="${tag_node}-sls${serverless_version}"
        tag_minor="${tag_node}-sls${sls_minor}"
        #skip if the image exists
        if [[ "$(docker images -q $IMAGE_NAME:$tag_all 2> /dev/null)" == "" ]]; then
            docker build \
                --build-arg NODE_VERSION=$node_version \
                --build-arg SERVERLESS_VERSION=$serverless_version \
                -t $IMAGE_NAME \
                -t $IMAGE_NAME:$tag_all \
                -t $IMAGE_NAME:$tag_minor \
                .
            docker push $IMAGE_NAME:$tag_all
            docker push $IMAGE_NAME:$tag_minor
        fi
        #skip if the extra image exists
        #if [[ "$(docker images -q $IMAGE_NAME:$tag_all-extra 2> /dev/null)" == "" ]]; then
        #    docker build \
        #        --build-arg IMAGE_VERSION=$tag_all \
        #        -t $IMAGE_NAME:$tag_all-extra \
         #       -t $IMAGE_NAME:$tag_minor-extra \
        #        -f Dockerfile-extra \
        #        .
            docker push $IMAGE_NAME:$tag_all-extra
            docker push $IMAGE_NAME:$tag_minor-extra
        #fi
    done
done