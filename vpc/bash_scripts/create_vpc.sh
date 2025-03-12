#!/bin/bash

set -e 

#Create the VPC
VPC_ID=$(aws ec2 create-vpc \
--cidr-block "172.1.0.0/16" \
--tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=vpc-bash}]' \
--query Vpc.VpcId \
--output text)

echo "VPC_ID: $VPC_ID"
#--------------------------------

#Create IGW
IGW_ID=$(aws ec2 create-internet-gateway \
--tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=igw-bash}]' \
--query InternetGateway.InternetGatewayId \
--output text)

echo "IGW_ID: $IGW_ID"
#--------------------------------

#Attach IGW to VPC
aws ec2 attach-internet-gateway \
--internet-gateway-id $IGW_ID \
--vpc-id $VPC_ID

#--------------------------------


#Create subnet
SUBNET_ID=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block "172.1.128.0/20" \
--tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=subnet-bash}]' \
--query Subnet.SubnetId \
--output text)

echo "SUBNET_ID: $SUBNET_ID"
#--------------------------------


#Get route main table id
ROUTE_TABLE_ID=$(aws ec2 describe-route-tables \
--filters "Name=vpc-id,Values=$VPC_ID" "Name=association.main,Values=true" \
--query "RouteTables[0].RouteTableId" \
--output text)

echo "ROUTE_TABLE_ID: $ROUTE_TABLE_ID"
#--------------------------------


#Associate subnet to route table
aws ec2 associate-route-table \
--route-table-id $ROUTE_TABLE_ID \
--subnet-id $SUBNET_ID
#--------------------------------

aws ec2 create-route --route-table-id $ROUTE_TABLE_ID \
--destination-cidr-block "0.0.0.0/0" \
--gateway-id $IGW_ID
#--------------------------------


