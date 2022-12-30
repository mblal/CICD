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

EXAMPlE 
```
SOURCE_CODE_DIR= my_app/
DCOKER_IMAGE=mblcontainerize/node:latest
```
```
sudo s2i build -c ${SOURCE_CODE_DIR} ${DOCKER_IMAGE} ${OUTPUT_IMAGE} --exclude "(^|/)\.git|.bindingroot(/|$)"
```
Here we tell to s2i to ignore .git contained in SOURCE_CODE_DIR, because its presence create some build troubles
