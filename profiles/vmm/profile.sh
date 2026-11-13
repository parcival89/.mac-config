#!/usr/bin/env bash

# Load base profile
source "$(dirname $0)/../base/profile.sh"

# Configuration
## General
export VMM_PROFILE_HOME="$PROFILES_HOME/vmm"
export VMM_PROFILE="$VMM_PROFILE_HOME/profile.sh"
export CURRENT_PROFILE="$VMM_PROFILE"

## User
export GIT_USER_NAME="Sander Paulus"
export GIT_USER_EMAIL="s.paulus@vmm.be"

# Execution
## Git
alias git="git -c user.name='$GIT_USER_NAME' -c user.email=$GIT_USER_EMAIL"
