# JDK17 Base Image Setting
FROM openjdk:17

# Set WORKDIR
WORKDIR /app

# Expose 8080 PORT to allow container access
EXPOSE 8080

# Dependency caching with docker cache
ADD build.gradle ${WORKDIR}/
RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true

# Move application Jar file to conatiner
ARG JAR_FILE=build/libs/CICD_Study-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} ${WORKDIR}/cicd_study-0.0.1.jar

# Run application jar file
ENTRYPOINT ["java", "-jar", "%{WORKDIR}/cicd_study-0.0.1.jar"]