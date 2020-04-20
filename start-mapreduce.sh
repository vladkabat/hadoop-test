#!/bin/bash

working_dir=test
input_dir=$working_dir/input
output_dir=$working_dir/output

jar_name=mapreduce-wordcount-1.0-SNAPSHOT.jar
if hadoop fs -test -d "$working_dir"; then 
	hadoop fs -rm -r $working_dir/*
	hadoop fs -rm -r .Trash/*
else 
	hadoop fs mkdir $working_dir
fi
hadoop fs -mkdir $input_dir
hadoop fs -put file*.txt $input_dir

hadoop jar $jar_name $input_dir $output_dir

hadoop fs -ls $output_dir

for file in `hadoop fs -find $output_dir -name "part-*"`
do
	hadoop fs -cat $file
done