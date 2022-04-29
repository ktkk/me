#!/bin/sh

set +x

FLAGS="-H -I -n -r --exclude-dir=.git --exclude=todo.sh"

MATCH="TODO"

grep $FLAGS $MATCH .
