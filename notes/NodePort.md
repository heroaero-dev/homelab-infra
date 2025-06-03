# how to properly assign a service.yaml as a NodePort
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  type: NodePort
  selector:
    app: my-app
  ports:
    - port: 80         # Port inside cluster
      targetPort: 8080 # Port your container listens on
      nodePort: 30080  # Exposed NodePort (30000–32767)
___

# the deployment.yaml
apiVersion: v1
kind: Deployment
metadata:
  name: my-app
  namespace: my-namespace
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app-container-name
          image: app-image:latest
          ports:
            - containerPort: 8080
