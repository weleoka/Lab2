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
However, you will install Bugzilla but not configure or use it.

Optional Advanced Activities: Perform more advanced configuration for the mySql Web, VPN, DNS, and/or the Bugzilla servers

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

3. Download the images before running docker-compose with the following:

```bash
docker pull mysql
docker pull httpd
docker pull kylemanna/openvpn
docker pull resystit/bind9
```

We will use docker-compose to create the test environment SQL and Web servers.
We will use docker, on its own, to create the OpenVPN, DNS, and Bugzilla servers.

4. Run the docker compose command

```bash
# Create the Test Environment containers
cd ~/Lab2/host
docker-compose -f compose1.yml up -d
```

```bash
# Optional - if you want to delete all test environment containers, execute this
docker rm -f mysql-test web vpn dns bugzilla
```

Optional: You may wish to use a session manager, which supports multiple tabbed interfaces, such as tmux.
You can find tutorials on YouTube.

## Verify that the Web server is Running

In this task, you will verify that the Web Server is running and serving web pages.
We will use a command line tool to make a request to get a Web page.
The tool is called curl.

Since curl is not a Web browser, you will see all the html tags.
Execute the following from the VM Guest to obtain the IP address of the Web server.
Note that case is sensitive, so you must enter the following with capital "IPA" and lower case "ddress".

```bash
docker inspect web | grep IPAddress
```

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
docker run -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none \
    --rm kylemanna/openvpn ovpn_genconfig \
    -u udp://VPN.SERVERNAME.COM
```

You then need to generate the cryptograhic keys

```bash
docker run -v $OVPN_DATA:/etc/openvpn \
    --log-driver=none \
    --rm -it kylemanna/openvpn ovpn_initpki
```

The above will prompt you as following, and you can answer as the following shows:

Enter New CA Key Passphrase: phrase22 
Re-Enter New CA Key Passphrase: 
Common Name: Easy-RSA CA

The cryptograhic keys will then be generated, which will take a few minutes.
You will be asked and you can answer as follows:

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
    -v /home/ubuntu/Lab2/host/named.conf:/etc/bind/named.conf \
    -v /home/ubuntu/Lab2/host/example.com.db:/etc/bind/example.com.db resystit/bind9:latest
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

## Install BugZilla Gug Tracking Server

Download a copy of the BugZilla GitHub file.

```bash
cd
git clone https://github.com/chardek/docker-bugzilla.git
```

Change to the new directory

```bash
cd docker-bugzilla
```

Build BugZilla docker image from scratch

```bash
docker build .
```
Alternatively run 
```bash
docker build -t bugzilla .
```
To also tag the file with the name "bugzilla"

This will take several minutes.
Verify that the BugZilla docker image was created.

```bash
docker image ls
```

The image will be on the top and say "CREATED" recently.

Give the image a label.
Note that my image id will be different than yours, so use the first 4 hex digits of your image name.

```bash
docker image tag 2dbe bugzilla
```

Now verify that the name "bugzilla" name has been added to the image, on the far left, under Repository.

```bash
docker image ls
```

Now from the image, run a BugZilla container.

```bash
docker run --name bugzilla --hostname bugzilla bugzilla
```

Ignore the error message.  The system will appear to be hung. 

Start a new session from your client to the main VM Guest.
In that session, do the following to remove the bugzilla docker container:

```bash
docker rm -f bugzilla
```

You have now done the installation, but not the configuration.

Optional Activity for advanced students: Add a few more docker containers to the docker compose file.
To find candidates, surf to https://hub.docker.com and use the search field.

Good Luck, Teacher Todd
