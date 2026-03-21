FROM tomcat:9.0-jdk21-temurin-jammy

RUN groupadd -r tomcatgroup && useradd -r -g tomcatgroup tomcatuser

WORKDIR /usr/local/tomcat/webapps/

RUN rm -rf /usr/local/tomcat/webapps/*

RUN chown -R tomcatuser:tomcatgroup /usr/local/tomcat

COPY --chown=tomcatuser:tomcatgroup target/*.war /usr/local/tomcat/webapps/ROOT.war

USER tomcatuser

COPY --chown=tomcatuser:tomcatgroup target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

ENTRYPOINT ["catalina.sh", "run"]