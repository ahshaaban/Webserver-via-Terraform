
## Introduction
In this project, you will build a webserver behind a public loadbalancer. Webserver will be deployed  in VMSS backendpool. VMs will be linux-based taken from packer image.

## Getting Started
Before you start, you will need to:
* Clone the repository.
* Make sure you have an Azure account with the right access.


## Dependencies
In order to build the project, make sure you have:
* latest version of [Terraform](https://www.terraform.io/downloads.html)
* latest version of [Packer](https://www.packer.io/downloads/)
* lastest version of [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)


## Instructions
**1. Create a Server Image using packer**
  * Use Packer to create a server image, 
  * Ensure that the provided application is included in the template. 
            **Note**: You can feel free to write your own from scratch or use the server.json from the Github repository. 
  
  * Be sure to complete the following:
   	- Choose your base image ( I am using use an Ubuntu 18.04-LTS SKU)
   	- Ensure the following in your provisioners: 
        ```bash
        "inline": [
			"echo 'Hello, World!' > index.html",
			"nohup busybox httpd -f -p 80 &"],"inline_shebang": "/bin/sh -x","type": "shell"
    - Ensure that the resource group you specify in Packer for the image is the same image specified in Terraform.
    - Run ```packer build``` on your packer template.
  
            
      

**2. Create the infrastructure using Terraform.**
Now you're ready to create the infrastructure for the application to run on. Here are the main steps: 
 * Download the files in your working directory.
  * Opend bash shell command or Azure Shell
  * Run ```Terraform plan``` to make sure the configuration is all ready to be deployed.
  * If you get ```Success message```, you are ready for the next step. Otherwise follow the inustrctions to solve the errors.
  * Run ```Terraform apply``` to deploy the infrastructre.

  
**3. Deploying Your Infrastructure**
   It is time to deploy! be sure to do the following:
  * Initiate Packer with ```packer init```
  * Run ```packer build``` on your packer template.
  * Run terraform plan -out solution.plan.
  * Deploy your Terraform infrastructure with ```Terraform deploy```

## Output
You will get an output for terraform confirming the success of the deployment. You can now naviagete through your project.
