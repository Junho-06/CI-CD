# JDK17 Base Image Setting
FROM openjdk:17

# Set WORKDIR
WORKDIR /tmp

# Expose 8080 PORT to allow container access
EXPOSE 8080

# Dependency caching with docker cache
ADD build.gradle /
RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true

# Move application Jar file to conatiner
ARG JAR_FILE=build/libs/CICD_Study-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} ./cicd_study-0.0.1.jar

# Run Application
CMD ["java", "-jar", "/cicd_study-0.0.1.jar"]