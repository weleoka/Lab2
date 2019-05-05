# Load Initial Test Data info the SQL Server

In this step, you will load the SQL Server with the initial test data.  If needed, login to the VM Guest with a new SSH session.  
Perform the following in order to load the SQL Server with the initial test data:

1. Login to your VM Guest via an SSH client session

2. Use Docker compose to start all containers (see file host/Create_Test_Environment.md)

3. You need to copy the SQL source file to the container, with the following command:

```bash
cd ~/Lab2/sql_container 
docker cp test_data_1.sql mysql-test:/root/.
```

4. You need to enter the container with the following host command

```bash
docker exec -it mysql-test bash 
cd /root
```

Your prompt will change to the following: root@mysql:/#

You can exit the container at any time, with the command, "exit".

5. You need to install the MySQL client, into the container, with the following commands:

```bash
apt update 
apt install -y mysql-client
```

6. Login to MySQL Server.  When prompted, the password is "pw".  Here is the command:

```bash
mysql -p
```

7. You need to run the SQL script and here is the command:

```bash
source test_data_1.sql
```

If the above worked, you will see two students and two grades.

8. Quit MySql with the following command

```bash
quit
```

9. Carefully examine the file test_data_1.sql

Examine the script to better understand how to create test data scripts.  To view the file enter the following:

```bash
less test_data_1.sql
```

Then use "q" to quit.

10. As an optional excercise, create your own test data SQL script.

You can create a 2nd script and execute it.  
You can create tables, add rows to tables, etc.
