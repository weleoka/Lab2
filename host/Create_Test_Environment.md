# Create Test Environment

In this step you will create the Test Environment, which includes the following docker containers.
Please skim through the details for each of the following:

1. MySql Server - see [Details](https://hub.docker.com/_/mysql)
2. VPN Server - see [Details](https://hub.docker.com/r/hwdsl2/ipsec-vpn-server)
3. Web Server - see [Details](https://hub.docker.com/_/httpd)
3. Bugzilla Server - see [Details](https://hub.docker.com/r/bugzilla/bugzilla-dev)

One popular free SQL server version is called MySQL, which we will use. 
Bugzilla is a bug/issue/defect tracking system.  
You will install Bugzilla but not configure it and we will not use it.

Optional Activity: Configure and use Bugzilla

Docker compose is a tool allowing us to more easily manage the creation of several docker container at the same time.  We will use docker compose to create the containers.

1. Change to the following directory

cd ~/Lab2/host

2. Review the docker compose file

Try to understand the docker compose file, with the following command:

less compose1.yml

"q" to quit

3. Run the docker compose command:

docker-compose -f compose1.yml up

The above command will not return control to you.
The system will seem hung, but it is not hung.

Since you can no longer use the session, you should start a 2nd SSH client session, so please do that now.

Optional Activity: Add a few more docker containers to the compose file.

Good Luck, Teacher Todd
