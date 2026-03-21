FROM openjdk:21-jdk-alpine
WORKDIR /app
COPY target/task-manager-1.0.0.war /app/task-manager.war
EXPOSE 5555
ENTRYPOINT ["java", "-jar", "task-manager.war"]