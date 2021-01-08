using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace December30Part5_2
{
    class Movie
    {
        public long ID { get; set; }
        public string Name { get; set; }
        public DateTime Release_date { get; set; }
        public long Genre_ID { get; set; }

        public Movie()
        {

        }

        public Movie (string name, DateTime dateTime, Int64 genre_id)
        {
            Name = name;
            Release_date = dateTime;
            Genre_ID = genre_id;
        }

        public override string ToString()
        {
            return $"Movie: ID: {ID}, Name: {Name}, Date: {Release_date.ToString("dd/MM/yyyy")}, Genre ID: {Genre_ID}";
        }
    }
}
