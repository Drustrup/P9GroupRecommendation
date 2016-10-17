
SELECT userid, track
FROM lastfm.1k_america
ORDER BY userid, track ASC
INTO OUTFILE 'e:/projects/p9/dataset/1k_america_usersandtracks.tsv'
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'