
CREATE TABLE pvsAmerica (
	domain_code STRING,
	article STRING,
	count_views INT,
	response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE pvsAmerica;

LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q4/pageviewsAmerica.txt' INTO TABLE pvsAmerica;

CREATE TABLE pvsWorld (
	domain_code STRING,
	article STRING,
	count_views INT,
	response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE pvsWorld;

 LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q4/pageviewsWorld.txt' INTO TABLE pvsWorld;

-- Q4. Find an example of an English wikipedia article that is relatively more popular in the Americas than elsewhere. 
-- English article whose sum of views in America is greater than its sum of views elsewhere

SELECT pga.article FROM pvsAmerica pga 
INNER JOIN pvsWorld pgw ON pga.article = pgw.article
WHERE pga.domain_code = 'en'
GROUP BY pga.article, pgw.article
HAVING SUM(pga.count_views) > SUM(pgw.count_views)
ORDER BY pga.article ASC;



