# issues/solutions i ran into while wiping switching os on server and using backups

## cloudflared setup

- kept failing to start with systemctl
- service said it couldn't find credentials .json
- fixed it by:
  - making sure the creds json matched the correct tunnel id
  - copied it to /etc/cloudflared
  - renamed config.yaml to config.yml (lol)
  - made sure the ExecStart path in systemd matched the actual binary path (`/usr/local/bin/cloudflared`)
  - set the tunnel id + credentials file path correctly in config.yml
- restarted with `sudo systemctl daemon-reload && sudo systemctl restart cloudflared` and it worked

## k3s plex deployment

- pod was running but couldn’t see logs
- turns out i was using the wrong syntax:
  - tried `kubectl logs -n test-dev deployment.apps plex` (wrong)
  - should’ve used `kubectl logs -n test-dev pod/<pod-name>` or filtered by label
- checked pvc path with `ls /var/lib/rancher/k3s/storage/`
- copied media files to correct pvc path manually using `sudo cp -r`

## how i found the backup tar.gz on my ssd

- ran `lsblk` to list devices
- used `df -h | grep /media` to see what was mounted — saw the external ssd mounted at `/media/aerodev/8095bccc-f491-4bc4-af85-7800a1bfde5a`
- used `cd` to navigate to the tar.gz location  
- ran:
  ```bash
  tar -xzvf /media/aerodev/8095bccc-f491-4bc4-af85-7800a1bfde5a.tar.gz -C /media/aerodev/8095bccc-f491-4bc4-af85-7800a1bfde5a

## podman troubleshooting

- tried using `podman compose up -d` and it complained about docker-compose
- fixed it by installing podman-compose and tweaking image names
- vaultwarden failed at first because `.env` was missing
- homepage failed because of missing `/var/run/docker.sock` (bind-mount doesn’t work the same way in podman unless you’re root or rootless is configured right)

## git

- commit wouldn’t go through until i set my git identity:
  ```bash
  git config --global user.name "aerodev"
  git config --global user.email "dev.alongside317@passmail.net"

