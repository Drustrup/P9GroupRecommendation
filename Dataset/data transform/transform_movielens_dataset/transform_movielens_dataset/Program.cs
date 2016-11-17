using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Linq;


namespace transform_movielens_dataset
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Select a case: \n Case 1, generate the base matrix. \n Case 2, generate the total matrix");
            string selection = Console.ReadLine();

            switch (selection)
            {
                case "1":
                    generateBaseMatrix();
                    break;
                case "2":
                    totalMatrixRatings();
                    break;
                case "3":
                    generateTestMatrix();
                    break;
                default:
                    Console.WriteLine("Wrong case index.");
                    break;
            }

            Console.ReadKey();
        }

        public static void totalMatrixRatings()
        {
            Console.WriteLine("Hello, reading your data!");
            string pattern = @"\t| \r | \n | \' ";

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u_different_users.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u_different_movies.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u.data");

            //trackList = trackList.OrderBy(n => n).ToList();


            List<Tuple<string, string, int>> userAndTrackList = new List<Tuple<string, string, int>>();
            string track = null;
            string user = null;
            int ratings = 0;

            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToInt16(temp[2]);
                userAndTrackList.Add(new Tuple<string, string, int>(user, track, ratings));

            }
            datasetUsersAndTracks = null;

            userAndTrackList = userAndTrackList.OrderBy(x => Convert.ToInt16(x.Item1) ).ThenBy(x => Convert.ToInt16(x.Item2)).ToList();
           

            Console.WriteLine("Done reading data, saving to file");
            string path = @"e:/projects/p9/dataset/movielens/u_matrix.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                }
            }

            int rowLength = userList.Length;
            int columnLength = trackList.Count;
            int secondCount = 0;

            for (int i = 0; i < userList.Length; i++)
            {
                int count = 0;
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
                        sw.Write(element + "\t");
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }
        }

        public static void generateBaseMatrix()
        {
            Console.WriteLine("Hello, reading your data!");
            string pattern = @"\t| \r | \n | \' ";

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4_base_different_users.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4_base_different_movies.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4.base");

            //trackList = trackList.OrderBy(n => n).ToList();


            List<Tuple<string, string, int>> userAndTrackList = new List<Tuple<string, string, int>>();
            string track = null;
            string user = null;
            int ratings = 0;

            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToInt16(temp[2]);
                userAndTrackList.Add(new Tuple<string, string, int>(user, track, ratings));

            }
            datasetUsersAndTracks = null;



            Console.WriteLine("Done reading data, saving to file");
            string path = @"e:/projects/p9/dataset/movielens/u4_base_matrix.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                }
            }

            int rowLength = userList.Length;
            int columnLength = trackList.Count;
            int secondCount = 0;

            for (int i = 0; i < userList.Length; i++)
            {
                int count = 0;
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
                        sw.Write(element + "\t");
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }
            Console.ReadLine();
        }
        public static void generateTestMatrix()
        {
            Console.WriteLine("Hello, reading your data!");
            string pattern = @"\t| \r | \n | \' ";

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4_test_different_users.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4_test_different_movies.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u4.test");

            //trackList = trackList.OrderBy(n => n).ToList();


            List<Tuple<string, string, int>> userAndTrackList = new List<Tuple<string, string, int>>();
            string track = null;
            string user = null;
            int ratings = 0;

            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToInt16(temp[2]);
                userAndTrackList.Add(new Tuple<string, string, int>(user, track, ratings));

            }
            datasetUsersAndTracks = null;



            Console.WriteLine("Done reading data, saving to file");
            string path = @"e:/projects/p9/dataset/movielens/u4_test_matrix.txt";
            if (!File.Exists(path))
            {
                using (StreamWriter sw = File.CreateText(path))
                {
                }
            }

            int rowLength = userList.Length;
            int columnLength = trackList.Count;
            int secondCount = 0;

            for (int i = 0; i < userList.Length; i++)
            {
                int count = 0;
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
                        sw.Write(element + "\t");
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }
        }
    }
}
