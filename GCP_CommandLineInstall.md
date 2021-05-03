## GCP Command Line Install

After clicking on the "CONFIGURE" button select the second tab named: "Deploy via command line"

Generate a license key and save it to the disk (e.g. `license.yaml`)

If it doesn't exists already create the namespace you want to work in:

```shell
kubectl create namespace akka-dev
```

Install the license key into the namespace:

```shell
kubectl apply -f license.yaml --namespace akka-dev
```
The output will be like:
```
secret/akka-cloud-platform-1-license created
```

Take note of the secret name (in this case: `akka-cloud-platform-1-license`)

If it's not already installed you need to install the GCP Marketplace `applications` CRD in the cluster:

```shell
kubectl apply -f "https://raw.githubusercontent.com/GoogleCloudPlatform/marketplace-k8s-app-tools/master/crd/app-crd.yaml"
```

Now you can install the operator with a classic Helm command (sustituting the `reportingSecret`):

```shell
helm upgrade -i akka-operator akka-operator-helm/akka-operator \
  --namespace default \
  --set provider.name=gcp \
  --set gcp.deployer=false \
  --set reportingSecret=akka-cloud-platform-1-license
```

Make sure you update the Akka Microservices CRD:

```shell
kubectl apply -f  https://lightbend.github.io/akka-operator-helm/akka-operator/crds/v1/akka-microservices-crd.yml
```
