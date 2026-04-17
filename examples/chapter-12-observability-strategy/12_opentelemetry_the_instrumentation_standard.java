// build.gradle — OpenTelemetry Java agent (zero-code instrumentation)
// The Java agent instruments popular frameworks automatically
// without requiring code changes in the application

// In practice, the agent is added to the JVM at startup:
// java -javaagent:/path/to/opentelemetry-javaagent.jar \
//      -Dotel.service.name=payments-service \
//      -Dotel.exporter.otlp.endpoint=http://otel-collector:4317 \
//      -jar app.jar

// For custom instrumentation (spans, metrics, events):
import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.api.metrics.Meter;
import io.opentelemetry.api.metrics.LongCounter;
import io.opentelemetry.context.Scope;

@Service
public class PaymentProcessor {

    private final Tracer tracer = GlobalOpenTelemetry.getTracer("payments-service");
    private final Meter meter = GlobalOpenTelemetry.getMeter("payments-service");

    // Custom metric: payment processing counter by status and method
    private final LongCounter paymentsProcessed = meter
        .counterBuilder("payments.processed.total")
        .setDescription("Total number of payments processed")
        .setUnit("payments")
        .build();

    public PaymentResult processPayment(PaymentRequest request) {
        // Create a custom span for the payment processing operation
        Span span = tracer.spanBuilder("process-payment")
            .setAttribute("payment.method", request.getMethod())
            .setAttribute("payment.amount_cents", request.getAmountCents())
            .setAttribute("payment.currency", request.getCurrency())
            .setAttribute("customer.tier", request.getCustomerTier())
            .startSpan();

        try (Scope scope = span.makeCurrent()) {
            // Validate payment
            Span validationSpan = tracer.spanBuilder("validate-payment")
                .startSpan();
            try (Scope validationScope = validationSpan.makeCurrent()) {
                validatePayment(request);
            } finally {
                validationSpan.end();
            }

            // Process with payment provider
            PaymentResult result = paymentProvider.charge(request);

            span.setAttribute("payment.provider.transaction_id",
                result.getTransactionId());
            span.setAttribute("payment.status", result.getStatus().name());

            // Record metric
            paymentsProcessed.add(1,
                Attributes.of(
                    AttributeKey.stringKey("payment.method"), request.getMethod(),
                    AttributeKey.stringKey("payment.status"), result.getStatus().name(),
                    AttributeKey.stringKey("payment.currency"), request.getCurrency()
                ));

            return result;

        } catch (PaymentException e) {
            span.setStatus(StatusCode.ERROR, e.getMessage());
            span.recordException(e);
            throw e;
        } finally {
            span.end();
        }
    }
}
