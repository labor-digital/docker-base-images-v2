# Set default environment variables
export APACHE_WEBROOT=${APACHE_WEBROOT:-"/var/www/html"}
export APACHE_LOG_DIR=${APACHE_LOG_DIR:-"/var/www/logs"}
export PROJECT_ENV=${PROJECT_ENV:-"prod"}
export DEFAULT_OWNER=${DEFAULT_OWNER:-"www-data.www-data"}
export DEFAULT_PERMISSIONS=${DEFAULT_PERMISSIONS:-"u=rwX,g=rwX,o-rwx"}
export HONOR_PERMISSION_MARKERS=1

# Simple helper to make sure a given directory exists. If it not exists it will create it recursively
# It will also call setPerms() on the directory if you pass additional permissions
# as a second parameter. The directory will be created as the www-data user
# @param $directory The path to the directory to create if it does not exist
# @param $permissions By default "u=rwX,g=rwX,o-rwx" but can be set to any other permission value
ensure_dir() {
	DIR="$1"
	if [[ -d "$DIR" ]]; then
		ensure_perms "$DIR"
	else
		# Create the directory recursively and set the default permissions
		# The problem with mkdir -p is, that the parent directories are created as root:root and -m
		# does not work as expected
		IFS="/" read -ra PARTS <<< "$DIR"
        TEST_DIR=""
		export HONOR_PERMISSION_MARKERS="0"
        for i in "${PARTS[@]}"; do
          	TEST_DIR="$TEST_DIR/$i"
			if [ "$TEST_DIR" = "" ] || [ "$TEST_DIR" = "/" ]; then
				TEST_DIR="";
			elif [ ! -d "$TEST_DIR" ]; then
				mkdir -p "$TEST_DIR"
				ensure_perms "$TEST_DIR"
			fi
		done
		export HONOR_PERMISSION_MARKERS="1"
	fi
}

# Helper to make sure a directory has the correct permissions, recursively.
# BUT it will assume that between runs the permissions will not change
# therefore it writes a marker file into the directory to check if it already
# processed the file or not.
#
# This is used for volume mounts in your production environment.
# You can call this function on a mounted directory to ensure the permissions are set correctly
# Every subsequent boot will not update the permissions again as long as the marker file exists
#
# Accepts 2 parameters
# @param $directory The path to the directory to set the permissions for
# @param $permissions By default "u=rwX,g=rwX,o-rwx" but can be set to any other permission value
ensure_perms() {
	DIR="$1"
	STAT="${2:-"$DEFAULT_PERMISSIONS"}"
	HONOR_MARKER="${HONOR_PERMISSION_MARKERS:-\"1\"}"
	WRITE_MARKER="${WRITE_PERMISSION_MARKERS:-\"0\"}"

	# Check if we got a directory or skip
	if [ -d "$DIR" ]; then
		:
	elif [ -e "$DIR" ]; then
		echo "Setting permissions for $DIR to: $STAT"
		chown -R "$DEFAULT_OWNER" "$DIR"
		chmod -R "$STAT" "$DIR"
		return
	else
		echo "FAIL: $DIR does not exist - skip!"
		return
	fi

	# Update the permissions if we don't have the marker yet
	MARKER_FILE_NAME="$DIR/perms.set"
	if [ -f "$MARKER_FILE_NAME" ] && [ "$HONOR_MARKER" = "1" ]; then
		echo "Permissions for $DIR should be correct (marker exists at: $MARKER_FILE_NAME)"
	else
		echo "Setting permissions for $DIR to: $STAT"
		if [ "$WRITE_PERMISSION_MARKERS" = "1" ]; then
			touch "$MARKER_FILE_NAME"
		fi
		chown -R "$DEFAULT_OWNER" "$DIR"
		chmod -R "$STAT" "$DIR"
	fi
}


# Helper to call the /opt/permissions.sh file if it exists
set_permissions() {
	if [ -f "/opt/project/permissions.sh" ]; then
		source /opt/project/permissions.sh
	fi
}

# Helper to call the /opt/permissions.sh file if it exists but
# the ensure_perms helper will NOT check for markers and forcefully update the permissions
set_permissions_forced() {
	export HONOR_PERMISSION_MARKERS="0"
	set_permissions
	export HONOR_PERMISSION_MARKERS="1"
}

# Used as a hook to run the .bashrc script of our dev container
if [ -f "/root/bashrc-dev.sh" ]; then
	source /root/bashrc-dev.sh
fi