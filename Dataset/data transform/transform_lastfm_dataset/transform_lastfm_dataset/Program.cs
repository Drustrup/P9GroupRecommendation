using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;


namespace transform_lastfm_dataset
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, reading your data!");
            string pattern = @"\t| \r | \n | \' ";

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/random/1k_random_users.tsv");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/random/1k_random_tracks.tsv");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/random/1k_random_usersandtracks_edited.tsv");

            List<string[]> userAndTracks = new List<string[]>();

            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                if (temp.Length <= 1)
                {
                    string[] temp1 = { temp[0], "Ukendt" };
                    temp = temp1;
                    userAndTracks.Add(temp);
                }
                else
                {
                    userAndTracks.Add(temp);
                }
            }

            trackList = trackList.OrderBy(n => n).ToList();
            userAndTracks = userAndTracks.OrderBy(n => n[0]).ThenBy(n => n[1]).ToList();

            datasetUsersAndTracks = null;

            List<Tuple<string, string, int>> userAndTrackList = new List<Tuple<string, string, int>>();
            string track = null;
            string user = null;
            int count = 0;

            for (int i = 0; i < userAndTracks.Count; i++)
            {
                string[] temp = userAndTracks[i];


                if (track == null)
                {
                    count = 1;
                    user = temp[0];
                    track = temp[1];
                }
                else if (temp[1].Equals(track) && temp[0].Equals(user))
                {
                    count = count + 1;
                }
                else if ((!temp[1].Equals(track) || !temp[0].Equals(user)) && track != null)
                {
                    userAndTrackList.Add(new Tuple<string, string, int>(user, track, count));
                    count = 1;
                    user = temp[0];
                    track = temp[1];
                }
            }
            userAndTracks = null;            

            int rowLength = userList.Length;
            int columnLength = trackList.Count;

            int secondCount = 0;

            Console.WriteLine("Done reading data, saving to file");
            string path = @"e:/projects/p9/dataset/random/matrix.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                }
            }

            for (int i = 0; i < userList.Length; i++)
            {
                count = 0;
                string tempUser = userList[i];
                string tempTrack = trackList[count];
                //string ratings = null;

                List<double> normalizedRatings = new List<double>();
                user = userAndTrackList[secondCount].Item1;
                track = userAndTrackList[secondCount].Item2;

                while (user == tempUser)
                {
                    tempTrack = trackList[count];
                    if (track.Equals(tempTrack))
                    {
                        normalizedRatings.Add(userAndTrackList[secondCount].Item3);

                        secondCount++;
                        if (secondCount < userAndTrackList.Count)
                        {
                            user = userAndTrackList[secondCount].Item1;
                            track = userAndTrackList[secondCount].Item2;
                        }
                        else if (secondCount == userAndTrackList.Count)
                        {
                            user = null;
                        }

                    }
                    else if (!track.Equals(trackList[count]))
                    {
                        normalizedRatings.Add(0);
                    }

                    count++;
                }

                while (count < trackList.Count)
                {
                    normalizedRatings.Add(0);
                    count++;
                }

                double ratingSum = normalizedRatings.Sum(x => x);
                using (StreamWriter sw = File.AppendText(path))
                {
                    foreach (double element in normalizedRatings)
                    {
                        double temp = element * 100 / ratingSum;
                        string con = Convert.ToString(temp).Replace(',', '.');
                        sw.Write(con + "\t");
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }

            /**
            string path = @"e:/projects/p9/dataset/random/matrix.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                }
            } 
             
            for (int i = 0; i < userList.Length; i++)
            {
                count = 0;
                string tempUser = userList[i];
                string tempTrack = trackList[count];
                //string ratings = null;


                user = userAndTrackList[secondCount].Item1;
                track = userAndTrackList[secondCount].Item2;

                using (StreamWriter sw = File.AppendText(path))
                {
                    while (user == tempUser)
                    {
                        tempTrack = trackList[count];
                        if (track.Equals(tempTrack))
                        {
                            sw.Write(userAndTrackList[secondCount].Item3 + "\t");
                            secondCount++;
                            if (secondCount < userAndTrackList.Count)
                            {
                                user = userAndTrackList[secondCount].Item1;
                                track = userAndTrackList[secondCount].Item2;
                            }
                            else if (secondCount == userAndTrackList.Count)
                            {
                                user = null;
                            }

                        }
                        else if (!track.Equals(trackList[count]))
                        {
                            sw.Write(0 + "\t");
                        }

                        count++;
                    }

                    while (count < trackList.Length)
                    {
                        sw.Write(0 + "\t");
                        count++;
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }
            **/
            Console.ReadKey();
        }
    }
}
