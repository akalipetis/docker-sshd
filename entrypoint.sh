#! /bin/bash

set -e

if [[ -n "${SSH_PASSWORD}" ]]; then
    echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd
fi

SSH_USER_HOME="~${SSH_USER}"
eval SSH_USER_HOME=$SSH_USER_HOME
if [[ ! -d $SSH_USER_HOME ]]; then
    mkdir -p $SSH_USER_HOME
    chown "${SSH_USER}:${SSH_USER}" $SSH_USER_HOME
fi

chsh -s /bin/bash $SSH_USER

exec "$@"
