write-host "The script is execution time:" $(Get-Date) -ForegroundColor red -BackgroundColor black
write-host "BEGIN WITH PACKER AND TERRAFORM EXECUTION...." -ForegroundColor DarkMagenta -BackgroundColor Green
Start-Sleep 2
$env:Path += ";C:\technical\PS\packer_1.9.2_windows_amd64"
write-host "Checking Packer version..."
packer version
write-host "Cross checking the files in project-7" -ForegroundColor DarkMagenta -BackgroundColor Green
cd C:\technical\PS\Usecases\usecase\packer\project-7
pwd
dir
write-host "Packer validation in progress..." -ForegroundColor DarkMagenta -BackgroundColor Green
packer validate --var-file .\variables.json .\template.json
Write-Host "Packer build in progress..." -ForegroundColor DarkMagenta -BackgroundColor Green
packer build --var-file .\variables.json .\template.json
Start-Sleep 10
Write-Host "Terraform begins shortly...." -f DarkBlue -BackgroundColor Green 
cd terraform_deployment
Write-Host "Terraform init begin shortly..." -f DarkBlue -BackgroundColor Green
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply --auto-approve
