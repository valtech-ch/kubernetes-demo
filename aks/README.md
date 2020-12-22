# Prerequistis
Powershell stuff

## Install KubeCtl Module
```
Install-Script -Name install-kubectl -Scope CurrentUser -Force
install-kubectl.ps1 -DownloadLocation [Where you want to have the exe file]
```

## Install AZ Cli
```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

## Install Helm
To install the ingress images we use Helm.

Get the latest version for your Architecture from ```https://github.com/helm/helm/releases``` and decompress the content to the same directy as Kubectl above

## Tips/tricks
To make life easier, create an alias for kubectl
```
Set-Alias -Name k -Value [PathToKubeCtrl]\kubectl
```

If you work a lot with Helm, also create a alias h for Helm.

Alternative is to add the location where kubectl and helm are kept to the system path env.

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

First thing to do, is to setup the kubtctl config file so that you can access the cluster.

Vars you have to know before stating:
- [CLUSTERNAME] Exemple: dave-test-k8scluster
- [RESOURCEGROUPNAME] Exemple: dave-test-k8scluster
- [SERVERURL] Exemple: https://dave-test--dave-test-k8sclu-3d7f97-d617786c.hcp.westeurope.azmk8s.io:443
- [NAMESPACE] any simple string to identify your space. Exemple: mySpace
- [SUBSCRIPTIONID] Subscription ID. Exemple: 3d7f9720-f38e-447b-ba93-470416489aa1

## Get access

### Use your account setup the connection to the cluster

```
az login
az aks Get-Credentials --name "[CLUSTERNAME]" --resource-group "[RESOURCEGROUPNAME]"
```
By doing so you shoud now have in you personal user a folder called .kube with a config file. Ex: "C:\Users\daniel.finck\.kube\config"
Inside you can find the Access token and more details.

If your account is linked to multiple subscriptions, add the subscription parameter to the call:

```
az login
az aks Get-Credentials --name "[CLUSTERNAME]" --resource-group "[RESOURCEGROUPNAME]" --subscription [SUBSCRIPTIONID]
```

Also set the default SubScription for your account via 
```
az account set -s [SUBSCRIPTIONID]
```

## Setup
Create a namespace for all your stuff
```
kubectl create namespace [NAMESPACE]
```
And set the namespace as default
```
kubectl config set-context --current --namespace=[NAMESPACE]
```

## Start your pods
```
kubectl apply -f kubenetes-demo-be.yml
kubectl apply -f kubenetes-demo-fe.yml
```
Check if all pods are runing
```
kubctl get all
```

## Configure ingress

Add the ingress-nginx repository
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

Use Helm to deploy an NGINX ingress controller
```
helm install nginx-ingress ingress-nginx/ingress-nginx `
    --namespace [NAMESPACE] `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set controller.admissionWebhooks.patch.nodeSelector."beta\.kubernetes\.io/os"=linux
```

Run the ingress rooting
```
kubectl apply -f kubenetes-demo-ingress.yml
kubctl get all
```

In this list you should get a Public IP for the ingress service. Note that the Public IP make take some time to be generated.

