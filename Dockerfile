# Stage 1: Build the Java application
FROM maven:3.8.4-jdk-8 as build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

# Stage 2: Deploy the application to Tomcat
FROM tomcat:9.0.80-jre8
COPY --from=build /app/target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
