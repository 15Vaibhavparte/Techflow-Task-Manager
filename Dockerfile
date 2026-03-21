FROM tomcat:9.0-jdk21-temurin-jammy

# 1. Create the restricted user
RUN groupadd -r tomcatgroup && useradd -r -g tomcatgroup tomcatuser

WORKDIR /usr/local/tomcat/webapps/

# 2. Clean and set permissions for the server folders
RUN rm -rf /usr/local/tomcat/webapps/*
RUN chown -R tomcatuser:tomcatgroup /usr/local/tomcat

# 3. Securely copy the application artifact
COPY --chown=tomcatuser:tomcatgroup target/*.war /usr/local/tomcat/webapps/ROOT.war

# 4. Switch to the non-root user (SonarQube will now give you a Green check!)
USER tomcatuser

EXPOSE 8080

ENTRYPOINT ["catalina.sh", "run"]