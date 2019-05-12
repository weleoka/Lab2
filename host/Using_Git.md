# Using Git

This document will help you with a few Git commands.
NOTE: In general, don't copy and paste mutliple commands at the same time.
Either type one command at a time, or copy and paste one command at a time and observe the output to see if you ran into any issues.
Then it will be easier to know which specific command failed, if any.
Git is a tool that allows developers, testers, and operations stuff to efficiently exchange files.
It supports versioning so that previous versions can be retrived.
Please learn about Git, with this [YouTube Crash Course for Beginners.](https://www.youtube.com/watch?v=SWYqp7iY_Tc).

1. Ssh to your VM Guest on AWS.

2. You need to download the Lab2 files from GitHub.  You can do that with the following commands:

```bash
cd  
git clone https://github.com/ToddBooth/Lab2 
cd Lab2
```

3. You need to be able to download any updates

From time to time Todd will update the GitHub files and you need to download the current version.  You can do that with the following commands:

```bash
cd ~/Lab2  
git pull  
```

4. Warning about modifying files

In general, you should not modify the files you download since they will be overwritten when you download new versions.
So it is better for you to create new files, if that is needed.

Good Luck, Teacher Todd