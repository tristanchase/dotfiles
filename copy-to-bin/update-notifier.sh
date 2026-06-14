#!/bin/sh -e

___print_updates() {
	local u=
	local icon="$HOME/.cache/updates-available.icon"
	read u < "$1"
	if [ -n "$u" ]; then
		if [ "$u" -gt 0 ]; then
			printf "[update "$u"]" > "$icon"
		elif [ "$u" = "0" ] && [ -e "$icon" ]; then
			# Remove icon file
			rm -f "$icon"
		fi
	fi
}

___update_cache() {
	local mycache=$1 flock="$1.lock"
	# Now we actually have to do hard computational work to calculate updates.
	# Let's try to be "nice" about it:
	renice 10 $$ >/dev/null 2>&1 || true
	ionice -c3 -p $$ >/dev/null 2>&1 || true
	# These are very computationally intensive processes.
	# Background this work, have it write to the cache files,
	# and let the next cache check pick up the results.
	# Ensure that no more than one of these run at a given time
	flock -xn "$flock" apt-get -s -o Debug::NoLocking=true upgrade | grep -c ^Inst >$mycache 2>/dev/null &
}

___update_needed() {
	# Checks if we need to update the cache.
	local mycache=$1
	# The cache doesn't exist: create it
	[ ! -e "$mycache" ] && return 0
	d0=$(($(stat -c %Y $mycache 2>/dev/null)-5))
	d1=$(stat -c %Y /var/lib/apt)
	d2=$(stat -c %Y /var/lib/apt/lists)
	d3=$(stat -c %Y /var/log/dpkg.log)
	now=$(date +%s)
	delta=$(($now-$d0))
	if [ $d0 -lt 0 ] || [ $d0 -lt $d1 ] || [ $d0 -lt $d2 ] || [ $d0 -lt $d3 ] || [ 3605 -lt $delta ] ; then
		return 0
	else
		return 1
	fi
}

__updates_available() {
	local mycache="$HOME/.cache/updates-available"
	# If mycache is present, use it
	[ -r $mycache ] && ___print_updates "$mycache"
	# If we really need to do so (mycache doesn't exist, or the package database has changed),
	# background an update now
	___update_needed "$mycache" && ___update_cache "$mycache"
}

__updates_available
exit 0
