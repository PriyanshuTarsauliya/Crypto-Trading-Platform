# Build Stage
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copy Maven Wrapper and POM
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy Source and Package
COPY src/ ./src/
RUN ./mvnw clean package -DskipTests -B

# Runtime Stage
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/treading-plateform-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 5454
ENV PORT=5454
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-5454} -jar app.jar"]
