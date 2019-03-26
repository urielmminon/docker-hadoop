#!/bin/bash

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit 2
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 2
fi

if [ "`ls -A $namedir`" == "" ]; then
  echo "Formatting namenode name directory: $namedir"
  $HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME &
#  sleep 1m
  $HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR datanode -format $CLUSTER_NAME
fi


echo "Llegamos hasta antes de la ejecuciond e las lineas"
$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode &

#sleep 1m
#echo "enmedio"
$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR datanode

