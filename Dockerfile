FROM tomcat:9.0-jdk21-temurin-jammy

# -S creates a system user/group (no home directory needed usually)
RUN addgroup -S techgroup && adduser -S techuser -G techgroup

WORKDIR /usr/local/tomcat/webapps/

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

ENTRYPOINT ["catalina.sh", "run"]