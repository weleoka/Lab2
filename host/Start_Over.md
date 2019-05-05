# Reset Lab2 Test Environment and Start Over

This script will completely wipe out your Lab2 Test Environment, so that you can start over.

```bash
# Remove docker containers
cd 
rm -fR Lab2
docker rm -f mysql-test web vpn dns bugzilla
docker ps -a
```

```bash
# Remove current version of docker
sudo apt remove -y docker-ce docker-ce-cli containerd.io docker-compose

# Note: To reinstall later, use the following:
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose
```

```bash
# Remove any unneeded dependencies
sudo apt autoremove -y
```
