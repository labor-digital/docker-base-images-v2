#!/bin/bash
# Actions to be performed after each composer action
_afterComposer(){
	 if [ "$1" = "run" ] || [ "$1" = "test" ]; then :; else set_permissions_forced; fi
}

# Alias for "composer" but will not kill your console when the script fails -> You should only use this
# manually in a development environment
c() {
	 sudo -u www-data -EH /usr/local/bin/composer.phar "$@"
	 _afterComposer "$1"
}

# Global executable to run composer tasks
composer(){
	sudo -u www-data -EH /usr/local/bin/composer.phar "$@"
	if [ $? -ne 0 ]; then exit 1; fi
	_afterComposer "$1"
}
