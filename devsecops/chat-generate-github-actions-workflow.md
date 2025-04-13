Generate a GitHub Actions YAML pipeline
- Source code is a Java application in /src
- Trigger only when a file is changed in /src on the main branch
- Build the docker image and push to Azure Container Registry myregistry.azurecr.io/myimage:v2 and myregistry.azurecr.io/myimage:latest
- Update the Azure Kubernetes deployment mydeployment with the new image