FROM openjdk:26-ea-17-jdk-oracle

COPY ./target/demo-docker*.jar /usr/app/dockerDemo.jar

WORKDIR /usr/app

EXPOSE 8080

CMD ["java","-jar","dockerDemo.jar"]
