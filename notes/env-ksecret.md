# how to set .env + kubernetes-secret
vim .env
# inside .env
POSTGRES_USER=myuser
POSTGRES_PASSWORD=password

#run

kubectl create secret generic my-app-secret \
--from-env-file=.env \
--dry-run=client -o yaml > my-app-secret.yaml
kubectl apply -f my-app-secret.yaml

# refernce in a deployment
env:
  - name: POSTGRES_USER
    valueFrom:
      secretKeyRef:
        name: my-app-secret # name of secret
        key: POSTGRES_USER
  - name: POSTGRES_PASSWORD
    valueFrom:
      secretKeyRef:
        name: my-app-secret
        key: POSTGRES_PASSWORD


