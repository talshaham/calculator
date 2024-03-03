# SonarQube analysis
# Use Maven as the base image
FROM maven:3.8.4 as sonarqube

# Define build arguments
ARG SONAR_TOKEN
ARG SONAR_IP

# Copy the Maven project into the Docker image
COPY . .

# Run the SonarQube analysis
RUN mvn package sonar:sonar \
    -Dsonar.login=$SONAR_TOKEN \
    -Dsonar.host.url=$SONAR_IP

FROM releases-docker.jfrog.io/jfrog/jfrog-cli-v2-jf

ARG JFROG_IP
ARG JFROG_SERVER_ID
ARG JFROG_USERNAME
ARG JFROG_PASSWORD

COPY --from=sonarqube ./target/Calculator-1.0-SNAPSHOT.jar .

RUN jf c add $JFROG_SERVER_ID --interactive=false --url=$JFROG_IP --user=$JFROG_USERNAME --password=$JFROG_PASSWORD



#Uplaod to factory
RUN jf rt u Calculator-1.0-SNAPSHOT.jar tal-shaham/home

