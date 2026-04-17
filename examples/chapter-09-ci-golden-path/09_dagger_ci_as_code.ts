// Dagger pipeline in TypeScript — build, test, scan, push
import { dag, Container, Directory, object, func } from "@dagger.io/dagger"

@object()
class PaymentsPipeline {
  // Source directory
  @func()
  source(): Directory {
    return dag.host().directory(".", { exclude: [".git", "node_modules", "target"] })
  }

  // Run tests and return results
  @func()
  async test(): Promise<string> {
    return dag
      .container()
      .from("maven:3.9-eclipse-temurin-21")
      .withMountedDirectory("/app", this.source())
      .withWorkdir("/app")
      .withExec(["mvn", "-B", "test"])
      .stdout()
  }

  // Build container image
  @func()
  build(): Container {
    const built = dag
      .container()
      .from("maven:3.9-eclipse-temurin-21")
      .withMountedDirectory("/app", this.source())
      .withWorkdir("/app")
      .withExec(["mvn", "-B", "package", "-DskipTests"])

    return dag
      .container()
      .from("eclipse-temurin:21-jre-alpine")
      .withFile("/app/app.jar", built.file("/app/target/payments-service.jar"))
      .withExposedPort(8080)
      .withEntrypoint(["java", "-jar", "/app/app.jar"])
  }

  // Scan for vulnerabilities
  @func()
  async scan(imageRef: string): Promise<string> {
    return dag
      .container()
      .from("aquasec/trivy:latest")
      .withExec([
        "trivy", "image",
        "--exit-code", "1",
        "--severity", "CRITICAL,HIGH",
        imageRef
      ])
      .stdout()
  }

  // Full pipeline: test, build, scan, push
  @func()
  async publish(registry: string, tag: string): Promise<string> {
    // Run tests first — pipeline functions compose naturally
    await this.test()

    // Build the image
    const image = this.build()

    // Push to registry to get the digest
    const imageRef = `${registry}/payments-service:${tag}`
    const digest = await image.publish(imageRef)

    // Scan the pushed image
    await this.scan(`${imageRef}@${digest}`)

    return digest
  }
}
