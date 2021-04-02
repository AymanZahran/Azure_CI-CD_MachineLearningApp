#!/bin/bash
az group create --resource-group $FLASK_RESOURCE_GROUP --location $AZURE_LOCATION --tags webserver-env="Production"
az webapp up -g $FLASK_RESOURCE_GROUP -n $FLASK_WEB_APP
az pipelines variable-group create --name Variable_Group --authorize true --organization $ORGANIZATION_NAME --project $PROJECT_NAME --variables azureServiceConnectionId=$AZURE_SERVICE_CONNECTION_ID webAppName=$FLASK_WEB_APP vmImageName=$AGENT_VM_IMAGE_NAME environmentName=$ENVIRONMENT_NAME  pythonVersion=$PYTHON_VERSION
az pipelines create --name $PIPELINE_NAME --description $PIPELINE_DESCRIPTION --organization $ORGANIZATION_NAME --project $PROJECT_NAME --repository $REPO_NAME --branch master --repository-type github --yml-path azure-pipelines.yml 
