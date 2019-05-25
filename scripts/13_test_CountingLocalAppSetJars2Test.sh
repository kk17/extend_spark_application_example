#!/usr/bin/env bash
# bash cheat sheet: https://devhints.io/bash
set -euox pipefail
IFS=$'\n\t'

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
HOME_DIR="$( cd "${DIR}/.." ; pwd -P )"
HOME_DIR_NAME=`basename ${HOME_DIR}`
FILENAME=`basename "$0"`

NETWORK="${HOME_DIR_NAME}_default"

sbt "test:testOnly *CountingLocalAppSetJars2Test"
