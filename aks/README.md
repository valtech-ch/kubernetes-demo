# PowerShell installs

## Install KubeCtl Module

```
Install-Script -Name install-kubectl -Scope CurrentUser -Force
install-kubectl.ps1 -DownloadLocation [Where you want to have the exe file]
```

## Install AZ Cli

```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

# Create a new Azure Registry
```
az acr create -n valtechchregistry -g dave-test-k8scluster --sku basic
```
Attach the Regsitry to the k8s Cluster
```
az aks update -n dave-test-k8scluster -g dave-test-k8scluster --attach-acr valtechchregistry
```

# Push an image to Azure Registry

Once you have the image localy in your docker repository, tag it matching the Azure Repository
```
docker tag [image] valtechchregistry.azurecr.io/[image]:[tag]
```
Login to the Azure reposiroty and expose your token
```
az acr login --name <acrName> --expose-token
```
Connect docker to the Azure Repository with yoru token
```
docker login valtechchregistry.azurecr.io -u 00000000-0000-0000-0000-000000000000 -p [TOKEN]
```
and push you image to the Azure Repository
```
docker push valtechchregistry.azurecr.io/[image]:[tag]
```


# Deploy in Kubernetes

To be able to pull from the Azure Repository we need a Principal.
Create with name ```valtech-ch-acr-service-principal``` with pull rights
```
az ad sp create-for-rbac -n valtech-ch-acr-service-principal 
    --role acrpull 
    --scopes /subscriptions/[SUBSCRIPTIONID]/resourceGroups/[RESOURCEGROUPNAME]
    --query password 
    --output tsv
```

Take the genearted pwd and use it in the next command to generate a secrect in the given namespace how can be used by the deploy yml
```
kubectl create secret docker-registry valtechchregistrysecret 
    --namespace dev 
    --docker-server=valtechchregistry.azurecr.io 
    --docker-username=valtech-ch-acr-service-principal
    --docker-password=[PASSWORD]
```
Use this now in the deploy
```
    imagePullSecrets:
        - name: valtechchregistrysecret
```

# Kbernetes 

Create a POD file to define your application

```
.\kubectl.exe apply -f .\admin-sa.yml
.\kubectl.exe apply -f .\admin-rbac.yml
```

## Configure Kubectl to connect to a specific cluster with a given user
```
.\kubectl config set-credentials my-service-account1 --token=TBD
.\kubectl config set-context my-service-account1-context --cluster=dave-test-k8scluster --user=my-service-account1
.\kubectl config set-cluster dave-test-k8scluster --insecure-skip-tls-verify=true --server=https://dave-test--dave-test-k8sclu-3d7f97-d617786c.hcp.westeurope.azmk8s.io:443
.\kubectl get pods
```

## Get Public ips of a Azure Cluster
Note that managed k8s Clusters like the one on Azure do not need a manual ip management.
```
az network public-ip show --resource-group dave-test-k8scluster --name dave-test-k8scluster --query ipAddress --output tsv
```
