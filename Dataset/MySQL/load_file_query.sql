#Load 1k data.
#load data local infile 'E:/Projects/P9/Dataset/lastfm-dataset-1k/userid-timestamp-artid-artname-traid-traname.tsv' into table lastfm.1k;

#Load 1k users
#load data local infile 'E:/Projects/P9/Dataset/lastfm-dataset-1k/userid-profile.tsv' into table lastfm.1kusers;

#Load 360k data.
#load data local infile 'E:/Projects/P9/Dataset/lastfm-dataset-360k/usersha1-artmbid-artname-plays.tsv' into table lastfm.360k;

#Load 360k users.
#load data local infile 'E:/Projects/P9/Dataset/lastfm-dataset-360k/usersha1-profile.tsv' into table lastfm.360kusers;1k