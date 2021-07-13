#!/usr/bin/env bash
set -eu -o pipefail

##
# Examples showing basic usage of function variables
##

##
# When developing, it's common to stub out functions and loops before implementing
# them. You can simply use `true` to make a valid, do-nothing bash function.
##
noop() {
	true
}

sayHello() {
	# Using `declare` or `local` helps prevent variables from being
	# accidentally overwritten.
	local greeting="$1"
	local user="${2:-World}"

	# Wrap variables in quotes to prevent globbing and word splitting (unless
	# you need those). Prefer enclosing variables in curly braces when the
	# variable is not used alone.
	echo "${greeting}, ${user}!"
}

##
# Making a variadic function in Bash is easy. You can also get a few necessary
# positional arguments using `shift`.
##
variadicFn() {
	local arg1="$1"
	shift
	local arg2="$1"
	shift

	# To get the remaining arguments as an array, make sure to save the values
	# as an array using `$@`.
	local -a restArray=("$@")

	# To get the remaining arguments as a string, use `$*`
	local restString="$*"

	echo "arg1 = ${arg1}"
	echo "arg2 = ${arg2}"

	echo "restString = $restString"

	echo "restArray ="
	for part in "${restArray[@]}"; do
		echo "- $part"
	done
}
