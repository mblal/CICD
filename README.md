# CICD
The first idea here is to create a way to build and deploy applications (let's start with nodeJs app).
We try to use redhat s2i framworke to cover build application stage as defined by s2i
And then come deployment stage with k8s and creation of differents objects needed by the app ( Service, ConfigMap, Ingress ...)


### STEP 1: Build customized docker base image.
```
sudo docker build -t mb-node - < Dockerfile.yaml
```
```
sudo docker tag mb-node:16.13 mblcontainerize/node:latest
```
```
sudo docker push mblcontainerize/node:latest
```

### STEP 2: S2I build

EXAMPLE 
```
SOURCE_CODE_DIR= my_app/
DCOKER_IMAGE=mblcontainerize/node:latest
```
Here we tell to s2i to ignore .git contained in SOURCE_CODE_DIR, because its presence create some build troubles

```
sudo s2i build -c ${SOURCE_CODE_DIR} ${DOCKER_IMAGE} ${OUTPUT_IMAGE} --exclude "(^|/)\.git|.bindingroot(/|$)"
```
### STEP 3: LOCAL DOCKER IMAGE

Once e we have a docker image with our source code, we have to store in docker registry to make a kubernetes deployement later, here is a sample example to deploy a local registry

```
https://docs.docker.com/registry/deploying/
```
Once your registry is deployed, tag and push your image just build with s2i

```
docker tag my_app_im:latest localhost:5000/my-app-im
docker push localhost:5000/my-app-im
```
He, here image using docker without sudo (https://docs.docker.com/engine/install/linux-postinstall/)

### STEP 3: Kubernetes deployment

```
kubectl create secret docker-registry myregistrykey --docker-server=localhost:5000 --docker-username=<username> --docker-password=<password> --docker-email=<email>
```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: my-app
  name: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: my-app
    spec:
      containers:
      - image: localhost:5000/my-app-im
        name: my-app-im-w8fvd
        resources: {}
      imagePullSecrets:
      - name: myregistrykey
status: {}
```

