# Stage 1: Build jar file
FROM maven:3.8.6-jdk-11 as builder
WORKDIR /app
COPY . .
RUN mvn clean test package

# Stage 2: Create Docker image
FROM openjdk:11-jre-slim
COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
