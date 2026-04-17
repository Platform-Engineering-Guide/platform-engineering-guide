# High Error Rate — Payments Service

## Alert

`PaymentsServiceHighErrorRate`: Error rate exceeds 5% for more than 2 minutes.

## Impact

Users are experiencing payment failures. Every 1% of error rate represents
approximately 50 failed payment attempts per minute at normal traffic volume.

## Quick Triage (< 2 minutes)

1. Check the [Payments Service Dashboard](https://grafana.acme.io/d/payments-service)
2. Is the error rate uniform across all pods, or isolated to specific pods?
   - Uniform: likely downstream dependency or configuration issue
   - Isolated: likely a pod-specific issue (bad deployment, node problem)
3. Check recent deployments: `kubectl rollout history deploy/payments-service -n payments`
4. Check downstream dependencies: Stripe API status at <https://status.stripe.com>

## Investigation

### If errors started after a recent deployment

```bash
# Roll back the most recent deployment
kubectl rollout undo deployment/payments-service -n payments
 
# Monitor error rate recovery
watch -n 5 'kubectl get pods -n payments'
```

```markdown
### If errors are isolated to specific pods

```bash
# Identify failing pods
kubectl get pods -n payments -o wide | grep -v Running
 
# Check pod logs for error patterns
kubectl logs -n payments -l app=payments-service --since=10m | grep ERROR | head -50
 
# If pod is in CrashLoopBackOff
kubectl describe pod <pod-name> -n payments
kubectl logs -n payments <pod-name> --previous
```

```markdown
### If errors started without a deployment

```bash
# Check database connectivity
kubectl exec -n payments deploy/payments-service -- \
  pg_isready -h $DB_HOST -p 5432
 
# Check Stripe API connectivity
kubectl exec -n payments deploy/payments-service -- \
  curl -s https://api.stripe.com/v1/charges \
  -H "Authorization: Bearer $STRIPE_TEST_KEY" | jq .error
 
# Check for resource exhaustion
kubectl top pods -n payments
kubectl describe nodes | grep -A 5 "Allocated resources"
```

```markdown
## Escalation

If the error rate has not recovered within 15 minutes of starting investigation:

- Page the payments engineering lead: @payments-lead on PagerDuty
- Notify #payments-engineering Slack channel with incident status

## Resolution Checklist

- [ ] Error rate returned below 1%
- [ ] Root cause identified and documented
- [ ] Immediate remediation applied
- [ ] Follow-up ticket created for permanent fix (if applicable)
- [ ] Incident post-mortem scheduled (if P1/P2)

## Related Runbooks

- [Database Connection Issues](./database-connection-issues.md)
- [Stripe Integration Failures](./stripe-integration-failures.md)
- [Rolling Back Deployments](../platform/rollback-deployment.md)
