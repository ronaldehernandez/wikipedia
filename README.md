Data Mining Wikipedia (Project 1)

Explanation and Overview

Project 1's analysis consists of using big data tools to answer questions about datasets from Wikipedia. There are a series of basic analysis questions, answered using Hive HQL. The output of the analysis includes .hql files so that the analysis is a repeatable process that works on a larger dataset, not just an ad hoc calculation. Assumptions and simplifications are required in order to answer these questions, and the final presentation of results includes a discussion of those assumptions/simplifications and the reasoning behind them. Finally, in addition to code outputs, this project requires a simple slide deck providing an overview of results. 

List of Features implemented, questions answered with HQL

1. Which English wikipedia article got the most traffic on October 20, 2020? 
2. What English wikipedia article has the largest fraction of its readers follow an internal link to another wikipedia article? 
3. What series of wikipedia articles, starting with Hotel California, keeps the largest fraction of its readers clicking on internal links? 
4. Find an example of an English wikipedia article that is relatively more popular in the UK, then find the same for the US and Australia. 
5. How many users will see the average vandalized wikipedia page before the offending edit is reversed? 
6. What was trending last year on a day like today?

Technologies Used

Windows Subsystem for Linux - version 2.0
Ubuntu Linux - version 20.04
Hive  - version 2.3.8
Hadoop - version 2.7.7

# Getting Started

git clone https://github.com/ronaldehernandez/wikipedia/

sudo service ssh start
startdfs
startyarn
jps                           <-- check that the cluster started correctly

hiveserver2
beeline -u jdbc:hive2://localhost:10000         <- In new Ubuntu window, check hive server runs, Ctrl+D to exit

# Download the Datasets ----------

Datasets corresponding to the questions are downloaded from 

https://dumps.wikimedia.org/other/pageviews
https://dumps.wikimedia.org/other/clickstream
https://dumps.wikimedia.org/other/mediawiki_history

# Load the datasets --------------

Datasets can be extracted with gunzip*.gz
Datasets are loaded into your Hive Database by

LOAD DATA LOCAL INPATH "path of your downloaded files" INTO TABLE yourTable

(See the powerpoint slides for further details including images)

# Run the Queries ----------------

After the dataset is loaded into the table you can perform the HQL operations on the table

(See the powerpoint slides for further details including images)




