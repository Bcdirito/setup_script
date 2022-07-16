#!/bin/bash

println() {
	local text="$1"; shift

	printf "\n$text\n"
}

cask_is_installed() {
	brew ls --formula -1 | grep -Fqx "$1"
}

python_is_installed() {
	python3 --version | grep -Fqx "Python"
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
			brew upgrade postgresql
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
			brew upgrade node
		else
			println "node is up to date"
		fi
	else
		println "installing node"
		brew install node
	fi
}

update_or_install_python() {
	println "checking python"
	
	if python_is_installed ; then
		if ! brew outdated --quiet python3 ; then
			println "updating python"
			brew upgrade python3
		else
			println "python is up to date"
		fi
	else
		println "installing python"
		brew install python3
	fi
}

update_or_install_all() {
	println "running insert/update all script"

	update_or_install_brew
	update_or_install_golang
	update_or_install_postgres
	update_or_install_node
	update_or_install_python

	println "finished insert/update all script"
}

update_or_install_all
