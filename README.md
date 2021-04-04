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

The easiest way to get onboarded to Terraform on Azure is via Azure Cloud Shell which has Terraform pre-installed. Terraform uses the ```azurerm provider``` to connect to Azure.

Open Azure Cloud Bash Shell and type the below Command to verify

```
terraform -version
```


Use [This Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) to have Terraform Authenticated to access your preferred subscription using a Service Principal with a Client Secret.


### Configuring Azure VM for Golden Image


### Configuring Azure MySQL Database initialized with Custom Data provided


### Using Terraform Config files (tf-files) to Provision the necessary Infra


## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/pkdasgupta/solanasre-proj/tags).


## Author

* **Prasanta Dasgupta** [pkdasgupta](https://pkdasgupta.co.in/)

## Acknowledgments

* **Joe Abanto** [Email](joe@solana.com)


