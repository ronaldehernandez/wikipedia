Data Mining Wikipedia (Project 1)

Project Description

Project 1's analysis consists of using big data tools to answer questions about datasets from Wikipedia. There are a series of basic analysis questions, answered using Hive HQL. The output of the analysis includes .hql files so that the analysis is a repeatable process that works on a larger dataset, not just an ad hoc calculation. Assumptions and simplifications are required in order to answer these questions, and the final presentation of results includes a discussion of those assumptions/simplifications and the reasoning behind them. Finally, in addition to code outputs, this project requires a simple slide deck providing an overview of results. 

Technologies Used

Windows Subsystem for Linux - version 2.0
Ubuntu Linux - version 20.04
Hive  - version 2.3.8

Features, questions answered

1. Which English wikipedia article got the most traffic on October 20, 2020? 
2. What English wikipedia article has the largest fraction of its readers follow an internal link to another wikipedia article? 
3. What series of wikipedia articles, starting with Hotel California, keeps the largest fraction of its readers clicking on internal links? 
4. Find an example of an English wikipedia article that is relatively more popular in the UK, then find the same for the US and Australia. 
5. How many users will see the average vandalized wikipedia page before the offending edit is reversed? 
6. What was trending last year on a day like today?

# Getting Started

git clone https://github.com/ronaldehernandez/wikipedia/

sudo service ssh start
startdfs
startyarn
jps                           <-- check that the cluster started correctly

hiveserver2
beeline -u jdbc:hive2://localhost:10000         <- In new Ubuntu window, check hive server runs, Ctrl+D to exit

# PLACE A CSV FILE THAT HAS DATA, IN THE LOCAL FILE SYSTEM ----------

touch myFile.csv        <-- I created the file
nano  myFile.csv        <-- I opened the file and pasted some csv data

# CREATE A FOLDER IN HDFS AND PLACE THE NEWLY CREATED CSV FILE THERE-

hdfs dfs -mkdir myClusterFolder
hdfs dfs -put myFile.csv myClusterFolder

All the code required to get started
Images of what it should look like

Usage
Here, you instruct other people on how to use your project after they’ve installed it. This would also be a good place to include screenshots of your project in action.

Contributors
Here list the people who have contributed to this project. (ignore this section, if its a solo project)

License

