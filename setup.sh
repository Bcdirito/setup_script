#!/bin/bash

println() {
	local text="$1"; shift

	printf "\n$text\n"
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

update_or_install_brew

# command left to get:
# rails
# golang
# node/npm?
# git
# postgresql
# react?
# python3 -> append to file, then run brew command
# run full suite of installs/updates
