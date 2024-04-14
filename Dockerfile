FROM maven:3.8.4
WORKDIR /project/
COPY . /project
RUN mvn package

