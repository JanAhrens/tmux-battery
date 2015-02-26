#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_battery_percentage() {
	# percentage displayed in the 2nd field of the 2nd row
	if command_exists "pmset"; then
		pmset -g batt | awk 'NR==2 { gsub(/;/,""); print $2 }'
	elif command_exists "upower"; then
		value=$(average $(upower_percentage))
		echo "${value}%"
	fi
}

main() {
	print_battery_percentage
}
main
