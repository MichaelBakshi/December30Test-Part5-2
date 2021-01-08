using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace December30Part5_2
{
    class Actor
    {
        public long ID { get; set; }
        public string Name { get; set; }
        public DateTime Birthdate { get; set; }

        public Actor()
        {

        }

        public Actor(string name, DateTime birthdate)
        {
            Name = name;
            Birthdate = birthdate;
        }

        public override string ToString()
        {
            return $"Actor: ID: {ID}, Name: {Name}, Birth Date: {Birthdate.ToString("dd/MM/yyyy")}";
        }
    }
}
