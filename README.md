# Packer:

1. Create a directory like C:\packer_1.9.2_windows_amd64 and place the executable file there (e.g., packer.exe)

2. Add the Packer path to your system environment variable:

   $env:Path += ";C:\packer_1.9.2_windows_amd64"

3. Navigate to the directory containing your JSON configuration files (e.g., C:\Packer_config) to create a custom image.

4. Open PowerShell >>Type C:\Packer_config\

   cd C:\Packer_config

   dir

5. Use the following commands to validate or build the image from a Windows machine:

   validate the config files:

   packer validate -var-file .\variables.json .\template.json

   Build the image:

   packer build -var-file .\variables.json .\template.json

Packer Commands Overview:

These commands by HashiCorp Packer will create a custom Amazon Machine Image (AMI):

   * packer init

   * packer fmt

   * packer validate

   * packer build ebs.json

   * packer build -var-file=vars.json template.json

Note: All configuration is written in JSON files.
 
Terraform Scripts begin after the ami is created.
 
   * terraform init
 
   * terraform fmt
 
   * terraform validate
 
   * terraform plan
 
   * terraform apply --auto-approve
 
To perform these steps, I created a small shell script that requires no manual intervention.

[deregister-ami script](https://github.com/thangacodes/packer/blob/main/packer_projects/project-8/deregister-ami.sh)

Hashicorp tool version check command

[tool_version_check](https://github.com/thangacodes/packer/blob/main/enterprise_image_build/hashi_tool_version_check.sh)

