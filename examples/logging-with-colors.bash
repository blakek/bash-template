log() {
	local -Ar formats=(
		[reset]='\e[0m'
		[none]='\e[0m'
		[bold]='\e[1m'
		[italic]='\e[3m'
		[underline]='\e[4m'
		[strikethrough]='\e[9m'
		[white]='\e[1;37m'
		[black]='\e[0;30m'
		[blue]='\e[0;34m'
		[light_blue]='\e[1;34m'
		[green]='\e[0;32m'
		[light_green]='\e[1;32m'
		[cyan]='\e[0;36m'
		[light_cyan]='\e[1;36m'
		[red]='\e[0;31m'
		[light_red]='\e[1;31m'
		[purple]='\e[0;35m'
		[light_purple]='\e[1;35m'
		[yellow]='\e[0;33m'
		[light_yellow]='\e[1;33m'
		[gray]='\e[0;30m'
		[light_gray]='\e[0;37m'
	)

	local style="none"

	if [[ ${formats[$1]+_} ]]; then
		style="$1"
		shift
	fi

	# shellcheck disable=SC2059 # Allow passing in printf-style formatting
	printf -v message "$@"
	printf "%b%s%b\n" "${formats["$style"]}" "${message:-}" "${formats['reset']}"
}

error() { log red "$@" >&2; }
info() { log blue "$@"; }
warn() { log yellow "$@"; }
panic() {
	# shellcheck disable=SC2059 # Allow passing in printf-style formatting
	printf -v message "$@"
	log light_red 'Error: %s' "${message:-}" >&2
	exit 1
}

box() {
	local -r padding="$(printf '%*s\n' "${COLUMNS:-80}" ' ' | tr ' ' '-')"
	local -i width=$((${#1} + 4))
	printf '%0.*s\n- %0.*s -\n%0.*s\n' "$width" "$padding" ${#1} "${1}" "$width" "$padding"
}

box 'this is a simple box'

echo

log 'this is a %s log' 'normal'
info 'this is informational'
warn 'this is a warning'
error 'this is an error'
panic 'this is a %s' 'panic'
