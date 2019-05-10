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

The instructions will ask you to do something.  
Try to do things without reading the details hints.
I.E., only use the details hints when you get stuck.
If anything does not work properly, please send Todd an email.

Optional Advanced Activities: Perform more advanced configuration for the mySql Web, VPN, DNS, and/or the Bugzilla servers

## Step 1. Review Docker Compose

Docker compose is a tool allowing us to more easily manage the creation of several docker container at the same time.
We will use the tool docker compose to create two of the containers.

First, please see this 12 minute [YouTube Docker Tutorial[(https://www.youtube.com/watch?v=YFl2mCHdv24&t=168s).

Then please see this 18 minute [YouTube Docker Compose Tutorial](https://www.youtube.com/watch?v=HUpIoF_conA&t=717s).
Now, you will execute docker compose.

1. Change to the directory Lab2

If stuck, here is the hint.

```bash
cd ~/Lab2/host
```

2. Review the docker compose file

Try to understand the docker compose file.

If stuck, here is the hint, on one way to review it

```bash
less compose1.yml
# "q" to quit
```

## Step 2. Pull Docker Images

Download the images before running docker-compose.

```bash
docker pull mysql
docker pull httpd
docker pull kylemanna/openvpn
docker pull resystit/bind9
docker pull chardek/bugzilla
```

We will use docker-compose to create the test environment SQL and Web servers.
We will use docker, on its own, to create the OpenVPN, DNS, and Bugzilla servers.

## Step 3. Execute the Docker Compose Command

If stuck, here is the hint.

The -d puts the process in the background.
If you don't use -d, you need to open a 2nd client to Host SSH session.

```bash
# Create the Test Environment containers
cd ~/Lab2/host
docker-compose -f compose1.yml up -d
```

The above flag "-d" starts it in the background, so you don't see the log file messages.
Execute the docker command to show the log files for the container web.

If stuck, here is the hint:

```bash
# Create the Test Environment containers
docker logs web
docker logs mysql-test
```

How would you delete all test environment containers, in order to start over?

If stuck, here is the hint.

```bash
# Optional - if you want to delete all test environment containers, execute this
docker rm -f mysql-test web vpn dns bugzilla
```

Optional: If you wish to be a professional, working with Linux, it is recommended that you learn to use a window session manager, which supports multiple tabbed interfaces, such as tmux.
[Here is the URL](https://gist.github.com/MohamedAlaa/2961058) to a Tmux Cheat Sheet.

If you find a good tmux video tutorial for beginners, please let Todd know and he'll add it to this section.
Todd reviewed several YouTube tmux videos but didn't like them.

## Step 4. Verify that the Web server is Running

In this task, you will verify that the Web Server is running and serving web pages.
We will use a command line tool to make a request to get a Web page.
The tool is called curl.

Since curl is not a Web browser, you will see all the html tags.
I.E., curl reads, but does not render HTML code.
Use curl to retrieve the home web page.

If stuck, here is the hint.

Execute the following from the Host to obtain the IP address of the Web server.
Note that case is sensitive, so you must enter the following with capital "IPA" and lower case "ddress".

```bash
docker inspect web | grep IPAddress
```

In the following change 172.23.0.2 to whatever IP address was returned above.

```bash
curl 172.23.0.2
```

## Step 5. Configure and Verify that the OpenVpn Server is Running

The docker compose started most containers, but did not start the OpenVPN container, so we'll start that manually.

Try to follow the Web page directions on your own to create the OpenVPN Container.
[Here is the URL](https://hub.docker.com/r/kylemanna/openvpn).

If stuck, here is the hint.

You need to first set an environment variable.

```bash
OVPN_DATA="ovpn-data-example"
```

hen you need to create a volume.

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

Re-Enter New CA Key Passphrase: phrase22

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

Check to see if the vpn container is running.

Here is the hint:

The following should say, "Up"

```bash
docker ps -a | grep vpn
```

## Step 6. Configure and Verify that the DSN Server is Running

You first need to configure the DNS server.
Todd has created an initial configuration.
As an optional excercise for advanced students, you can modify Todd's configuration.
Documentation for the DNS server is found at [This URL](https://help.ubuntu.com/lts/serverguide/dns-configuration.html.en).
Todd's configuration files is found in /home/ubuntu/Lab2/host/named.conf and example.com.db.

Start the DNS Container.

If stuck, here is the hint:

```bash
docker run -d --hostname dns --name dns -p 54:53 -p 54:53/udp \
    -v /home/ubuntu/Lab2/host/named.conf:/etc/bind/named.conf \
    -v /home/ubuntu/Lab2/host/example.com.db:/etc/bind/example.com.db resystit/bind9:latest
```

If you get an error that the container name dns is already in use, first delete it.

If stuck, here is the hint:

```bash
docker rm -f dns
```

You started docker run in the background, since you used the "-d" flag.
So you should take a look at your logs, since you missed the startup messages.
Look at the logs.

If stuck, here is the hint:

```bash
docker logs dns
```

You now need to test the dns server.
Try resolving the name "example.com"

In the following, "docker exec dns" means we want to execute a command in the dns container.
"nslookup" is a DNS testing tool.
Use "nslookup example.com" to  attempt to find the IP address.

If stuck, here is the hint:

```bash
docker exec dns nslookup example.com
```

You should ignore the "can't resolve (null)" message.
If it worked, you should get back the IP address 93.184.216.34, which is the IP address of example.com

## Step 7. Install BugZilla Gug Tracking Server

Download a copy of the BugZilla GitHub files.

```bash
cd
git clone https://github.com/chardek/docker-bugzilla.git
```

Change to the new directory

```bash
cd docker-bugzilla
```

Build BugZilla docker image from scratch.

If stuck, here is the hint:

The -t will name the image bugzilla.

```bash
docker build -t bugzilla .
```

This will take several minutes.
Verify that the BugZilla docker image was created and verify that the name "bugzilla" name has been added to the image, on the far left, under Repository.

```bash
docker image ls
```

The image will be on the top and say "CREATED" recently.

Now from the image, run a BugZilla container.
Give it a docker container name and a hostname.

If stuck, here is the hint:

The -d parameter runs the container in the background.

```bash
docker run -d -p 80:80/tcp --name bugzilla --hostname bugzilla bugzilla
```

Review the log file messages.

If stuck, here is the hint:

```bash
docker logs bugzilla
```

Note that the log states "No such file or directory".

Enter the container and run ./checksetup.pl.

If stuck, here is the hint:

```bash
# first, enter into the container
docker exec -it bugzilla bash

./checksetup.pl
```

You'll see an error that there is a problem with MySQL, which is not running.
So install MySQL server.

If stuck, here is the hint.

```bash
apt update
apt install -y mysql-server
```

Use the database root user password of "bugs".

After the above completes, run ./checksetup.pl again.

If stuck, here is the hint again:

```bash
./checksetup.pl
```

The error for MySql still exists.
So try checking the status of the MySql server.

If stuck, here is the hint:

```bash
service mysql status
```

You will see that the server is stopped.
So go ahead and state the MySql server.

If stuck, here is the hint:

```bash
service mysql start
```

Now check the status again:

If stuck, here is the hint:

```bash
service mysql status
```

That should look better.
Now try running the setup script again.

If stuck, here is the hint again:

```bash
./checksetup.pl
```

It still fails.
We need to create the user bugs and give bugs all prvileges.

If stuck, here is the hint:

```bash
# use the password, bugs
mysql -p

# The last field, 'bugs' is the password
GRANT ALL PRIVILEGES ON *.* TO 'bugs'@'localhost' IDENTIFIED BY 'bugs';
quit
```

# You need to change the default password to bugs in the localconfig file

You'll need to first install an editor

If stuck, here is the hint:

```bash
apt install -y nano

# edit the file
nano localconfig
```

# find and edit the line to the following:
$db_pass = 'bugs';

# find and edit the line to the following:
$webservergroup = 'www-data';

Save the file and quit Nano.

Run the init script again

If stuck, here is the hint again:

```bash
./checksetup.pl
```

It should now work and prompt you for your email, name, and password.

For the password, use the following:

Administrator pw: bugsbugs

Now test bugszilla to see what web page is default homepage is returned.

In a new session, get access to the Host.

Find the IPAddress of the bugzilla container.

If stuck, here is the hint:

```bash
docker inspect bugzilla | grep IPAddress
```

Using the bugzilla IPAddress, simulate a user requesting the homepage, with curl.

If stuck, here is the hint:

```bash
curl 172.17.0.3
```

Now access the bugzilla container from a regular browser.
From the SSH clint, start up a Web browser, and surf to the public IP address of your Host.

You have now done the installation and the basic configuration, for BugZilla.

Optional Activity for advanced students: Add a few more docker containers to the docker compose file.
To find candidates, surf to https://hub.docker.com and use the search field.

Good Luck, Teacher Todd
