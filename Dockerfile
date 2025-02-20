
FROM eclipse-temurin:23.0.2_7-jre-alpine

# Установка рабочей директории
WORKDIR /app

# Копирование JAR-файла приложения
COPY target/logapp-0.0.1-SNAPSHOT.jar logapp.jar

EXPOSE 8080

RUN apk update && apk add --no-cache bash && rm -rf /var/cache/apk/*
CMD ["java", "-jar", "logapp.jar"]
