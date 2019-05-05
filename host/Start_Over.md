# Reset Lab2 Test Environment and Start Over

This script will completely wipe out your Lab2 Test Environment, so that you can start over.

docker rm -f mysql-test web vpn bugzilla
docker ps -a
cd 
rm -fR Lab2
