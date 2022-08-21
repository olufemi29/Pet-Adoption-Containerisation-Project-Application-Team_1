FROM openjdk
FROM ubuntu 
FROM tomcat
COPY **/*.war /usr/local/tomcat/webapps
WORKDIR  /usr/local/tomcat/webapps
RUN apt update -y && apt install curl -y
RUN curl -O https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip && \
    apt-get install unzip -y  && \
    unzip newrelic-java.zip -d  /usr/local/tomcat/webapps
RUN mkdir -p /usr/local/tomcat/newrelic
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:/usr/local/tomcat/newrelic/newrelic.jar"
ADD ./newrelic/newrelic.yml /usr/local/tomcat/newrelic/newrelic.yml
ENV NEW_RELIC_APP_NAME="Pet-adoption"
ENV NEW_RELIC_LICENCE_KEY="eu01xx4fc443b5ef136bb617380505f93e08NRAL"
RUN mkdir -p /usr/local/tomcat/newrelic/logs
RUN chown -R tomcat:tomcat /usr/local/tomcat/newrelic/logs
ENV NEW_RELIC_LOG_FILE_NAME=STDOUT
ENTRYPOINT ["java", "-javaagent:/usr/local/tomcat/webapps/newrelic/newrelic.jar", "-jar", "spring-petclinic-2.4.2.war", "--server.port=8085"]
