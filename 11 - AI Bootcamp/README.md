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

#kubeflow

 $NAMESPACE = "kubeflow"
 kubectl create namespace $NAMESPACE

 $VERSION = "v0.2.2"

$APP_NAME = "my-kubeflow"
ks init $APP_NAME
cd $APP_NAME
ks env set default --namespace $NAMESPACE

ks registry add kubeflow github.com/kubeflow/kubeflow/tree/$VERSION/kubeflow

ks pkg install kubeflow/core@$VERSION
ks pkg install kubeflow/tf-serving@$VERSION

ks generate kubeflow-core kubeflow-core

ks param set kubeflow-core cloud aks

ks apply default -c kubeflow-core


