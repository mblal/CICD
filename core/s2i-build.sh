#!/bin/bash
defaut_s2i_scripts_path="${BASEDIR}/k8s/techno/${SOCLE}/.s2i"
project_s2i_scripts_path="${BASEDIR}/../conf/${APP_NAME}/.s2i"
elected_s2i=""
echo $defaut_s2i_scripts_path
echo $project_s2i_scripts_path
if [[ -d "${defaut_s2i_scripts_path}" ]]; then
  elected_s2i="${defaut_s2i_scripts_path}"
fi
if [[ -d "${project_s2i_scripts_path}" ]]; then
  elected_s2i="${project_s2i_scripts_path}"
fi

git clone --branch $GIT_SOURCE_BRANCH $GIT_SOURCE $APP_NAME

echo "We are copying .s2i scripts from ${elected_s2i}"

cp -R $APP_NAME "${APP_NAME}_TMP"
cp -R ${elected_s2i} "${APP_NAME}_TMP/"
SOURCE_CODE="${APP_NAME}_TMP/"
OUTPUT_IMAGE=`echo "${APP_NAME}_im"|awk '{print tolower($0)}'`
echo ${DOCKER_IMAGE}
echo ${OUTPUT_IMAGE}
#sudo s2i build $SOURCE_CODE ${DOCKER_IMAGE} ${OUTPUT_IMAGE}
sudo s2i build -c ${SOURCE_CODE} ${DOCKER_IMAGE} ${OUTPUT_IMAGE} --exclude "(^|/)\.git|.bindingroot(/|$)"

# Push build image in a docker repository

DOCKER_IMAGE_NORMALIZED_NAME=`echo "${OUTPUT_IMAGE}" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g'`
DOCKER_IMAGE_NORMALIZED_NAME=`echo "${DOCKER_IMAGE_NORMALIZED_NAME}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9.-]//g'`

echo $DOCKER_IMAGE_NORMALIZED_NAME
if [[ -z "${DOCKER_REPO_URL}" ]]; then
  echo "You didn't define a docker repository url to push your image just built."
  exit 1
fi
docker tag ${OUTPUT_IMAGE}:latest ${DOCKER_REPO_URL}/${DOCKER_IMAGE_NORMALIZED_NAME}
docker push ${DOCKER_REPO_URL}/${DOCKER_IMAGE_NORMALIZED_NAME}
