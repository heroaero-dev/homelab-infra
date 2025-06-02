#!/bin/bash
## minimal gitops script
NAMESPACE="test-dev"

echo " Validating YAMLs..."
kubectl apply --dry-run=client -n "$NAMESPACE" -f . || {
       	echo " Validation failed.";
exit 1;
}
echo " Showing changes..."
kubectl diff -n "$NAMESPACE" -f .

echo ""
read -p " Apply changes to cluster? (y/n): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
	kubectl apply -n "$NAMESPACE" -f .
	echo " Deployment complete"
else
	echo " Cancelled"
fi
