# Reset Lab2 Test Environment and Start Over

This script will completely wipe out your Lab2 Test Environment, so that you can start over.

```bash
cd 
rm -fR Lab2
docker rm -f mysql-test web vpn bugzilla
docker ps -a
```

# To remove older versions of docker
# sudo apt-get remove docker docker-engine docker.io containerd runc

# To remove current version of docker
```bash
sudo apt-get remove -y docker-ce docker-ce-cli containerd.io
```

# Remove any unneeded dependencies
```bash
sudo apt autoremove -y
```bash