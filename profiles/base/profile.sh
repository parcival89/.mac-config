#!/usr/bin/env bash

# Configuration
## General
export MAC_CONFIG_HOME="$(dirname $0)/../.."
export PROFILES_HOME="$MAC_CONFIG_HOME/profiles"
export BASE_PROFILE_HOME="$PROFILES_HOME/base"
export BASE_PROFILE="$BASE_PROFILE_HOME/profile.sh"
export CURRENT_PROFILE="$BASE_PROFILE"

# Execution
## Profile
alias reload-profile='source $CURRENT_PROFILE'

# General
alias cls='clear'

## oh-my-zsh
function update-zsh-submodules() {
    pushd $MAC_CONFIG_HOME
    git pull --recurse-submodules -f
    popd
}

function add-custom-plugin() {
    pushd $MAC_CONFIG_HOME/zsh/plugins
    git submodule add $1
    popd
}

## Docker
alias docker-rm='docker rm -vf $(docker ps -qa)'
alias docker-rmi='docker rmi -f $(docker images -qa)'

function start-oracle() {
    docker rm -vf oracle-xe-11g
    docker run -d -p 1521:1521 --name oracle-xe-11g vanpeerdevelopment/oracle-xe-11g
}