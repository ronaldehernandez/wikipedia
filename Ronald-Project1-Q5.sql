
-- LOAD THE WIKI HISTORY ===============================================================================

CREATE TABLE wikihistory (
	wiki_db STRING,
	
	event_entity STRING,
	event_type STRING,
	event_timestamp STRING,
	event_comment STRING,
	event_user_id BIGINT,
	event_user_text_historical STRING,
	event_user_text STRING,
	event_user_blocks_historical STRING,
	event_user_blocks STRING,
	event_user_groups_historical STRING,
	event_user_groups STRING,
	event_user_is_bot_by_historical STRING,
	event_user_is_bot_by STRING,
	event_user_is_created_by_self BOOLEAN,
	event_user_is_created_by_system BOOLEAN,
	event_user_is_created_by_peer BOOLEAN,
	event_user_is_anonymous BOOLEAN,
	event_user_registration_timestamp STRING,
	event_user_creation_timestamp STRING,
	event_user_first_edit_timestamp STRING,
	event_user_revision_count BIGINT,
	event_user_seconds_since_previous_revision BIGINT,
	
	page_id BIGINT,
	page_title_historical STRING,
	page_title STRING,
	page_namespace_historical INT,
	page_namespace_is_content_historical BOOLEAN,
	page_namespace INT,
	page_namespace_is_content BOOLEAN,
	page_is_redirect BOOLEAN,
	page_is_deleted BOOLEAN,
	page_creation_timestamp STRING,
	page_first_edit_timestamp STRING,
	page_revision_count BIGINT,
	page_seconds_since_previous_revision BIGINT,
	
	user_id BIGINT,
	user_text_historical STRING,
	user_text STRING,
	user_blocks_historical STRING,
	user_blocks STRING,
	user_groups_historical STRING, 
	user_groups STRING,
	user_is_bot_by_historical STRING,
	user_is_bot_by STRING,
	user_is_created_by_self BOOLEAN,
	user_is_created_by_system BOOLEAN,
	user_is_created_by_peer BOOLEAN,
	user_is_anonymous BOOLEAN,
	user_registration_timestamp STRING,
	user_creation_timestamp STRING,
	user_first_edit_timestamp STRING,
	
	revision_id BIGINT,
	revision_parent_id BIGINT,
	revision_minor_edit BOOLEAN,
	revision_deleted_parts STRING,
	revision_deleted_parts_are_suppressed BOOLEAN,
	revision_text_bytes BIGINT,
	revision_text_bytes_diff BIGINT,
	revision_text_sha1 STRING,
	revision_content_model STRING,
	revision_content_format STRING,
	revision_is_deleted_by_page_deletion BOOLEAN,
	revision_deleted_by_page_deletion_timestamp STRING,
	revision_is_i dentity_reverted BOOLEAN,
	revision_first_identity_reverting_revision_id BIGINT,
	revision_seconds_to_identity_revert BIGINT,
	revision_is_identity_revert BIGINT,
	revision_is_from_before_page_creation BOOLEAN,
	revision_tags STRING,
	id INT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t'
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE wikihistory;

SELECT * FROM wikihistory LIMIT 10;

 LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q5/2020-12.enwiki.2021-01.tsv' INTO TABLE wikihistory;

-- OPTIONALLY, LOAD ONLY THE NECESSARY FIELDS =========================================================
-- edit the file prior to load
-- cut -f thefieldsyouwanttoextract theoriginalfile > thenewfile

DROP TABLE wiki;

CREATE TABLE wiki (
	event_entity STRING,
	event_timestamp STRING,
	event_user_id BIGINT,
	event_user_seconds_since_previous_revision BIGINT,
	page_title STRING,
	user_is_anonymous BOOLEAN,
	revision_deleted_parts STRING,
	revision_is_identity_reverted BOOLEAN,
	revision_first_identity_reverting_revision_id BIGINT,
	revision_seconds_to_identity_revert BIGINT
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t'
	TBLPROPERTIES("skip.header.line.count"="1");
	
DESCRIBE wiki;

LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q5/wikihistory.txt' INTO TABLE wiki;
SELECT * FROM wiki;

-- LOAD THE ARTICLES ==================================================================================

DROP VIEW REVERTEDARTICLES;

CREATE VIEW REVERTEDARTICLES AS
SELECT event_timestamp, page_title, event_user_seconds_since_previous_revision AS revised_seconds_ago, revision_seconds_to_identity_revert AS reverted_seconds_ago,  revision_deleted_parts, revision_is_identity_reverted
FROM wikihistory
WHERE event_entity = 'revision'
AND revision_deleted_parts = 'text'
AND event_user_seconds_since_previous_revision > revision_seconds_to_identity_revert;

SELECT * FROM REVERTEDARTICLES LIMIT 10;

DROP TABLE ARTICLEVIEWS;

CREATE TABLE ARTICLEVIEWS (
	domain_code STRING,
	article_title STRING,
	count_views INT,
	total_response_size INT)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ' '
	TBLPROPERTIES("skip.header.line.count"="1");
	
 LOAD DATA LOCAL INPATH '/home/ronald/clickstream/Q5/pageviewsQ5.txt' INTO TABLE ARTICLEVIEWS;

SELECT * FROM ARTICLEVIEWS LIMIT 10;

-- Q5. Analize how many users will see the average vandalized wikipedia page before the offending edit is reversed

SELECT aw.article_title, SUM(aw.count_views) As article_views FROM ARTICLEVIEWS aw
INNER JOIN REVERTEDARTICLES ra ON aw.article_title = ra.page_title
WHERE aw.domain_code = 'en'
GROUP BY aw.article_title
ORDER BY article_views DESC;



