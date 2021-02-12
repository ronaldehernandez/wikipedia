
CREATE TABLE CLICKSTREAM (
	referrer  STRING,
	request STRING,
	link_type STRING,
	ocurrences INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t'
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE CLICKSTREAM;


LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q2/clickstream-enwiki-2020-12.tsv' INTO TABLE CLICKSTREAM;


-- Q2.  What English wikipedia article has the largest fraction of its readers follow 
-- an internal link to another wikipedia article?
Select sum(ocurrences) As total FROM CLICKSTREAM

CREATE View REFERRER_INFO AS
Select referrer, sum(ocurrences) / 7169885099 As Fraction FROM CLICKSTREAM
WHERE link_type = 'link'
GROUP BY(referrer)
ORDER BY Fraction DESC;

SELECT * FROM REFERRER_INFO LIMIT 1;


-- Q3. What series of Wikipedia articles, starting with Hotel California, keeps the largest 
-- fraction of its readers clicking on internal links?  This is similar to (2), but you should 
-- continue the analysis past the first article.  There are multiple ways you can count this fraction, 
-- be careful to be clear about the method you find most appropriate.

-- obtain the total clicks from Hotel California to other articles, value is 13663
SELECT sum(ocurrences) FROM CLICKSTREAM 
WHERE link_type = 'link'
AND referrer = 'Hotel_California'
GROUP BY(referrer);

-- obtain series of articles, starting with Hotel California that keeps the largest fraction of readers 
-- clicking on internal links
-- Assumption: Hotel California is the Top Limit 

Select referrer, sum(ocurrences) / 7169885099 As Fraction FROM CLICKSTREAM
WHERE link_type = 'link'
GROUP BY(referrer)
HAVING sum(ocurrences) <= 13663
ORDER BY Fraction DESC;







