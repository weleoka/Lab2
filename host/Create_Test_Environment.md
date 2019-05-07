# Create Test Environment

In this step you will create, configure, and verify the Test Environment, which includes the following docker containers.
Please skim through the detailed information for each of the following containers:

1. MySql Server - see [Details](https://hub.docker.com/_/mysql)
2. Web Server - see [Details](https://hub.docker.com/_/httpd)
3. VPN Server - see [Details](https://hub.docker.com/r/kylemanna/openvpn)
4. DNS Server - see [Details](https://hub.docker.com/r/resystit/bind9) 
5. Bugzilla Server - see [Details](https://hub.docker.com/r/chardek/bugzilla)

One popular free SQL server version is called MySQL, which we will use.
Bugzilla is a bug/issue/defect tracking system.
You will install all the server software and perform a basic configuration of the services.
For example you will install Bugzilla but not configure or use it.

Optional Activity: Configure and use the Web, VPN, DNS, and Bugzilla servers

Docker compose is a tool allowing us to more easily manage the creation of several docker container at the same time.
We will use the tool docker compose to create two of the containers.

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
docker pull kylemanna/openvpn
docker pull resystit/bind9
docker pull achild/bugzilla
```

We will use docker-compose to create the test environment SQL and Web servers.
We will use docker, on its own, to create the OpenVPN, DNS, and Bugzilla servers.

```bash
# Create the Test Environment containers
docker-compose -f ~/Lab2/host/compose1.yml up

# Optional - if you want to delete all test environment containers, execute this
docker rm -f mysql-test web vpn dns bugzilla
```

The above docker-compose command will not return control to you.
The system will seem hung, but it is not hung.
If you want to quit the docker compose, you need to do a cntl-c.

Since you can no longer use the session, you should start a 2nd SSH client session, so please do that now.

Optional: As an alternative to another session, you can use a session manager, such as tmux.

## Verify that the Web server is Running

In this task, you will verify that the Web Server is running and serving web pages.
We will use a command line tool to make a request to get a Web page.
The tool is called curl.
Since curl is not a Web browser, you will see all the html tags.
Execute the following from the VM Guest to obtain the IP address of the Web server.
Note that case is sensitive, so you must enter the following with capital "IPA" and lower case "ddress".

```bash
docker inspect web | grep IPAddress
```bash

In the following change 172.23.0.2 to whatever IP address was returned above.

```bash
curl 172.23.0.2
```

## Configure and Verify that the OpenVpn Server is Running

The docker compose started most containers, but did not start the OpenVPN container, so we'll start that manually.

You need to first set an environment variable.

```bash
OVPN_DATA="ovpn-data-example"
```
Then you need to create a volume.

```bash
docker volume create --name $OVPN_DATA
```

You then need to run the OpenVPN initialize script

```bash
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
```

You then need to general the cryptograhic keys

```bash
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
```

The above will prompt you as following, and you can answer as the following shows:

Enter New CA Key Passphrase: phrase22 
Re-Enter New CA Key Passphrase: 
Common Name: Easy-RSA CA

The cryptograhic keys will then be generated, which will take a few minutes.
You will be asked and you can answer:

Enter pass phrase for /etc/openvpn/pki/private/ca.key: phrase22

Then again: 

Enter pass phrase for /etc/openvpn/pki/private/ca.key: phrase22

You should receive the following, as success:

An updated CRL has been created.

Finally, you need to try running the OpenVPN docker container:

```bash
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
```

Check to see if the vpn container is running and it should say, "Up"

```bash
docker ps -a | grep vpn
```

## Configure and Verify that the DSN Server is Running

You first need to configure the DNS server.
Todd has created an initial configuration.
As an optional excercise for advanced students, you can modify Todd's configuration.
Documentation for the DNS server is found at [This URL](https://help.ubuntu.com/lts/serverguide/dns-configuration.html.en).
Todd's configuration file is found in /home/ubuntu/Lab2/host/named.conf.
You need to copy all three of the following lines, all at once.

```bash
docker run -d --name dns -p 54:53 -p 54:53/udp \
    -v /home/ubuntu/host/named.conf:/etc/bind/named.conf \
    -v /home/ubuntu/host/example.com.db:/etc/bind/example.com.db resystit/bind9:latest
```

You now need to test the dns server.
Try resolving the name "example.com"

In the following, "docker exec dns" means we want to execute a command in the dns container.
"nslookup" is a DNS testing tool.
"nslookup example.com" will attempt to find the IP address, for the example.com host.

```bash
docker exec dns nslookup example.com
```

You should ignore the "can't resolve" message.
If it worked, you should get back the IP address 93.184.216.34, which is the IP address of example.com

## Configure and Verify that the BugZilla Gug Tracking Server is Running

Download a copy of the BugZilla image.

```bash
docker pull achild/bugzilla
```

Create a container from the image and run it.

```bash
docker run -d -p 81:80 --name bugzilla \
    -v /tmp/msmtprc:/etc/msmtprc:ro \
    -e MYSQL_DB=bugzilla \
    -e MYSQL_USER=admin \
    -e MYSQL_PWD=pw1 \
    achild/bugzilla
```

Execute the following from the VM Guest to obtain the IP address of the BugZilla server.
Note that case is sensitive, so you must enter the following with capital "IPA" and lower case "ddress".

```bash
docker inspect bugzilla | grep IPAddress
```bash

In the following change 172.17.0.3 to whatever IP address was returned above.
We are running the BugZilla database on a non standard port, 81, which is why you need ":81".

```bash
curl localhost:81
```

You should receive a Web page.  
You can ignore the configuration failure.

Optional Activity: Add a few more docker containers to the docker compose file.
To find candidates, surf to https://hub.docker.com and use the search field.

Good Luck, Teacher Todd
