using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Quadratic
    {
        public static float[] Coeff(float[]x, float[]y)
        {
            var x1 = x[0];
            var x2 = x[1];
            var x3 = x[2];
            var y1 = y[0];
            var y2 = y[1];
            var y3 = y[2];

            var a = y1 / ((x1 - x2) * (x1 - x3)) + y2 / ((x2 - x1) * (x2 - x3)) + y3 / ((x3 - x1) * (x3 - x2));

            var b = (-y1 * (x2 + x3) / ((x1 - x2) * (x1 - x3))
                    - y2 * (x1 + x3) / ((x2 - x1) * (x2 - x3))
                    - y3 * (x1 + x2) / ((x3 - x1) * (x3 - x2)));

            var c = (y1 * x2 * x3 / ((x1 - x2) * (x1 - x3))
                + y2 * x1 * x3 / ((x2 - x1) * (x2 - x3))
                + y3 * x1 * x2 / ((x3 - x1) * (x3 - x2)));

            return new float[] { a, b, c };
        }
        public static float[] Solve(float a, float b, float c)
        {
            var d = Math.Sqrt(b * b - 4 * a * c);

            return new float[] {
                (float)((-b - d) / (4 * a * c)),
                (float)((-b + d) / (4 * a * c))
            };
        }
    }
}
