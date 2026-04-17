# kubelogin conversion for Entra ID-integrated AKS
az aks get-credentials --resource-group platform-production \
  --name platform-production --overwrite-existing
kubelogin convert-kubeconfig -l azurecli
# Subsequent kubectl invocations use the developer's Azure CLI session
