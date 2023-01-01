#!/bin/bash
function action() {
	case "$1" in
		"build")
			source $BASEDIR/core/s2i-build.sh
			;;
    "deploy")
      source $BASEDIR/core/k8s-deploy.sh
      ;;
  esac
	
}
export -f action
