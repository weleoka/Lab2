# Reset Lab2 Test Environment and Start Over

This script will completely wipe out your Lab2 Test Environment, so that you can start over.

```bash
# Remove docker containers
cd 
rm -fR Lab2
docker rm -f mysql-test web vpn bugzilla
docker ps -a
```

```bash
# Remove current version of docker
sudo apt-get remove -y docker-ce docker-ce-cli containerd.io
```

```bash
# Remove any unneeded dependencies
sudo apt autoremove -y
```