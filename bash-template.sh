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

exampleFn() {
	# Arguments are declared like this:
	declare name="$1"
	
	# Always use quotes unless you have a reason not to.  Prefer enclosing variables in curly braces.
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
}

main
