cp -r /home/programs /home/maven_project/eit_artifact/src/main/java/eit_group
cd /home/maven_project/eit_artifact
mvn clean install -Pbuild-jar
/home/flink_app/flink-1.3.3/bin/start-cluster.sh
sleep 1
# /home/flink_app/flink-1.3.3/bin/flink run -c eit_group.WordCount /home/maven_project/eit_artifact/target/eit_artifact-1.0-SNAPSHOT.jar
/home/flink_app/flink-1.3.3/bin/flink run -c eit_group.MapFilter /home/maven_project/eit_artifact/target/eit_artifact-1.0-SNAPSHOT.jar \
    /home/data-in/test_data.csv \
    /home/data-out/test_out.txt
# sleep 60