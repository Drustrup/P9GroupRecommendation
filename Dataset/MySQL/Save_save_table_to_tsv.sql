
SELECT userid
FROM lastfm.1kusers_random
ORDER BY userid ASC
INTO OUTFILE 'e:/projects/p9/dataset/1k_random_users.tsv'
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'