# JDK17 Base Image Setting
FROM openjdk:17-alpine

# Set WORKDIR
WORKDIR /application

# Expose 8080 PORT to allow container access
EXPOSE 8080

# Dependency caching with docker cache
ADD build.gradle ${WORKDIR}/
RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true

# Move application Jar file to conatiner
ARG JAR_FILE=build/libs/cicd_study-0.0.1.jar
ADD ${JAR_FILE} ${WORKDIR}/cicd_study-0.0.1.jar

# Layering application jar file
RUN java -Djarmode=layertools -jar cicd_study-0.0.1.jar extract

COPY build/libs/dependencies/ ./
RUN true

COPY build/libs/spring-boot-loader ./
RUN true

COPY build/libs/snapshot-dependencies ./
RUN true

COPY build/libs/application ./
RUN true

# Run application jar file
ENTRYPOINT ["java", "-jar", "%{WORKDIR}/cicd_study-0.0.1.jar"]