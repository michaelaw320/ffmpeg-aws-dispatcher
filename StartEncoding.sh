#!/bin/bash

source config.sh

# Copy necessary files
scp -oStrictHostKeyChecking=no -r -i "$AWS_KEYPATH_ON_MASTER" "$MASTER_PROJECTPATH" $AWS_USER@$AWS_ADDRESS:"\"$AWS_PROJECTPATH\""
scp -oStrictHostKeyChecking=no -i "$AWS_KEYPATH_ON_MASTER" "$MASTER_KEYPATH_ON_MASTER" $AWS_USER@$AWS_ADDRESS:"\"$MASTER_KEYPATH_ON_AWS\""

# Execute the script on EC2
ssh -oStrictHostKeyChecking=no -i "$AWS_KEYPATH_ON_MASTER" $AWS_USER@$AWS_ADDRESS "screen -d -m \"$AWS_PROJECTPATH/EC2EncodeExec.sh\""
#ssh -i "$AWS_KEYPATH_ON_MASTER" $AWS_USER@$AWS_ADDRESS "bash -x \"$AWS_PROJECTPATH/EC2EncodeExec.sh\""
