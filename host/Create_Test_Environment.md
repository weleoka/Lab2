# Create Test Environment

In this step you will create the Test Environment, which includes the following docker containers.
Please skim through the details for each of the following:

1. MySql Server - see [Details](https://hub.docker.com/_/mysql)
2. Web Server - see [Details](https://hub.docker.com/_/httpd)
3. VPN Server - see [Details](https://hub.docker.com/r/kylemanna/openvpn)
4. DSN Server - see [Details](https://hub.docker.com/r/resystit/bind9) 
5. Bugzilla Server - see [Details](https://hub.docker.com/r/bugzilla/bugzilla-dev)

One popular free SQL server version is called MySQL, which we will use. 
Bugzilla is a bug/issue/defect tracking system.  
You will install all the server software but you will not configure the services, since that is beyond the scope of this course.  For example you will install Bugzilla but not configure it.

Optional Activity: Configure and use Bugzilla

Optional Activity: Configure and use Bugzilla

Optional Activity: Configure and use Bugzilla

Docker compose is a tool allowing us to more easily manage the creation of several docker container at the same time.  We will use the tool docker compose to create the containers.

1. Change to the following directory

```bash
cd ~/Lab2/host
```

2. Review the docker compose file

Try to understand the docker compose file, with the following command:

```bash
less compose1.yml
```

"q" to quit

3. Run the docker compose command

```bash
# Download the images before running docker-compose with the following:
docker pull mysql
docker pull httpd 
docker pull hwdsl2/ipsec-vpn-server
docker pull resystit/bind9
docker pull bugzilla/bugzilla-dev 
```

```bash
# Create the Test Environment containers
docker-compose -f ~/Lab2/host/compose1.yml up

# Optional - if you want to delete the containers, execute this
docker rm mysql-test web vpn dns bugzilla
```

The above command will not return control to you.
The system will seem hung, but it is not hung.
Since you can no longer use the session, you should start a 2nd SSH client session, so please do that now.

If you want to quit the docker compose, you need to do a cntl-c.

Optional Activity: Add a few more docker containers to the docker compose file.

4. Optional File Sharing Server

Good Luck, Teacher Todd
