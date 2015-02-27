#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_battery_remain() {
	if command_exists "pmset"; then
		pmset -g batt | awk 'NR==2 { gsub(/;/,""); print $4 }'
	elif command_exists "upower"; then
		format_time $(average $(upower_time_to_empty; upower_time_to_full))
	fi
}

main() {
	print_battery_remain
}
main
