#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# start sshd
exec /usr/sbin/sshd -e "$@" 
