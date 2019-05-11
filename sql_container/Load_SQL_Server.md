# Load Initial Test Data info the SQL Server

In this step, you will load the SQL Server with the initial test data.  If needed, login to the VM Guest with a new SSH session.  
Perform the following in order to load the SQL Server with the initial test data:

## Step 1. Login to your Host via an SSH client session

The instructions were provided previously.

## Step 2. Use Docker compose to start all containers (
    
The instructions were provided in the file host/Create_Test_Environment.md.

## Step 3. Copy the SQL Source File to the Container

```bash
cd ~/Lab2/sql_container 
docker cp test_data_1.sql mysql-test:/root/.
```

## Step 4. Enter the Container

```bash
docker exec -it mysql-test bash
cd /root
```

Your prompt will change to the following: root@mysql:/#

You can exit the container at any time, with the command, "exit".

## Step 5. Install the MySQL client

You must install the MySQL client into the container.

```bash
apt update
apt install -y mysql-client
```

## Step 6. Login to MySQL Server.  

When prompted, the password is "bugsbugs".  Here is the command:

```bash
mysql -p
```

## Step 7. Run the SQL Script

To load the test environment's SQL test data, run the following:

```bash
source test_data_1.sql
```

If the above worked, you will see two students and two grades.

## Step 8. Quit MySql

```bash
quit
```

## Step 9. Carefully Examine the Test Data

Examine the script to better understand how to create test data scripts.  To view the file enter the following:

```bash
less test_data_1.sql
```

Then use "q" to quit.

## Step 10. Create and Load your own Test Data

In this step, you will create your own SQL Test Data and load that data into the Test Environment's MySQL server.

Please do not modify any of the files that were provided to you via git.
The reason is, Todd will modify the git files from time to time, to resolve defects.
If Todd fixes a problem you report, Todd might ask you to pull the new updated files.
Then, you will download the updated files with the following command, which must be executed from the Host, not the containers.

```bash
git pull
```

However, if you modify files, they will conflict with Todd's updated files.
So instead, you will make copies of Todd's files, and then you will update your own files.
First, on the Host, please make copies of the following file:

```bash
cd ~/Lab2/sql_container
cp test_data_1.sql test_data_2.sql
```

Now you need to add rows to the test data.  
Review the test_data_2.sql to see how to write an SQL Query, which displays a given student record.
Then execute your own SQL Query, which displays only your student record and grade.
So edit the new test_data_2.sql test data with the editor, "Nano".

```bash
nano test_data_2.sql
```

In the test data file, add a student row, with your name and student ID.
Add a grade row, where you received a VG.
When you are done editing the new file, copy the new file to the container.
Enter these commands, to copy your new file to the container:

```bash
cd ~/Lab2/sql_container
docker cp test_data_2.sql mysql-test:root/.
```

## Step 6. Login to MySQL Server.  

Now enter into the mysql-test running container:

```bash
docker exec -it mysql-test bash
```

In the Container, change to the root directory:

```bash
cd /root
```

Execute the MySql client.
When prompted, the password is "bugsbugs".  Here is the command:

```bash
mysql -p
```

To load the test environment's SQL test data, run the following, and be sure to enter your new test data script:

```bash
source test_data_2.sql
```

If the above worked, you will now also see youself as a student and that you have a grade of VG.
