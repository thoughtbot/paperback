#!/bin/bash

commands=$(paperback help | cut -f 4 -d" " -s)

if grep -q "$1" <<< "$commands"; then
	paperback "$@"
else
	exec "$@"
fi
