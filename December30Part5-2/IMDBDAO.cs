using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace December30Part5_2
{
    class IMDBDAO
    {
        static string dbConnect = "Host=localhost;Username=postgres;Password=admin;Database=December30Part5db2";
        static int ExecuteNonQuery(string query)
        {
            int result = 0;

            using (NpgsqlCommand cmd = new NpgsqlCommand())
            {
                using (cmd.Connection = new NpgsqlConnection(dbConnect))
                {
                    cmd.Connection.Open();

                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = query;

                    result = cmd.ExecuteNonQuery();
                }
            }

            return result;
        }


        public static Movie GetMovieById(int id)
        {
            Movie result = null;

            using (NpgsqlCommand cmd = new NpgsqlCommand())
            {
                using (cmd.Connection = new NpgsqlConnection(dbConnect))
                {
                    cmd.Connection.Open();

                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = $"SELECT * FROM Movies WHERE ID={id}";

                    NpgsqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        result = new Movie
                        {
                            ID = (long)reader["id"],
                            Name = reader["name"].ToString(),
                            Release_date = (DateTime)reader["release_date"],
                            Genre_ID = (long)reader["genre_id"]
                        };
                    }

                }
            }

            return result;
        }

        public static List<Movie> GetAllMovies()
        {
            List<Movie> moviesList = new List<Movie>();

            using (NpgsqlCommand cmd = new NpgsqlCommand())
            {
                using (cmd.Connection = new NpgsqlConnection(dbConnect))
                {
                    cmd.Connection.Open();

                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "SELECT * FROM movies";

                    NpgsqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Movie v = new Movie
                        {
                            ID = (long)reader["id"],
                            Name = reader["name"].ToString(),
                            Release_date = (DateTime)reader["release_date"],
                            Genre_ID = (long)reader["genre_id"]

                        };
                        moviesList.Add(v);
                    }

                }
            }

            return moviesList;
        }


        public static void AddMovie(Movie m)
        {
            ExecuteNonQuery("INSERT INTO movies ( name, release_date, genre_id)" +
            $"VALUES( '{m.Name}', '{m.Release_date.ToString("yyyy-MM-dd")}', {m.Genre_ID});");

        }

        public static void UpdateMovie(Movie m, int id)
        {
            int result = ExecuteNonQuery(
                $"UPDATE movies SET " +
                $"Name='{m.Name}', Release_date='{m.Release_date.ToString("yyyy-MM-dd")}', Genre_ID={m.Genre_ID}" +
                $" WHERE ID ={id}");
        }

        public static int RemoveMovie(int id)
        {
            int result = ExecuteNonQuery($"DELETE  FROM movies WHERE ID={id}");
            return result;
        }


        public static List<Movie> GetMoviesWithActorBornBefore1972()
        {
            List<Movie> moviesList = new List<Movie>();

            using (NpgsqlCommand cmd = new NpgsqlCommand())
            {
                using (cmd.Connection = new NpgsqlConnection(dbConnect))
                {
                    cmd.Connection.Open();

                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = $"select m.id, m.name as movie_name, m.release_date,m.genre_id  from movies m " +
                                        "join movies_actors ma on m.id = ma.movie_id " +
                                        "join actors a on ma.actor_id = a.id " +
                                        "where a.birthdate < '1972-01-01'";

                    NpgsqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Movie v = new Movie
                        {
                            ID = (long)reader["id"],
                            Name = reader["movie_name"].ToString(),
                            Release_date = (DateTime)reader["release_date"],
                            Genre_ID = (long)reader["genre_id"]

                        };
                        moviesList.Add(v);
                    }

                }
            }

            return moviesList;
        }

        public static List<Actor> MoviesWithMostPopularActor()
        {
            List<Actor> actorsList = new List<Actor>();

            using (NpgsqlCommand cmd = new NpgsqlCommand())
            {
                using (cmd.Connection = new NpgsqlConnection(dbConnect))
                {
                    cmd.Connection.Open();

                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = $"select  count(m_a.actor_id), a.name as Actor_name from movies_actors m_a " +
                                        "join movies on m_a.movie_id = movies.id " +
                                        "join actors a on m_a.actor_id = a.id " +
                                        "group by a.name, m_a.actor_id " +
                                        "order by m_a.actor_id " +
                                        "limit 1";

                    NpgsqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Actor v = new Actor
                        {
                            //ID = (long)reader["id"],
                            Name = reader["Actor_name"].ToString(),
                            //Birthdate = (DateTime)reader["release_date"]

                        };
                        actorsList.Add(v);
                    }

                }
            }

            return actorsList;
        }


        //public static List<Store> GetStoresByCategoryAndFloor(int category_id, int floor)
        //{
        //    List<Store> storesList = new List<Store>();

        //    using (SqlCommand cmd = new SqlCommand())
        //    {
        //        using (cmd.Connection = new SqlConnection("Data Source =.; Initial Catalog = December30Part3; Integrated Security = True"))
        //        {
        //            cmd.Connection.Open();

        //            cmd.CommandType = System.Data.CommandType.Text;
        //            cmd.CommandText = $"select * from Stores where Category_ID={category_id} and Floor={floor}";

        //            SqlDataReader reader = cmd.ExecuteReader();

        //            while (reader.Read())
        //            {
        //                Store s = new Store
        //                {
        //                    ID = (int)reader["ID"],
        //                    Name = reader["Name"].ToString(),
        //                    Floor = (int)reader["Floor"],
        //                    Category_ID = (int)reader["Category_ID"]

        //                };
        //                storesList.Add(s);
        //            }

        //        }
        //    }

        //    return storesList;
        //}



        //public static List<Store> GetStoresByMostPopularCategory()
        //{
        //    List<Store> storesList = new List<Store>();

        //    using (SqlCommand cmd = new SqlCommand())
        //    {
        //        using (cmd.Connection = new SqlConnection("Data Source =.; Initial Catalog = December30Part3; Integrated Security = True"))
        //        {
        //            cmd.Connection.Open();

        //            cmd.CommandType = System.Data.CommandType.Text;
        //            cmd.CommandText = $"select * FROM" +
        //                               $" (select top 1  count (s.Category_ID) as Total, s.Category_ID  FROM Stores s" +
        //                                $"group by  s.Category_ID" +
        //                                $"order by  Total desc) c1" +
        //                                $"join Categories on c1.Category_ID = Categories.ID";


        //            SqlDataReader reader = cmd.ExecuteReader();

        //            while (reader.Read())
        //            {
        //                Store s = new Store
        //                {
        //                    ID = (int)reader["ID"],
        //                    Name = reader["Name"].ToString(),
        //                    Floor = (int)reader["Floor"],
        //                    Category_ID = (int)reader["Category_ID"]

        //                };
        //                storesList.Add(s);
        //            }

        //        }
        //    }

        //    return storesList;
        //}
    }
}
