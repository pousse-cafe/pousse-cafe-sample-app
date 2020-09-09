#!/bin/bash

set -e

if [[ $# < 1 ]]
then
	echo "No goal provided"
	exit 1
fi

cd target/generated-sources/archetype/
mvn "$@"
