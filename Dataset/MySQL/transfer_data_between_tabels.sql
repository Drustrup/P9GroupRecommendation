#Query to get a subset of users from the 1k-dataset. Change the where clause to fit.
/**INSERT INTO 
	lastfm.1kusers_america ( 
	1kusers_america.userid, 
	1kusers_america.gender, 
	1kusers_america.age,
    1kusers_america.country,
    1kusers_america.registered ) 
SELECT
	1kusers.userid, 
	1kusers.gender, 
	1kusers.age,
    1kusers.country,
    1kusers.registered
FROM 
	lastfm.1kusers
WHERE
	1kusers.country = 'United States'
**/
#Query for getting the artit and tracks the subset of users have listened too from the 1k dataset.
/**
INSERT INTO 
	lastfm.1k_america ( 
	1k_america.userid, 
	1k_america.timestamp, 
	1k_america.artistid,
    1k_america.artist,
    1k_america.trackid,
    1k_america.track) 
SELECT
	1k.userid, 
	1k.timestamp, 
	1k.artistid,
	1k.artist,
	1k.trackid,
	1k.track
FROM 
	lastfm.1k
WHERE
	(SELECT COUNT(*)
    FROM lastfm.1kusers_america
    WHERE 1kusers_america.userid = 1k.userid)
ORDER BY 1k.userid ASC 
**/
/**
#Query to get a subset of users from the 360k-dataset. Change the where clause to fit.
INSERT INTO 
	lastfm.360kusers_america ( 
	360kusers_america.userid, 
	360kusers_america.gender, 
	360kusers_america.age,
    360kusers_america.country,
    360kusers_america.registered ) 
SELECT
	360kusers.userid, 
	360kusers.gender, 
	360kusers.age,
    360kusers.country,
    360kusers.registered
FROM 
	lastfm.360kusers
WHERE
	360kusers.country = 'United States'
**/
/**
#Query for getting the artit and tracks the subset of users have listened too from the 1k dataset. (Does not work proberly)
INSERT INTO 
	lastfm.360k_america ( 
	360k_america.userid,  
	360k_america.artistid,
    360k_america.artist,
    360k_america.plays) 
SELECT
	360k.userid,  
	360k.artistid,
	360k.artist,
	360k.plays
FROM 
	lastfm.360k
WHERE
	(SELECT COUNT(*)
    FROM lastfm.360kusers_america
    WHERE 360kusers_america.userid = 360k.userid)
ORDER BY 360k.userid ASC 
