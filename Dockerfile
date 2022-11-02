FROM tomcat:8.0
MAINTAINER Rahul

COPY target/spring-hello-world-1.0.war /usr/local/tomcat/webapps/
#COPY spring-hello-world-1.0.war /usr/local/tomcat/webapps/
COPY version /
COPY . ./
