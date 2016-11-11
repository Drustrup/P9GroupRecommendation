USE lastfm;
SELECT 
	DISTINCT track
FROM
	1k_random
ORDER BY 
	track asc
INTO OUTFILE 
	'e:/projects/p9/dataset/1k_random_different_tracks.tsv'
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n';