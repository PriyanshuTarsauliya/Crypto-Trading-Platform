# Multi-Stage Dockerfile for Spring Boot 3 (Root Context)
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy Maven Wrapper and POM from Backend directory
COPY Backend/.mvn/ .mvn/
COPY Backend/mvnw Backend/pom.xml ./
RUN chmod +x mvnw

# Copy Source and Build Jar
COPY Backend/src/ ./src/
RUN ./mvnw clean package -DskipTests -B

# Production Runtime Stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/treading-plateform-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 5454
ENV PORT=5454
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-5454} -jar app.jar"]
