#!/bin/bash

hadoop_working_dir=test
hadoop_input_dir=$hadoop_working_dir/input
hadoop_output_dir=$hadoop_working_dir/output

module_name=mapreduce-wordcount
jar_name=$module_name/target/mapreduce-wordcount-1.0-SNAPSHOT.jar
resources_dir=$module_name/src/main/resources

mvn clean package

if hadoop fs -test -d "$hadoop_working_dir"; then 
	hadoop fs -rm -r $hadoop_working_dir/* .Trash/*
else 
	hadoop fs -mkdir $hadoop_working_dir
fi

hadoop fs -mkdir $hadoop_input_dir
hadoop fs -put $resources_dir/*.txt $hadoop_input_dir
hadoop jar $jar_name $hadoop_input_dir $hadoop_output_dir
hadoop fs -ls $hadoop_output_dir

for file in `hadoop fs -find $hadoop_output_dir -name "part-*"`
do
	hadoop fs -cat $file
done