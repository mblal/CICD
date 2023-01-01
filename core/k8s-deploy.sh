# @TODO connect to the k8s cluster 

echo "Display of some variables"

echo $DOCKER_IMAGE_NORMALIZED_NAME;
echo $DOCKER_REPO_URL
template="${BASEDIR}/../conf/${APP_NAME}/template.yaml"
envsubst <"${template}" >"${template}.tmp"

echo "-------------------------------------------------------------"
kubectl create -f "${BASEDIR}/../conf/${APP_NAME}/template.yaml.tmp"
echo "-------------------------------------------------------------"