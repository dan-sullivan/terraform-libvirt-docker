#!/bin/bash

# cd into the repo root if we're not already in there
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR


# Clean up - removing any existing output from previous runs
rm -f terraform-provider-libvirt

docker build --no-cache -t terraform-libvirt-build-tmp -f Dockerfile-compile .
CONTAINER_ID=$(docker run -d terraform-libvirt-build-tmp)
docker cp ${CONTAINER_ID}:"/bin/terraform-provider-libvirt" ./
docker rm -f ${CONTAINER_ID}
docker rmi -f terraform-libvirt-build-tmp  

# Should now have terraform-provider-libvirt plugin in repo root

if [ -e terraform-provider-libvirt ]
then
    docker build -t dansullivan/terraform-libvirt:latest -f Dockerfile .
    echo "Built dansullivan/terraform-libvirt:latest"
else
    echo "Missing terraform-provider-libvirt from compile run. Something went wrong"
    exit 1
fi
