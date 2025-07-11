#!/bin/bash
echo "The script execution time is:..." $(date '+%Y-%m-%d %H:%M:%S')
PVD='packer validate'
PVB='packer build'
FILE='template.json'
echo "Packer build execution begin shortly..."
read -p "Please enter what do you want to perform now: " PERFORM
echo ${PERFORM}
if [[ ${PERFORM} == "PVD" ]];
then
echo "${PVD} in progress..."
${PVD} ${FILE}
elif [[ ${PERFORM} == "PVB" ]];
then
echo "${PVB} in progress..."
${PVB} ${FILE}
else
echo "You entered wrong input. Please correct yourself and try again..."
fi
exit
