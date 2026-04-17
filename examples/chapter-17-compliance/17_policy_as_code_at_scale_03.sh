# Run policy tests
kyverno test tests/

# Output:
# Loading test  ( 2 / 2 ) ...
# 
# Executing test:  test-disallow-privileged ...
#   Results:
#     policy  disallow-privileged-containers -> rule privileged-containers -> resource privileged-pod  PASS
#     policy  disallow-privileged-containers -> rule privileged-containers -> resource compliant-pod   PASS
# 
# Test Summary: 2 tests passed and 0 tests failed
