UNDER CONSTRUCTION


# Become cluster Admin
```
az aks get-credentials --resource-group dave-test-k8scluster --name dave-test-k8scluster --admin
```

# Create a new account to setup the connection to the cluster

```

az ad sp create-for-rbac --skip-assignment --name myAKSClusterServicePrincipal
az role assignment create --assignee <appId> --scope <resourceScope> --role Contributor

.\kubectl.exe apply -f .\admin-sa.yml
.\kubectl.exe apply -f .\admin-rbac.yml
```

```
.\kubectl config set-credentials my-service-account1 --token=TBD
.\kubectl config set-context my-service-account1-context --cluster=[CLUSTERNAME] --user=my-service-account1
.\kubectl config set-cluster [CLUSTERNAME] --server=[SERVERURL] --insecure-skip-tls-verify=true
.\kubectl get pods
```


kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep my-service-account1 | awk '{print $1}')
kubectl -n kube-system describe secret my-service-account1-token-p78nz