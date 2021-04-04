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


## Step-by-Step Setup Guidelines

### Pre-requisites

* [Microsoft Azure Account](https://azure.microsoft.com/en-in/free/)
* Azure CLI
* [Terraform on Azure](https://docs.microsoft.com/en-us/azure/developer/terraform/)

### Configuring Terraform on Azure

```
Give the example
```

### Configuring Azure VM for Golden Image


### Configuring Azure MySQL Database initialized with Custom Data provided


### Using Terraform Config files (tf-files) to Provision the necessary Infra


## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/pkdasgupta/solanasre-proj/tags).


## Author

* **Prasanta Dasgupta** [pkdasgupta](https://pkdasgupta.co.in/)

## Acknowledgments

* **Joe Abanto** [Email](joe@solana.com)


