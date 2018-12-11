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

 kubectl apply -f .\mnist-job-without-gpu.yml

 kubectl apply -f .\mnist-job-with-gpu.yml

 ```

### Get job

```powershell

kubectl get job

 ```

### Get pod details

```powershell

 kubectl get pods

 ```

 kubectl create namespace gpu-resources

kubectl apply -f .\nvidia-device-plugin-ds.yaml