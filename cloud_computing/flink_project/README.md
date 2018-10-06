# What is it?
This repository provides simple setup for running flink programs in a docker container. It does not provide maven and IDE. You have to setup maven and build a jar file by yourself.

# Setup
1. Install Docker and Docker Compose
2. Build your JAR file and place it in artifacts catalogue
3. Set your maven configuration in var.env
4. Start docker container

    $ docker-compose up
5. Run programs. First command line argument is a name of the class. Next arguments are passed as command line arguments to flink run command.

    $ ./run.sh WordCount
    $ ./run.sh SourceSink