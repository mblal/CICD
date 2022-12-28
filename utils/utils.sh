#!/bin/bash
function action() {
	case "$1" in
		"build")
			source $BASEDIR/core/s2i-build.sh
			;;
	esac
	
}
export -f action
