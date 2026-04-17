# Request PIM activation for production cluster-admin (Azure CLI)
az rest --method POST \
  --url "https://management.azure.com/providers/Microsoft.Authorization/roleEligibilityScheduleRequests/<request-id>?api-version=2020-10-01" \
  --body '{
    "properties": {
      "principalId": "<engineer-object-id>",
      "roleDefinitionId": "<cluster-admin-role-id>",
      "requestType": "SelfActivate",
      "scheduleInfo": {
        "expiration": {
          "type": "AfterDuration",
          "duration": "PT4H"
        }
      },
      "justification": "Investigating production incident INC-4821"
    }
  }'
