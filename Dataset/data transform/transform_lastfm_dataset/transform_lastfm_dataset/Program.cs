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

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/america/1kusers_america.tsv");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/america/1k_america_tracks.tsv");
            string[] trackList = new string[datasetTracks.Length];

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList[i] = temp[0].Replace("\"", "");
            }
            datasetTracks = null;
            Array.Sort(trackList);

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/america/1k_america_usersandtracks_edited.tsv");
            List<Tuple<string, string, int>> userAndTrackList = new List<Tuple<string, string, int>>();
            string track = null;
            string user = null;
            int count = 0;
            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                if (temp.Length <= 1)
                {
                    string[] temp1 = { temp[0], "Ukendt" };
                    temp = temp1;
                }

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
            datasetUsersAndTracks = null;
            userAndTrackList = userAndTrackList.OrderBy(n => n.Item1).ThenBy(n => n.Item2).ToList();

            int rowLength = userList.Length;
            int columnLength = trackList.Length;

            int secondCount = 0;

            Console.WriteLine("Done reading data, saving to file");

            string path = @"e:/projects/p9/dataset/america/matrix.txt";
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

            Console.ReadKey();
        }
    }
}
