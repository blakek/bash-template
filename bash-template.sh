#!/usr/bin/env bash
set -eu -o pipefail

##
# Description: Explain what the script is for. This is helpful if the script is
# discovered outside a repository.
# Date: 2017-01-31
# Written by:
#   - Blake Knight <oss.ideas@gmail.com> (http://blakek.me/)
##

# The directory of the currently running file
declare -r __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The filename of the currently running file
declare -r __filename="$(basename "${BASH_SOURCE[0]}")"

cleanup() {
	sshPID="$1"
	kill sshPID
}

exampleFn() {
	# When naming arguments, you should declare local variables. This prevents
	# variables from being accidentally overwritten.
	local greeting="$1"
	local user="${2:-World}"

	# Wrap variables in quotes to prevent globbing and word splitting (unless
	# you have a reason not to). Prefer enclosing variables in curly braces when
	# the variable is not used alone.
	echo "${greeting}, ${user}!"
}

variadicFn() {
	local arg1="$1"
	shift
	local arg2="$1"
	shift

	# To get the remaining arguments as an array, make sure to save the values
	# as an array using `$@`.
	local restArray=("$@")
	# To get the remaining arguments as a string, use `$*`
	local restString="$*"

	echo "${arg1} ${arg2}"
	echo "${restArray[*]}"
	echo "$restString"
}

# Use a "main" function that everything is passed to
main() {
	exampleFn 'Hello'

	variadicFn This is an example with many arguments

	# Example: start process in background and kill it if this is killed
	ssh user@example.com &
	sshPID=$!
	trap "cleanup ${sshPID}" EXIT

	# If your program is large and broken up well, you can opt to have the
	# cleanup in the same location as your logic.  However, this can get messy
	# quickly, so use wisely.
	# Example: remove a temporary file if killed.  Note, the semicolon is
	# necessary.
	tempFile="$(mktemp)"
	trap "{ rm -f ${tempFile}; }" EXIT
}

main "$@"
