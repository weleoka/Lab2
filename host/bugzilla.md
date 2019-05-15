# Install the BugZilla Bug Tracking Server

In this part of the lab your job is to set up the bug tracker and the system we are going to test.
After setup, you will enter one or more bugs into the tracker system.  To achieve this you are going to use AWS and Docker, there are docker containers for everything needed but you might have to edit some configurations for things to work. Use the Docker documentation to get started.

There might not be enough RAM (memory) on your Host for BugZilla and the previous containers, at the same time.
So, please stop the previous containers.
If you need to start them again, use the docker start command.

If you are stuck, here is the hint:

```bash
docker stop mysql-test web vpn dns
```

During this lab, you can check your memory with top.
If you are stuck, here is the hint:

```bash
top
```

If you need to restart your computer, you will need to do the following:

```bash
# Check if BugZilla is running
docker ps -a bugzilla

# Restart the BugZilla container, if needed
docker start bugzilla
```

Then you need to enter the Bugzilla container

```bash
docker exec -it bugzilla bash

# Check if MySql is running
service mysql status

# If stopped, restart it
service mysql start
```

Prior to installing BugZilla, it is recommended that you first configure your Amazon AWS firewall.
Todd provided information, how to do that, in the create Host video tutorials.
Note that BugZilla has a MySQL server which is different than the previous MySQL server you setup for the test environment.

Download a copy of the BugZilla GitHub files.

```bash
cd
git clone https://github.com/chardek/docker-bugzilla.git

# Change to the new directory
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

Note that the log states "No such file or directory" for the file params, so there is something wrong.

Enter the container and run ./checksetup.pl.

If stuck, here is the hint:

```bash
# first, enter into the container
docker exec -it bugzilla bash

# run checkup
./checksetup.pl
```

You'll see an error that there is a problem connecting to MySQL, which is perhaps not running.
So let's install MySQL server.

If stuck, here is the hint.

```bash
apt update
apt install -y mysql-server
```

There is a prompt for the MySQL root user's password.
For these instructions, it will be assumed you entered, "bugsbugs".

After the above completes, try running ./checksetup.pl again.

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
So go ahead and start the MySql server.

If stuck, here is the hint:

```bash
service mysql start
```

Now check the status again:

If stuck, here is the hint:

```bash
service mysql status
```

That should look much better.
Now try running the setup script again.

If stuck, here is the hint again:

```bash
./checksetup.pl
```

The connect to MySQL errors are gone.
However, we have an "Access denied", which we need to fix.
We need to create the user bugs and give bugs all rights.

If stuck, here is the hint:

```bash
# use the password, bugsbugs
mysql -p

# The last field, 'bugsbugs' is the password
GRANT ALL PRIVILEGES ON *.* TO 'bugs'@'localhost' IDENTIFIED BY 'bugsbugs';
quit
```

You need to change the default password to bugsbugs in the localconfig file

You'll need to first install an editor

If stuck, here is the hint:

```bash
apt install -y nano

# edit the file
nano localconfig
```

find and edit the line to the following:
$webservergroup = 'www-data';

find and edit the line to the following:
$db_pass = 'bugsbugs';

Save the file and quit Nano.

Run the checksetup.pl script.  
This will attempt to create the database and tables for BugZilla.

If stuck, here is the hint:

```bash
./checksetup.pl
```

It should now work and prompt you for the Administrator's email, name, and password.
Todd used the following, as an example:

Email: Admin101@ToddBooth.Com

For the password, use the following:

Administrator pw: bugsbugs

Now test bugszilla to try and access the default homepage.

If stuck, here is the hint:

```bash
# You need to first exit the container, with "exit".
# Now you are on the Host

# There is a port mapping from the localhost to the container, so we can access the Host via localhost to get to the container.
curl localhost
```

You have now done the installation and the basic configuration, for BugZilla.

Now access the bugzilla container from a web browser, in the normal way you always do.

From your SSH client node, start up a Web browser, and surf to the public IP address of your Host.
Click on the Log in button.

Then enter your Adminstrator email and password, into the login box.
Todd used:

For the email and password, enter whatever you entered above.
Here is what Todd entered above:

Email: Admin101@ToddBooth.Com

Password: bugsbugs

This will bring you to the Administrator's web page.
Accessing the administrators page means that the BugZilla server is working properly.
You need to configure the urlbase, administrators web page.

Click on the urlbase button.  Change the urlbase, to the following, but change the IP address to your public host IP address:

http://1.1.1.1/bugzilla/

Then at the bottom left, click on the Save Changes button.

Then surf again to the default web page, but change the IP address to your public host IP address:

http://1.1.1.1

Then please see all the video tutorials at the following [YouTube Web Page Playlist](https://www.youtube.com/playlist?list=PLd43cTxFZWlflQiIdhCNcxJ0XFEouK-Bi).

Please see the following BugZilla for beginner's [Web Page](https://www.guru99.com/bugzilla-tutorial-for-beginners.html).

Then review the official BugZilla document guide, which is found at the [Following URL](https://www.bugzilla.org/docs/2.16/html/).
You should carefully review the 2. Introduction and 3. Using BugZilla sections.
Please carefully review the 3.1.3 Life Cycle of a Bug, which is in a flowchart format.

Before reporting a bug, please read the Bug Writing Guidelines, please look at the list of most frequently reported bugs, and please search for the bug.
You will see these options after you click on the File a Bug icon/button.

Click on File a Bug

Enter more detailed information, about the bug.

Include any file attachment, as part of the bug report.
You need to attach a small file, so a Text file is recommended.

Submit the bug, and verify that "The bug was created successfuly".

Note: In this BugZilla lab, we didn't setup email support, so it is not possible to add a new user.
Therefore, file bugs when logged in as the Administrator.