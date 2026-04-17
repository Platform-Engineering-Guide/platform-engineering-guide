// Dagger pipeline for the payments service
package main

import (
    "context"
    "dagger.io/dagger"
)

func main() {
    ctx := context.Background()

    client, err := dagger.Connect(ctx, dagger.WithLogOutput(os.Stderr))
    if err != nil {
        panic(err)
    }
    defer client.Close()

    source := client.Host().Directory(".", dagger.HostDirectoryOpts{
        Exclude: []string{".git", "node_modules"},
    })

    // Build stage
    builder := client.Container().
        From("maven:3.9-eclipse-temurin-21").
        WithMountedDirectory("/app", source).
        WithWorkdir("/app").
        WithExec([]string{"mvn", "-B", "package", "-DskipTests=false"})

    // Test results
    _, err = builder.Stdout(ctx)
    if err != nil {
        panic(fmt.Errorf("tests failed: %w", err))
    }

    // Build container image
    image := client.Container().
        From("eclipse-temurin:21-jre-alpine").
        WithFile("/app/app.jar",
            builder.File("/app/target/payments-service.jar")).
        WithExposedPort(8080).
        WithEntrypoint([]string{"java", "-jar", "/app/app.jar"})

    // Push to registry
    addr, err := image.Publish(ctx,
        "123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service:latest")
    if err != nil {
        panic(err)
    }
    fmt.Println("Published:", addr)
}
