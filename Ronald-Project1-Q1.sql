
CREATE TABLE PAGEVIEWS (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE PAGEVIEWS;

LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q1/pageviews.txt' INTO TABLE PAGEVIEWS;

-- Q1.  Which English wikipedia article got the most traffic on January 20, 2021

CREATE View Article_Info AS
SELECT page_title, SUM(count_views) As View_Count
FROM PAGEVIEWS 
WHERE domain_code = 'en'
AND page_title != 'Main_Page'
AND page_title != 'Special:Search'
GROUP BY page_title
ORDER BY View_Count DESC;

SELECT * FROM Article_Info LIMIT 1;




