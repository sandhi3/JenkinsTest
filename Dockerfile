FROM openjdk:11
EXPOSE 8081
ADD target/JenkinsTest-0.0.1-SNAPSHOT.jar JenkinsTest.jar
ENTRYPOINT ["java","-jar","/JenkinsTest.jar"]