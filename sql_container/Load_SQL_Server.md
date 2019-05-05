# Load Initial Test Data info the SQL Server

In this step, you will load the SQL Server with the initial test data.  If needed, login to the VM Guest with a new SSH session.  
Perform the following in order to load the SQL Server with the initial test data:

1. Login to your VM Guest via an SSH client session

2. You need to copy the SQL source file to the container, with the following command:

cd ~/Lab2/sql_container 
docker cp test_data_1.sql mysql-test:/root/.

3. You need to enter the container with the following host command

docker exec -it mysql-test bash 
cd /root

Your prompt will change to the following: root@mysql:/#

You can exit the container at any time, with the command, "exit".

4. You need to install the MySQL client, into the container, with the following commands:

apt update 
apt install -y mysql-client

5. Login to MySQL Server.  When prompted, the password is "pw".  Here is the command:

mysql -p

6. You need to run the SQL script and here is the command:

source test_data_1.sql

If the above worked, you will see two students and two grades.

7. Quit MySql with the following command

quit

8. Carefully examine the file test_data_1.sql

Examine the scripot to better understand how to create test data scripts.  To view the file enter the following:

less test_data_1.sql

Then use "q" to quit.

9. As an optional excercise, create your own test data SQL script.

You can create a 2nd script and execute it.  
You can create tables, add rows to tables, etc.
