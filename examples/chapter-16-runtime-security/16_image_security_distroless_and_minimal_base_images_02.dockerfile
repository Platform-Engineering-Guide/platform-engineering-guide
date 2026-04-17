FROM cgr.dev/chainguard/jre:latest AS base

COPY --from=builder /app/target/payments-service.jar /app/app.jar

EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
