#!/bin/bash
cp -R $APP_NAME "${APP_NAME}_TMP"
cp -R conf/${APP_NAME}/.s2i "${APP_NAME}_TMP/"
SOURCE_CODE="${APP_NAME}_TMP/"
OUTPUT_IMAGE = "${APP_NAME}_im" | awk '{print tolower($0)}'
echo ${DOCKER_IMAGE}
#sudo s2i build $SOURCE_CODE ${DOCKER_IMAGE} ${OUTPUT_IMAGE}
sudo s2i build -c ${SOURCE_CODE} ${DOCKER_IMAGE} ${OUTPUT_IMAGE} --exclude "(^|/)\.git|.bindingroot(/|$)"
