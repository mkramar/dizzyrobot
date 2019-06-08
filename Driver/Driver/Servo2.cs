using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Servo2
    {
        private int _zero;
        private bool _debug;
        private bool _on;

        private RecentBuffer _angleHistory;

        private bool _direction;
        private int _startAngle;
        private int _targetAngle;
        private int _maxTorque;
        private int _targetTime;
        private int _startTime;

        private float _m;
        private float _d;

        public Servo2(Motor motor, int zero, bool debug = false)
        {
            _angleHistory = new RecentBuffer(5);

            this.Motor = motor;
            _zero = zero;
            _debug = debug;
        }

        public Motor Motor { get; }
        public int Angle { get; private set; }
        public void Off()
        {
            _on = false;
        }

        public void SetTarget(bool direction, int targetAngle, int time, int maxTorque, float m, float d)
        {
            _direction = direction;
            _startAngle = this.Angle;
            _targetAngle = targetAngle;
            _maxTorque = maxTorque;
            _startTime = Environment.TickCount;
            _targetTime = _startTime + time;

            _m = m;
            _d = d;
        }

        public void Tick()
        {
            // track angle

            int a = this.Motor.Angle - _zero;
            if (a - this.Angle < -Circle.Limit / 2) a += Circle.Limit;
            if (a - this.Angle > Circle.Limit / 2) a -= Circle.Limit;
            this.Angle = a;

            _angleHistory.Add(this.Angle);

            if (!_on)
            {
                this.Motor.Torque = 0;
                return;
            }

            var f = _maxTorque;
            var m = _m;

            // target time and angle
            int now = Environment.TickCount;
            var t2 = _targetTime - now;
            var a2 = Circle.Distance2(_targetAngle, this.Angle);

            // calc actual current velocity

            var ago = _angleHistory.Get(2);
            var v = (float)(this.Angle - ago.Angle) / (now - ago.TickCount);

            // calc minimum and maximum acceptable velocity
            // that will allow us to finish the trajectory

            // maximum acceptable time until breaking
            var maxT1 = Quadratic.Solve(f / m * 3 / 2, -2 * t2 * f / m, t2 * t2 * f / m / 2);
            var t1 = Math.Max(maxT1[0], maxT1[1]);

            // mininum acceptable velocity until breaking
            var minV = (t2 - t1) * f / m;

            // maximum acceptable velocity
            var maxV = t2 * f / m;

            // optimal velocity
            var optV = (minV + maxV) / 2;


        }
    }
}
