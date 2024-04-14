FROM maven:3.8.4
COPY . .
RUN mvn package

