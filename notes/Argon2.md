
# how to run Argon2 and generate a hashed admin token for vault-warden
echo -n "YourPassword" | argon2 mysecretsalt -id -t 2 -m 16 -p 1

