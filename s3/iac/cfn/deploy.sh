#!/bin/bash

STACK_NAME="cfn-s3"

aws cloudformation deploy \
    --template-file template.yaml \
    --stack-name $STACK_NAME \
    --no-execute-changeset \
    --region us-east-2
