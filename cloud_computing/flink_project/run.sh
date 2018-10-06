source ./var.env
execute_this="//opt//flink//bin//flink run -c $GROUP_ID.$1 //home//jar//$ARTIFACT_JAR_NAME.jar"
shift
execute_this="$execute_this $@"
echo $execute_this
docker container exec flinky $execute_this