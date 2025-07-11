#!/bin/bash
echo "Script started at:" $(date '+%d-%m-%Y %H:%M:%S')
echo "................................................"
echo "      AMI DE-REGISTER AND SNAPSHOT DELETION     "
echo "................................................"
echo ""
read -p "Enter the AMI ID please: " AMI_ID
echo "User entered ami id is: " $AMI_ID
read -p "Enter the snapshot ID please: " SNAP_ID
echo "User entered snapshot id is: " $SNAP_ID
read -p "Do you want to de-register and delete snapshot: " INPUT
echo "user entered input as: $INPUT"
if [[ "$INPUT" == "yes" ]]; then
	echo "You are good to de-register ami first and then proceeding with snapshot deletion.."
	aws ec2 deregister-image --image-id "$AMI_ID"
	aws ec2 delete-snapshot --snapshot-id "$SNAP_ID"
elif [[ "$INPUT" == "no" ]]; then
	echo "User input is no, hence cancelling the operation"
else
	echo "User must have to be enter ('yes or no')"
fi
exit 0
