#!/usr/bin/env bash

if [[ "$(tty)" == *"/dev/tty"* ]]; then
    export PS1='\w${GUIX_ENVIRONMENT:+ [guix]} \$ '
else
    export PS1='\w${GUIX_ENVIRONMENT:+ [guix]} \[\033[33m\]\[\033[00m\]  '
    eval "$(direnv hook bash)"
fi
