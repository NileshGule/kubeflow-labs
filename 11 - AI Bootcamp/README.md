# Global AI Bootcamp Singapore 2018

## AKS setup

### Check versions of Kubernetes available

```bash

az aks get-versions `
--subscription "Microsoft Azure Sponsorship" `
--location "South East Asia"

```

### Create job using yaml file

```powershell

 kubectl apply -f .\mnist-job.yml

 ```

 ### Get job

```powershell

 kubectl get job

 ```

 ### Get pod details

```powershell

 kubectl get pods

 ```