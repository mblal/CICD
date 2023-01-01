#!/bin/bash

#  Exit immediately if a command exits with a non-zero status
set -eE

export BEGIN_TIME=$(date +%s)
export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}i")" && pwd)"

if [[ -z "${APP_NAME}" ]]; then
	echo "Environment variable APP_NAME is not defined"
	exit 1
fi
source $BASEDIR/../conf/$APP_NAME/env.sh
source $BASEDIR/utils/utils.sh

# Display come env variables.
echo "Context directory : $BASEDIR"
echo $GIT_SOURCE
echo "$2 of the application : $APP_NAME"

case "$1" in
	"paas")
	       	source $BASEDIR/core/$1.sh $2
		;;
esac
