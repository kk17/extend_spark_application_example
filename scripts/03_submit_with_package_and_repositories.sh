#!/usr/bin/env bash
# bash cheat sheet: https://devhints.io/bash
set -euox pipefail
IFS=$'\n\t'

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
HOME_DIR="$( cd "${DIR}/.." ; pwd -P )"
HOME_DIR_NAME=`basename ${HOME_DIR}`
FILENAME=`basename "$0"`

NETWORK="${HOME_DIR_NAME}_default"

docker run -it --rm \
 -v ${HOME_DIR}:/workspace \
 -v ${HOME_DIR}:/workspace02 \
 --network ${NETWORK} \
 jupyter/pyspark-notebook \
 /usr/local/spark/bin/spark-submit -v \
   --name $FILENAME \
   --master spark://spark-master:7077 \
   --packages ${PACKAGES} \
   --repositories ${REPOSITORIES} \
   --class net.kk17.extend_spark_application_example.CountingApp \
   /workspace02/target/scala-2.11/extend_spark_application_example_2.11-0.0.1.jar /workspace/README.md /tmp/output

# failed with unknow reason

