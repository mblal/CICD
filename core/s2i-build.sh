#!/bin/bash
cp -R $APP_NAME "${APP_NAME}_TMP"
cp -R conf/${APP_NAME}/.s2i "${APP_NAME}_TMP/"
SOURCE_CODE="${APP_NAME}_TMP/"
s2i build $SOURCE_CODE ${DOCKER_IMAGE} "${APP_NAME}-im"
