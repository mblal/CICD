export OUTPUT_IMAGE=`echo "${APP_NAME}_im"|awk '{print tolower($0)}'`
DOCKER_IMAGE_NORMALIZED_NAME=`echo "${OUTPUT_IMAGE}" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g'`
export DOCKER_IMAGE_NORMALIZED_NAME=`echo "${DOCKER_IMAGE_NORMALIZED_NAME}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9.-]//g'`

export NORMALIZED_APP_NAME=`echo "${APP_NAME}" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g'`

case "$1" in
	"build")
	      action $1
		;;
  "deploy")
        action $1
  ;;
esac