@echo off
SET GROUP_ID=eit_group
SET ARTIFACT_JAR_NAME=eit_artifact
SET execute_this=//opt//flink//bin//flink run -c %GROUP_ID%.%1 //home//jar//%ARTIFACT_JAR_NAME%.jar
echo %execute_this% %2 %3 %4 %5 %6 %7 %8 %9
docker container exec flinky %execute_this%