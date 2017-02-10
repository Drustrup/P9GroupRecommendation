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
            Console.WriteLine("Select a case: \n Case 1, generate the base matrix. \n Case 2, generate the total matrix \n Case 3, generate test matrix ");
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
            string pattern = @"\t| \r | \n | \' | \,";

            string[] datasetUsers = File.ReadAllLines(Environment.CurrentDirectory + @"\..\..\..\..\..\ml-20m\different_users.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(Environment.CurrentDirectory + @"\..\..\..\..\..\ml-20m\different_movies.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(Environment.CurrentDirectory + @"\..\..\..\..\..\ml-20m\ratings.csv");
            
            //trackList = trackList.OrderBy(n => n).ToList();


            List<Tuple<string, string, double>> userAndTrackList = new List<Tuple<string, string, double>>();
            string track = null;
            string user = null;
            double ratings = 0;

            //Start on index 1, as first line is metainfo
            for (int i = 1; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = datasetUsersAndTracks[i].Replace("\"", "").Split(',');

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToDouble(temp[2]);
                userAndTrackList.Add(new Tuple<string, string, double>(user, track, ratings));

            }
            datasetUsersAndTracks = null;

            userAndTrackList = userAndTrackList.OrderBy(x => Convert.ToInt32(x.Item1) ).ThenBy(x => Convert.ToInt32(x.Item2)).ToList();
            /**
            string[] datasetValidationUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/ml-20m/u1.test");

            List<Tuple<string, string, int>> validationUserAndTrackList = new List<Tuple<string, string, int>>();

            for (int i = 0; i < datasetValidationUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetValidationUsersAndTracks[i].Replace("\"", ""), pattern);

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToInt16(temp[2]);
                validationUserAndTrackList.Add(new Tuple<string, string, int>(user, track, 0));

            }
            datasetValidationUsersAndTracks = null;

            validationUserAndTrackList = validationUserAndTrackList.OrderBy(x => Convert.ToInt16(x.Item1)).ThenBy(x => Convert.ToInt16(x.Item2)).ToList();

            int count = 0;

            for (int i = 0; i < userAndTrackList.Count; i++)
            {
                if (userAndTrackList[i].Item1.Equals(validationUserAndTrackList[count].Item1) && userAndTrackList[i].Item2.Equals(validationUserAndTrackList[count].Item2))
                {
                    userAndTrackList.RemoveAt(i);
                    userAndTrackList.Insert(i, validationUserAndTrackList[count]);
                    if (count < validationUserAndTrackList.Count -1)
                    {

                        count++;
                    }
                }
            }
            datasetUsersAndTracks = null;
    **/
            int count = 0;
            Console.WriteLine("Done reading data, saving to file");
            string path = Environment.CurrentDirectory + @"\..\..\..\..\..\ml-20m\matrix.txt";
            //@"e:/projects/p9/dataset/ml-20m/matrix.txt";
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
                        sw.Write(element + "\t");
                    }
                    sw.WriteLine(Environment.NewLine);
                }

                Console.WriteLine("User " + (i + 1) + " out of " + userList.Length);
            }
            Console.ReadLine();
        }

        public static void generateBaseMatrix()
        {
            Console.WriteLine("Hello, reading your data!");
            string pattern = @"\t| \r | \n | \' ";

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3_base_different_user.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3_base_different_movie.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3.base");

            //trackList = trackList.OrderBy(n => n).ToList();


            List<Tuple<string, string, double>> userAndTrackList = new List<Tuple<string, string, double>>();
            string track = null;
            string user = null;
            double ratings = 0;

            for (int i = 0; i < datasetUsersAndTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsersAndTracks[i].Replace("\"", ""), pattern);

                user = temp[0];
                track = temp[1];
                ratings = Convert.ToInt16(temp[2]);
                userAndTrackList.Add(new Tuple<string, string, double>(user, track, ratings));

            }
            datasetUsersAndTracks = null;



            Console.WriteLine("Done reading data, saving to file");
            string path = @"e:/projects/p9/dataset/movielens/u3_base_matrix.txt";
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

            string[] datasetUsers = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3_test_different_users.txt");
            string[] userList = new string[datasetUsers.Length];

            for (int i = 0; i < datasetUsers.Length; i++)
            {
                string[] temp = Regex.Split(datasetUsers[i], pattern);
                userList[i] = temp[0].Replace("\"", "");
            }
            datasetUsers = null;

            string[] datasetTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3_test_different_movies.txt");
            List<string> trackList = new List<string>();

            for (int i = 0; i < datasetTracks.Length; i++)
            {
                string[] temp = Regex.Split(datasetTracks[i], pattern);
                trackList.Add(temp[0].Replace("\"", ""));
            }
            datasetTracks = null;

            string[] datasetUsersAndTracks = File.ReadAllLines(@"e:/projects/p9/dataset/movielens/u3.test");

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
            string path = @"e:/projects/p9/dataset/movielens/u3_test_matrix.txt";
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
