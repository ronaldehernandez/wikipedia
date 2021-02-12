
CREATE TABLE TRENDINGVIEWS (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE TRENDINGVIEWS;

LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q6/dataset6.txt' INTO TABLE TRENDINGVIEWS;

-- Q6.  What was trending last year on a day like today?

SELECT page_title, SUM(count_views) As View_Count
FROM TRENDINGVIEWS 
WHERE domain_code = 'en'
AND page_title != 'Main_Page'
AND page_title != 'Special:Search'
GROUP BY page_title
ORDER BY View_Count DESC
LIMIT 10;

