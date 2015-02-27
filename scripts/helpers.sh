get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

is_osx() {
	[ $(uname) == "Darwin" ]
}

command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

format_time() {
	seconds=$1
	((h=${seconds}/3600))
	((m=(${seconds}%3600)/60))
	((s=${seconds}%60))
	printf "%02d:%02d\n" $h $m
}

# Takes integers separated by newlines and outputs the sum
average() {
	sum=0
	number_of_values=0
	for value in $@; do
		if (($value > 0)); then
			((sum=$sum+$value))
			((number_of_values=$number_of_values+1))
		fi
	done
	((sum=$sum/$number_of_values))
	echo $sum
}

dbus_value() {
	battery=$1
	value=$2
	dbus-send --print-reply=literal --system \
		--dest=org.freedesktop.UPower $battery \
		org.freedesktop.DBus.Properties.Get string:org.freedesktop.UPower \
		$value
}

upower_time_to_empty() {
	for battery in $(upower -e | grep battery); do
		dbus_value $battery string:TimeToEmpty | awk '{print $3}'
	done
}

upower_time_to_full() {
	for battery in $(upower -e | grep battery); do
		dbus_value $battery string:TimeToFull | awk '{print $3}'
	done
}

upower_percentage() {
	for battery in $(upower -e | grep battery); do
		dbus_value $battery string:Percentage | awk '{print $3}'
	done
}
