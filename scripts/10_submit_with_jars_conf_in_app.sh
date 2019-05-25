#!/usr/bin/env bash
# bash cheat sheet: https://devhints.io/bash
set -euox pipefail
IFS=$'\n\t'

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
HOME_DIR="$( cd "${DIR}/.." ; pwd -P )"
HOME_DIR_NAME=`basename ${HOME_DIR}`
FILENAME=`basename "$0"`

NETWORK="${HOME_DIR_NAME}_default"
set -x

docker run -it --rm \
 --network ${NETWORK} \
 -v ${HOME_DIR}/target/scala-2.11/extend_spark_application_example_2.11-0.0.1.jar:/workspace/target/scala-2.11/extend_spark_application_example_2.11-0.0.1.jar\
 -v ${HOME_DIR}/lib_managed/jars/com.typesafe.play/play-json_2.11/play-json_2.11-2.6.9.jar:/workspace/play-json_2.11-2.6.9.jar.jar \
 -v ${HOME_DIR}/lib_managed/jars/com.typesafe.play/play-functional_2.11/play-functional_2.11-2.6.9.jar:/workspace/play-functional_2.11-2.6.9.jar \
 -v ${HOME_DIR}/README.md:/workspace/README.md \
 jupyter/pyspark-notebook \
 /usr/local/spark/bin/spark-submit -v \
   --name ${FILENAME} \
   --class net.kk17.extend_spark_application_example.CountingLocalAppSetJars \
   /workspace/target/scala-2.11/extend_spark_application_example_2.11-0.0.1.jar /workspace/README.md /tmp/output
