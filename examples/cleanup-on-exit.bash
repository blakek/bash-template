#!/usr/bin/env bash
set -eu -o pipefail

##
# Generally, if a script modifies things outside itself, it's a good idea to
# clean up in case of failure. This includes stopping background jobs, removing
# temporary files, etc.
#
# In bash, this "cleanup" is done using the built-in `trap` function.
#
# It can be called using a function name or inline as seen in the examples.
#
# Note, multiple functions cannot be registered for a single signal. Instead,
# you may call them using the inline method or use a function to call all the
# other functions.
#
# For more information, check out:
# - `help trap`
##

cleanup() {
	echo "✔️ Removing background task"
	processID="$1"
	kill "$processID"
}

example_callCleanupFunction() {
	echo '… Starting background task'
	ssh user@example.com &
	sshProcessID=$!

	echo '… Setting up trap if script exits'
	trap 'cleanup ${sshProcessID}' TERM
}

example_inlineCleanup() {
	# Removes a temporary file if exited.  The final semicolon is necessary.
	tempFile="$(mktemp)"
	echo "… Created file at ${tempFile}"

	echo '… Setting up trap if script exits'
	trap '{ echo "✔️ removing file"; rm -f ${tempFile}; }' EXIT
}

example_callCleanupFunction
example_inlineCleanup

echo '… Waiting to call TERM signal'
sleep 1
kill -s TERM $$
exit
