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
 --network ${NETWORK} \
 jupyter/pyspark-notebook \
 /usr/local/spark/bin/spark-submit -v \
   --name $FILENAME \
   --master spark://spark-master:7077 \
   --deploy-mode cluster \
   --jars /workspace/lib_managed/jars/com.typesafe.play/play-json_2.11/play-json_2.11-2.6.9.jar,/workspace/lib_managed/jars/com.typesafe.play/play-functional_2.11/play-functional_2.11-2.6.9.jar \
   --class net.kk17.extend_spark_application_example.CountingApp \
   /workspace/target/scala-2.11/extend_spark_application_example_2.11-0.0.1.jar /workspace/README.md /tmp/output

# see driver logs from spark workers http://localhost:8081/ or http://localhost:8082/
