#!/usr/bin/env bash
set -eu -o pipefail

##
# Write a brief description of the script and why it was created. This can be
# helpful if the script is discovered outside a repository.
##

declare -Ar globals=(
	# The directory of the currently running file
	['cwd']="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	# The filename of the currently running file
	['filename']="$(basename "${BASH_SOURCE[0]}")"
	# The script's version
	['version']="1.0.0"
)

showUsage() {
	cat <<-END
		Echos a list of given files
		Usage:
		    ${globals['filename']} [options] <file ...>
		Options:
		    -h, --help     output usage information and exit
		    -V, --version  output the version number and exit
		Positional arguments:
		    files     example list of files for positional argument
	END
}

##
# Use an entry function that everything is passed to. It's often renamed to
# match the filename of the script.
##
templateExample() {
	local -a files

	# Parse arguments
	for arg in "$@"; do
		case "$arg" in
			-h | --help | help)
				showUsage
				exit
				;;
			-V | --version)
				echo "${globals['version']}"
				exit
				;;
			-*)
				printf "Error: unrecognized argument '%s'\n" "$arg" >&2
				exit 1
				;;
			*) files+=("$arg") ;;
		esac
	done

	for file in "${files[@]}"; do
		echo "  - ${file}"
	done
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
	templateExample "$@"
	exit $?
fi

export -f templateExample
