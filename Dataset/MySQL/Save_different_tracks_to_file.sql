USE lastfm;
SELECT 
	DISTINCT 1k_america.track 
FROM
	1k_america
ORDER BY 
	track
INTO OUTFILE 
	'e:/projects/p9/dataset/1kusers_america_different_tracks.tsv'
FIELDS TERMINATED BY '\t' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';