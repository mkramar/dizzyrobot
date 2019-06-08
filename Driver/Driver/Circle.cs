using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    public static class Circle
    {
        public const int Limit = 32 * 1024;

        public static int Angle(int angle)
        {
            if (angle < 0) angle += Limit;
            if (angle >= Limit) angle -= Limit;

            return angle;
        }
        public static int Fraction(int startAngle, int targetAngle, bool direction, float fraction)
        {
            if (startAngle < 0 || startAngle >= Limit) throw new ArgumentException();
            if (targetAngle < 0 || targetAngle >= Limit) throw new ArgumentException();

            if (direction && targetAngle < startAngle) targetAngle += Limit;
            if (!direction && targetAngle > startAngle) targetAngle -= Limit;

            int retval = startAngle + (int)((targetAngle - startAngle) * fraction);

            return Angle(retval);
        }
        public static int Fraction(int startAngle, int targetAngle, float fraction)
        {
            var d = Distance2(startAngle, targetAngle);
            int retval = startAngle + (int)(d * fraction);
            return Angle(retval);
        }
        public static int Distance(int fromAngle, int toAngle, bool direction)
        {
            if (fromAngle < 0 || fromAngle >= Limit) throw new ArgumentException();
            if (toAngle < 0 || toAngle >= Limit) throw new ArgumentException();

            if (direction && toAngle < fromAngle) toAngle += Limit;
            if (!direction && toAngle > fromAngle) toAngle -= Limit;

            int retval = toAngle - fromAngle;
            //if (retval < 0) retval += Limit;
            if (retval > Limit) retval -= Limit;

            if (retval >= Limit) throw new Exception();

            return retval;
        }
        public static int Distance2(int fromAngle, int toAngle)
        {
            fromAngle = Angle(fromAngle);
            toAngle = Angle(toAngle);

            //if (fromAngle < 0 || fromAngle >= Limit) throw new ArgumentException();
            //if (toAngle < 0 || toAngle >= Limit) throw new ArgumentException();

            int retval = Limit;
            int retvalAbs = Limit;

            var tests = new List<Func<int>>
            {
                () => toAngle - fromAngle,
                () => toAngle - fromAngle + Limit,
                () => toAngle - fromAngle - Limit,
                //() => fromAngle - toAngle,
                //() => fromAngle - toAngle + Limit,
            };

            foreach (var test in tests)
            {
                int d = test();
                int dAbs = Math.Abs(d);

                if (retvalAbs > dAbs)
                {
                    retvalAbs = dAbs;
                    retval = d;
                }
            }

            return retval;
        }
    }
}
