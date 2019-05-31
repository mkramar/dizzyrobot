using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Frame
    {
        public class Motor
        {
            public int? Torque;
            public int Angle;
            public bool Success;

            public override string ToString()
            {
                return $"T={Torque} A={Angle} {Success}";
            }
        }

        public Frame()
        {
            this.Motors = new Motor[12];

            for (int i = 0; i < this.Motors.Length; i++)
            {
                this.Motors[i] = new Motor();
            }
        }

        public Motor[] Motors;
    }
}
