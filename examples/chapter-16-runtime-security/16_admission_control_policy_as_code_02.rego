apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8spsprivilegedcontainer
spec:
  crd:
    spec:
      names:
        kind: K8sPSPrivilegedContainer
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8spsprivilegedcontainer

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.privileged == true
          msg := sprintf(
            "Privileged container is not allowed: %v",
            [container.name]
          )
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.initContainers[_]
          container.securityContext.privileged == true
          msg := sprintf(
            "Privileged init container is not allowed: %v",
            [container.name]
          )
        }

        # Also check ephemeral containers
        violation[{"msg": msg}] {
          container := input.review.object.spec.ephemeralContainers[_]
          container.securityContext.privileged == true
          msg := sprintf(
            "Privileged ephemeral container is not allowed: %v",
            [container.name]
          )
        }
---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sPSPrivilegedContainer
metadata:
  name: psp-privileged-container
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
    namespaceSelector:
      matchExpressions:
        - key: kubernetes.io/metadata.name
          operator: NotIn
          values: ["kube-system"]
  enforcementAction: deny    # deny | warn | dryrun
