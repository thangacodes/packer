#!/bin/bash
echo "Script started at:" $(date '+%d-%m-%Y %H:%M:%S')
echo "................................................"
echo "      PACKER EXECUTION BASH SCRIPT              "
echo "................................................"
current_dir=$(pwd)
echo ${current_dir}
## Variables
packer_config_file="${current_dir}/aws-aml3.pkr.hcl" 
echo "Packer config file path: ${packer_config_file}"

# Check if the packer config file exists
if [ ! -f "${packer_config_file}" ]; then
  echo "Error: Configuration file ${packer_config_file} does not exist."
  exit 1
fi
echo "Packer command execution will begin shortly..."
packer init .
packer fmt .
packer validate .
packer build ${packer_config_file}
exit 0
