#!/bin/bash

println() {
	local text="$1"; shift

	printf "\n$text\n"
}

cask_is_installed(){
	brew ls --formula -1 | grep -Fqx "$1"
}

update_or_install_brew() {
  	if ! command -v brew >/dev/null; then
		println "installing homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		
	else
		println "brew already installed"
		brew update
	fi
}

update_or_install_golang() {
	println "checking golang"

	if cask_is_installed go ; then
		if ! brew outdated --quiet go ; then
			println "updating golang"
			brew upgrade go
		else
			println "golang up to date"
		fi
	else
		println  "installing golang"
		brew install go
	fi
}

update_or_install_postgres() {
	println "checking postgres"

	if cask_is_installed postgresql ; then
		if ! brew outdated --quiet postgresql ; then
			println "updating postgres"
		else
			println "postgres up to date"
		fi
	else
		println "installing postgres"
		brew install postgresql
	fi
}

update_or_install_node() {
	println "checking node"
	
	if cask_is_installed node ;  then
		if ! brew outdated --quiet node ; then
			println "updating node"
		else
			println "node is up to date"
		fi
	else
		println "installing node"
	fi
}

update_or_install_all() {
	println "running insert/update all script"

	update_or_install_brew
	update_or_install_golang
	update_or_install_postgres
	update_or_install_node

	println "finished insert/update all script"
}

# rails?
# npm?
# react?
# python3 -> append to file, then run brew command
# run full suite of installs/updates
