# @TODO connect to the k8s cluster 

echo "Display of some variables"

echo $DOCKER_IMAGE_NORMALIZED_NAME;
echo $DOCKER_REPO_URL
template="${BASEDIR}/../conf/${APP_NAME}/template.yaml"
envsubst <"${template}" >"${template}.tmp"

sKINDS="$(yq '.kind' "${template}.tmp" | tr --delete '\n' | sed 's/---/,/g')"
sOBJECT_NAMES="$(yq '.metadata.name' "${template}.tmp" | tr --delete '\n' | sed 's/---/,/g')"

IFS=',' read -ra KINDS <<< "$sKINDS"
IFS=',' read -ra NAMES <<< "$sOBJECT_NAMES"

for i in "${!KINDS[@]}";
do
  kubectl delete ${KINDS[$i]} ${NAMES[$i]} --ignore-not-found=true --grace-period 0 --force
done

echo "-------------------------------------------------------------"
kubectl create -f "${BASEDIR}/../conf/${APP_NAME}/template.yaml.tmp"
echo "-------------------------------------------------------------"
