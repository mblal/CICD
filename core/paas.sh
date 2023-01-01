DOCKER_IMAGE_NORMALIZED_NAME=`echo "${OUTPUT_IMAGE}" | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g'`
export DOCKER_IMAGE_NORMALIZED_NAME=`echo "${DOCKER_IMAGE_NORMALIZED_NAME}" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9.-]//g'`

case "$1" in
	"build")
	       	action $1
		;;
esac