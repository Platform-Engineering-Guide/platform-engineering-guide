# Multi-stage build with distroless final image
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src/ src/
RUN mvn package -DskipTests -B

# Final stage: distroless Java image
FROM gcr.io/distroless/java21-debian12:nonroot

# nonroot tag ensures the container runs as non-root user (uid 65532)
# by default, without requiring securityContext configuration

COPY --from=builder /app/target/payments-service.jar /app/app.jar

EXPOSE 8080

CMD ["/app/app.jar"]
