# Global AI Bootcamp Singapore 2018

## Conatinerize Tensofrlow model

docker build -t nileshgule/tf-mnist .

### Train with 100 steps
time docker run -it nileshgule/tf-mnist --max_steps 100

### Train with 100 steps
time docker run -it nileshgule/tf-mnist --max_steps 1000

### Build GPU image

docker build -t nileshgule/tf-mnist:gpu -f Dockerfile.gpu .

### push the image to container registry

docker push nileshgule/tf-mnist

docker push nileshgule/tf-mnist:gpu


## AKS setup

### Check versions of Kubernetes available

```bash

az aks get-versions `
--subscription "Microsoft Azure Sponsorship" `
--location "South East Asia" `
-o table

az aks get-versions `
--subscription "Microsoft Azure Sponsorship" `
--location "West US 2" `
-o table



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

### Kubeflow Mac

NAMESPACE=kubeflow
VERSION=v0.2.2
APP_NAME=my-kubeflow
ks init ${APP_NAME}
cd ${APP_NAME}
ks env set default --namespace ${NAMESPACE}

# Add a reference to Kubeflow's ksonnet manifests
ks registry add kubeflow github.com/kubeflow/kubeflow/tree/${VERSION}/kubeflow

ks pkg install kubeflow/core@${VERSION}
ks pkg install kubeflow/tf-serving@${VERSION}

ks generate kubeflow-core kubeflow-core

# Customize Kubeflow's installation for AKS or acs-engine
ks param set kubeflow-core cloud aks

# Deploy Kubeflow
ks apply default -c kubeflow-core

kubectl get svc -n=${NAMESPACE}

PODNAME=`kubectl get pods --namespace=${NAMESPACE} --selector="app=tf-hub" --output=template --template="{{with index .items 0}}{{.metadata.name}}{{end}}"`
kubectl port-forward --namespace=${NAMESPACE} $PODNAME 8000:8000

kubectl get nodes "-o=custom-columns=NAME:.metadata.name,GPU:.status.allocatable.alpha\.kubernetes\.io\/nvidia-gpu"

### Check status of pod
kubectl -n ${NAMESPACE} describe pods jupyter-${USERNAME}

kubectl -n ${NAMESPACE} describe pods jupyter-admin

### TF Job

kubectl create -f minst-tf-job-with-gpu.yml

kubectl delete -f minst-tf-job-with-gpu.yml

kubectl get tfjob

kubectl get pod

### Create storage account

az aks show --resource-group aibootcamp --name gpuCluster --query nodeResourceGroup -o tsv

az storage account create --resource-group MC_aibootcamp_gpuCluster_westus2 --name aibcsgstorageaccount --sku Standard_LRS

kubectl apply -f azure-file-sc.yml

kubectl apply -f azure-file-pvc.yml

kubectl get pvc azurefile

kubectl create -f minst-tf-job-volume-mount.yml

kubectl get tfjob

### Distributed tensorflow

docker build -t nileshgule/tf-mnist:distributedgpu -f ./Dockerfile.gpu .

docker push nileshgule/tf-mnist:distributedgpu

#### trnsorflow board
docker build -t nileshgule/tf-mnist:distributed .

docker push nileshgule/tf-mnist:distributed

kubectl create -f minst-tf-job-distributed.yml

kubectl create -f tensor-board.yml

PODNAME=$(kubectl get pod -l app=tensorboard -o jsonpath='{.items[0].metadata.name}')
kubectl port-forward ${PODNAME} 6006:6006

kubectl delete -f minst-tf-job-volume-mount.yml