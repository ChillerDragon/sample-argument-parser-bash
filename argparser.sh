#!/bin/bash

err() {
	printf '%s\n' "$1" 1>&2
	exit 1
}

log() {
	printf '%s\n' "$1"
}

parse_args() {
	local arg
	local end_args=0
	while :
	do
		[ "$#" -gt 0 ] || break

		arg="$1"
		shift

		if [ "$arg" == "--" ]
		then
			end_args=1
		elif [ "$end_args" == 0 ] && [ "${arg::2}" == "--" ]
		then
			if [[ "$arg" == "--output="* ]]
			then
				output="${arg#*=}"
				log "output: $output"
			elif [ "$arg" == "--output" ]
			then
				output=$1
				shift
				log "output: $output"
			else
				err "unknown option $arg"
			fi
		elif [ "$end_args" == 0 ] && [ "${arg::1}" == "-" ]
		then
			while IFS='' read -r -d '' -n 1 flag
			do
				if [ "$flag" == "v" ]
				then
					log "got verbose flag"
				elif [ "$flag" == "f" ]
				then
					log "got force flag"
				elif [ "$flag" == "o" ]
				then
					output="$1"
					shift
					log "output: $output"
				else
					err "error unknown flag $flag"
				fi
			done < <(printf %s "${arg:1}")
		else
			log "got positional argument: $arg"
		fi
	done
}

parse_args "$@"

