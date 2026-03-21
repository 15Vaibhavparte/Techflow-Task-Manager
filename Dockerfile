FROM tomcat:9.0-jdk21-temurin-jammy

# 1. Clear out default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copy your artifact and rename it to ROOT.war
# This ensures your TechFlow app is the "Home Page"
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# 3. Expose the standard Tomcat port
EXPOSE 8080

# 4. The Correct ENTRYPOINT
# This starts the Tomcat server in the foreground
ENTRYPOINT ["catalina.sh", "run"]