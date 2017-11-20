#!/usr/bin/env bash
set -eu -o pipefail

##
# Description: Explain what the script is for
# Date: 2017-01-31
# Written by:
#   - Blake Knight <oss.ideas@gmail.com> (http://blakek.me/)
##

__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__filename="$(basename "${BASH_SOURCE[0]}")"

cleanup() {
	# If there is any cleanup to do on an exit, do it here.
	sshPID="$1"
	kill sshPID
}

exampleFn() {
	# Arguments are declared like this:
	local name="$1"
	local anotherArg="$2"
	
	# Always use quotes unless you have a reason not to.  Prefer enclosing
	# variables in curly braces.
	echo "Hello, ${name}!"
}

variadicFn() {
	local arg1="$1"; shift
	local arg2="$1"; shift
	local rest="$@"

	# ...
}

main() {
	# Use a "main" function that everything is passed to
	exampleFn 'World'
	
	# Example: start process in background and kill it if this is killed
	ssh user@example.com &
	sshPID=$!
	trap "cleanup ${sshPID}" EXIT
	
	# If your program is large and broken up well, you can opt to have the
	# cleanup in the same location as your logic.  However, this can get messy
	# quickly, so use wisely.
	# Example: remove a temporary file if killed.  Note the semicolon is needed.
	tempFile="$(mktemp -p /tmp)"
	trap "{ rm -f ${tempFile}; }" EXIT
}

main "$@"
