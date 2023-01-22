FROM openjdk:11-jre-slim
WORKDIR /app
COPY ./target/devops-0.0.1-SNAPSHOT.jar /app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "devops-0.0.1-SNAPSHOT.jar"]