To successfully update claim token run 
 kubectl delete secret plex-secret -n test-dev
envsubst < plex-secret.yaml | kubectl -n test-dev apply -f -
kubectl rollout restart deployment plex -n test-dev

