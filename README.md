# Solana SRE - IaaC Project

* IaaC - Infrastructure as Code for Solana SRE Project 

* Project Instructions : https://github.com/joeaba/solana-sre


## Infra Details

* IaaC Language Used : [Terraform](https://www.terraform.io/)
* Cloud Service Provider Used : [Microsoft Azure](https://azure.microsoft.com/en-in/)
* Application Language : [Python - Flask](https://www.fullstackpython.com/flask.html)
* Database Used : [Azure Managed MySQL DB](https://azure.microsoft.com/en-in/services/mysql/)
* Webserver : Auto-Scaled [Azure VM Scalesets](https://docs.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview) behind Azure Load Balancer

## Repo Directory Structure

* **tf-code** : Directory Conatining Terraform Code (IaaC) to provision and configure Azure cloud Infra

* **infra-arch** : Infrastructure Architecture Diagram detailing Tools and Methodologies used

* **app-ss** : Directory containing Screenshots from Running Application


## Step-by-Step Setup Guide

### Pre-requisites

* [Microsoft Azure Account](https://azure.microsoft.com/en-in/free/)
* Azure CLI
* [Terraform on Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/)

### Configuring Terraform on Azure

The easiest way to get onboarded to Terraform on Azure is via [Azure Cloud Shell](https://shell.azure.com/) which has Terraform pre-installed. Terraform uses the ```azurerm provider``` to connect to Azure.

Open Azure Cloud Bash Shell and type the below Command to verify

```
terraform -version
```

![tfconsole](https://github.com/pkdasgupta/solanasre-proj/blob/main/app-ss/tfonconsole.jpg?raw=true)

Use [This Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) to have Terraform Authenticated to access your preferred subscription using a Service Principal with a Client Secret.


### Configuring Azure VM for Golden Image

- Create an [Azure Linux VM](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli#create-virtual-machine) with Python3 pre-installed 
- Login to the VM and Clone the Repository conataining application code :  https://github.com/joeaba/solana-sre
- Install necessary python modules : Flask, MySQL Connector
- Open Port 5000 on the VM to access the app url.

### Configuring Azure MySQL Database initialized with Custom Data provided

- Create an [Azure MySQL Database](https://docs.microsoft.com/en-us/azure/mysql/quickstart-create-mysql-server-database-using-azure-cli)
- Execute the provided SQL Script on the server : ```hello_world.sql``` to initialize the database
- Run the app with ```python index.html```
- Upon successful setup and execution, you would see the below while hitting app url for loadbalancer Public IP.

![app-ss](https://github.com/pkdasgupta/solanasre-proj/blob/main/infra-arch/app-ss.JPG)

### Using Terraform Config files (tf-files) to Provision the necessary Infra

- Create an [image of the VM](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-custom-images) prepared above to be used as Golden image for VM scalesets.
- Provide the resource-id in [tf-code/vmss.tf](https://github.com/pkdasgupta/solanasre-proj/blob/main/tf-code/vmss.tf) for the image created above as Custom image to be used in VM Scalesets.
- Import the database using command mentioned in [tf-code/tfcmds](https://github.com/pkdasgupta/solanasre-proj/blob/main/tf-code/tfcmds)
- Switch to tf-code directory and run the below for infra provisoning :

```
$ terraform init

$ terraform plan -out=solana-plan

$ terraform apply solana-plan
``` 

- Verify Infra and running application by hitting the Load Balancer Public IP

![infra-diag](https://github.com/pkdasgupta/solanasre-proj/blob/main/infra-arch/solana-sre-archdiag.JPG)

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/pkdasgupta/solanasre-proj/tags).


## Author

* **Prasanta Dasgupta** [pkdasgupta](https://pkdasgupta.co.in/)

## Acknowledgments

* **Joe Abanto** [Email](mailto:joe@solana.com)


