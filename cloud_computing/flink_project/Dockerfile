FROM maven:3.5.4
USER root

WORKDIR /home/maven_project
RUN mvn archetype:generate \
    -DarchetypeGroupId=org.apache.flink \
    -DarchetypeArtifactId=flink-quickstart-java \
    -DarchetypeVersion=1.3.2 \
    -DgroupId=eit_group \
    -DartifactId=eit_artifact

WORKDIR /home/maven_project/eit_artifact
RUN mvn clean install -Pbuild-jar

WORKDIR /home/flink_app
RUN wget -P /tmp/ https://archive.apache.org/dist/flink/flink-1.3.3/flink-1.3.3-bin-hadoop2-scala_2.10.tgz
RUN tar xzf /tmp/flink-1.3.3-bin-hadoop2-scala_2.10.tgz
COPY run.sh /home
CMD /home/run.sh