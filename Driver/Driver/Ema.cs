using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Ema
    {
        private float _k;
        private float _prev;

        public Ema(int period)
        {
            _k = 2.0f / (period + 1);
        }

        public float Calc(float inp)
        {
            var retval = (inp - _prev) * _k + _prev; 
            _prev = retval;
            return retval;
        }
    }
}
