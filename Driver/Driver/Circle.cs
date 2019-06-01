using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    public static class Circle
    {
        private const int Limit = 32 * 1024;

        public static int Fraction(int startAngle, int targetAngle, bool direction, float fraction)
        {
            if (startAngle < 0 || startAngle >= Limit) throw new ArgumentException();
            if (targetAngle < 0 || targetAngle >= Limit) throw new ArgumentException();

            if (direction && targetAngle < startAngle) targetAngle += Limit;
            if (!direction && targetAngle > startAngle) targetAngle -= Limit;

            int retval = startAngle + (int)((targetAngle - startAngle) * fraction);
            if (retval < 0) retval += Limit;
            if (retval > Limit) retval -= Limit;

            return retval;
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
    }
}
