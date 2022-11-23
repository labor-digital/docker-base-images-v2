#!/bin/bash
# Switches between two callables based on the APP_COMPOSER_VERSION environment variable,
# with a preference for version 1 if not specified.
# Arg1: Function to execute for v1
# Arg2: Function to execute for v2
# Arg3: Arguments passed to the external method, should be "$@"
_composerSwitch(){
  local version=${APP_COMPOSER_VERSION:-"1"}
  echo "Use composer version: $version"
  if [ "$version" = "1" ]; then
    eval "$1 ${@:3}"
  else
    eval "$2 ${@:3}"
  fi
}

# Actions to be performed after each composer action
_afterComposer(){
	 if [ "$1" = "run" ] || [ "$1" = "test" ]; then :; else set_permissions_forced; fi
}

# Alias for "composer" but will not kill your console when the script fails -> You should only use this
# manually in a development environment
c1() {
	 sudo -u www-data -EH /usr/local/bin/composer.phar "$@"
	 _afterComposer "$1"
}
c2() {
	 sudo -u www-data -EH /usr/local/bin/composer2.phar "$@"
	 _afterComposer "$1"
}
c() {
  _composerSwitch "c1" "c2" "$@"
}

# Global executable to run composer tasks
composer1(){
	sudo -u www-data -EH /usr/local/bin/composer.phar "$@"
	if [ $? -ne 0 ]; then exit 1; fi
	_afterComposer "$1"
}
composer2(){
	sudo -u www-data -EH /usr/local/bin/composer2.phar "$@"
	if [ $? -ne 0 ]; then exit 1; fi
	_afterComposer "$1"
}
composer(){
  _composerSwitch "composer1" "composer2" "$@"
}
