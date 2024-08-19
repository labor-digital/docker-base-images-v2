#!/bin/bash
# Alias for "npm" but will not kill your console when the script fails -> You should only use this
# manually in a development environment
n() {
  sudo -u node -EH /usr/local/bin/npm "$@"
  if [ "$1" = "run" ] || [ "$1" = "test" ]; then :; else set_permissions_forced; fi
}

# Global access to the npm executable, executed as node user
npm(){
  sudo -u node -EH /usr/local/bin/npm "$@"
  if [ $? -ne 0 ]; then exit 1; fi
  if [ "$1" = "run" ] || [ "$1" = "test" ]; then :; else set_permissions_forced; fi
}

# Global access to the "node-check-updates" command, executed as node user
ncu(){
	sudo -u node -EH /usr/local/bin/ncu "$@"
}