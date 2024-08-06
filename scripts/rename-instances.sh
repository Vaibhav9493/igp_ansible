#!/bin/bash

clustername=$1
name=$2
instanceids=()
totalcount=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:cluster,Values=$clustername" "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId'|jq -r .[]|wc -l`
newcount=`aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$name" "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId'|jq -r .[]|wc -l`
#changecountstart=`expr $totalcount - $newcount`
changecountstart=`expr $totalcount - $totalcount`

echo -e "\nRenaming Cluster : $clustername stack incrementally from $changecountstart to $totalcount \n"

#aws ec2 describe-instances --region us-east-1 --filters "Name=tag:Name,Values=$name" "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId'|jq -r .[] > instances
aws ec2 describe-instances --region us-east-1 --filters "Name=tag:cluster,Values=$clustername" "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId'|jq -r .[] > instances

for i in `cat instances`; do
        instanceids+=("$i")
done

for (( i=changecountstart; i<=totalcount-1; i++))
do
        if [ $i -le 8 ];
        then
                no=00`expr $i + 1`
        elif [ $i -gt 8 ] && [ $i -le 500 ]
        then
                no=0`expr $i + 1`
        fi

        #arrcount=`expr $i - $changecountstart`
        arrcount=$i
        #echo $arrcount $no
        aws ec2 create-tags --region us-east-1 --resources ${instanceids[$arrcount]} --tags Key=Name,Value=$name-$no

done
