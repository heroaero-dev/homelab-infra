## K-secret/env for password handling
make a .env $ nvim .env 
inside .env enter 'POSTGRESS_PASSWORD=secretpassword'
### In terminal run 
$'kubectl create secret generic <secret-name> \
$  --from-env-file=.env \
$  -n test-dev'

#### Make sure your env block is set up like the example down below

env:
  - name: POSTGRESS_PASSWORD
    valueFrom:
        secretKeyRef:
            name: <secret-name>
            key: POSTGRESS_PASSWORD

>

