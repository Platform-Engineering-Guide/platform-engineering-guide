# test_privileged_container.rego
package k8spsprivilegedcontainer_test

import future.keywords.if

test_privileged_container_denied if {
  count(violation) == 1
  with input as {
    "review": {
      "object": {
        "spec": {
          "containers": [{
            "name": "test",
            "securityContext": {"privileged": true}
          }]
        }
      }
    }
  }
}

test_non_privileged_container_allowed if {
  count(violation) == 0
  with input as {
    "review": {
      "object": {
        "spec": {
          "containers": [{
            "name": "test",
            "securityContext": {"privileged": false}
          }]
        }
      }
    }
  }
}
