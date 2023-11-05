FROM openjdk

COPY ./target/demo-docker-1.0.0.jar /usr/app/dockerDemo.jar

WORKDIR /usr/app

EXPOSE 8080

CMD ["java", "-jar", "dockerDemo.jar"]

