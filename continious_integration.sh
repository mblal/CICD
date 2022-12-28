#!/bin/bash

#  Exit immediately if a command exits with a non-zero status
set -eE

export BEGIN_TIME=$(date +%s)
export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}i")" && pwd)"

if [[ -z "${APP_NAME}" ]]; then
	echo "Environment variable APP_NAME is not defined"
	exit 1
fi
