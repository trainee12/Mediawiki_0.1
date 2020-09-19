# Mediawiki_0.1

## Steps to provision:

###### Install Git, wget and unzip 

sudo yum install git wget unzip -y


### Download Terraform v0.13.3

wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_arm.zip

### Unzip Terraform

unzip ./<terraform Zip file> -d /usr/local/bin


### Check Version

terraform -v
Output: Terraform v0.13.3

### Clone the Excecutable files

git clone https://github.com/trainee12/Mediawiki_0.1

### Initialiaze

cd deploy/
terraform init

### Plan

terraform plan

### Provision the INFRA

terraform apply -var <db_pass> -var <db_root_pass>

Check the Load Balancer DNS from AWS console
