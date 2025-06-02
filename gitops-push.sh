#!/bin/bash
# load token from .env
if [ -f .env ]; then
	export $(grep -v '^#' .env | xargs)
else
	echo " .env file not found."
	exit 1
fi

# check if token is available
if [[ -z "$GITHUB_TOKEN" ]]; then
	echo " GITHUB_TOKEN is not set. Check .env."
	exit 1
fi

# auto-commit and push with time stamp
git add .
git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S;')" || echo "Nothing to commmit."

#override remote with secure token
GIT_REPO=$(git config --get remote.origin.url | sed -E 's#https://.@#https://#')
SECURE_REPO="https://${GITHUB_TOKEN}@${GIT_REPO#https://}"

git push "$SECURE_REPO" HEAD:main
echo "secure push complete."
