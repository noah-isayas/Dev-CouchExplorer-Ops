# Stage 1: Build the JAR using Maven
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the source code and build the JAR
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR using a lightweight Java runtime
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/imagegenerator-0.0.1-SNAPSHOT.jar /app/imagegenerator.jar

# Set environment variable for the SQS queue URL (can be overridden at runtime)
ENV SQS_QUEUE_URL="https://sqs.eu-west-1.amazonaws.com/244530008913/image-requests-queue"

# Command to run the application with a sample argument
ENTRYPOINT ["java", "-jar", "/app/imagegenerator.jar"]
CMD ["a lion on top of k2"]
