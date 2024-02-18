FROM openjdk:11-jre-slim
ENV APP_HOME=/apps

ARG JAR_FILE_PATH=build/libs/application-0.0.1-SNAPSHOT.jar

WORKDIR $APP_HOME

COPY $JAR_FILE_PATH app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
