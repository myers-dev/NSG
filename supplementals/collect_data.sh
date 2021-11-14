#!/bin/bash

if [ "$#" != 1 ]; then
    echo "Syntax: $0 scenarioid"
    echo "For example $0 12"
    exit 1
fi

scenario="scenario${1}"

hostnames=$(terraform output --state=../infrastructure/terraform.tfstate Linux_VMs | grep vnet-vm | tr -d "\"," | tr "/" " " | awk '{print $8}')
resource_group_name=$(terraform output --state=../infrastructure/terraform.tfstate resource_group_name | tr -d "\"" )

echo $hostnames
echo $resource_group_name

mkdir -p $scenario

for hostname in $hostnames; do
    ../supplementals/active_nsg.sh $hostname $resource_group_name > $scenario/$hostname
done