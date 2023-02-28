#!/bin/bash

if [ "${*}" == "./bin/rails server -b 0.0.0.0" ]; then
./bin/rails db:prepare
fi

exec "${@}"
