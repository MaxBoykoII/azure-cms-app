# Azure Article CMS

![main workflow](https://github.com/MaxBoykoII/azure-cms-app/actions/workflows/main.yml/badge.svg)

Built with Flask, this Python web application allows an administrator to log in and out and create/edit articles. An article consists of a title, author, and body of text stored in an Azure SQL Server along with an image that is stored in Azure Blob Storage. This application implements OAuth2 with Sign in with Microsoft using the `msal` library, along with app logging.

This project uses Terraform for provisioning the application infrastructure and Docker for both local development and packaging the application for production.

### Dependencies

1. Docker
2. Azure cli
3. Terraform
4. A service principal for Terraform

### Provisioning the application infrastructure

1. Create a resource group for the terraform backend by running `az group create` `-n` `tfstates -l westus`
2. Create a storage account for the terraform backend by running`az storage account create -n tfsamb -g tfstates -l westus --sku Standard_LRS`
3. Create a storage container for the terraform backend by running `az storage container create -n tfstatedevops --connection-string <connection-string>`, where ```<conection-string>``` denotes the connection string from the previous command. 
4. Copy into the ```resources``` directory.
5. Run ```terraform init``` to download the necessary providers.
6. Run ```terraform apply``` and enter values for the SQL server administator password, along with a trusted ip address for accessing the SQL server from a local machine.
7. Once the infrastructure has been provisioned, you will need to seed the database. (The application assumes an administrator account exists). To do so, open the azure portal, locate the application's database, and login with the username ```missadministrator``` and the password you entered previously. Finally, navigate to the query editor and run the scripts contained in this repo's `sql_scripts` folder.
8. In the Azure portal, navigate to the app service for the cms and inspect its configuration (under Settings). Make note of the names and values of the environment variables, which will be needed for local development.

### Local development

1. Open a terminal and export of each environment variables used by the app service on Azure.
2. Run ```docker-compose up -d --build``` to run the application server, which is configured to run on ```localhost:5004```. 
3. To lint the application, run ```docker-compose exec cms flake8 FlaskWebProject```, ```docker-compose exec cms black FlaskWebProject --check```, and ```docker-compose exec cms isort . --src ./FlaskWebProject --profile black --check-only```. 
4. To refresh the application after making changes, run ```docker-compose up --build```.
5. To turn off the development server, run ```docker-compose down```.

### Building a production image

To build a production image, use the ```Dockerfile.prod``` file, which configures the application to be run with a gunicorn server.

### Tearing down the application infrastructure

1. Copy into the ```resources directory```
2.  Run ```terraform destroy```



