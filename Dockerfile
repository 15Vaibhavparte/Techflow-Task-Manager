FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY target/*.war /app/task-manager.war
EXPOSE 5555
ENTRYPOINT ["java", "-jar", "task-manager.war"]