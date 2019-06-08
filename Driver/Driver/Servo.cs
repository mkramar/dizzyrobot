using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Servo
    {
        private int _zero;

        private RecentBuffer _recentBuffer;
        private Ema _ema;
        private bool _direction;
        private int _startAngle;
        private int _targetAngle;
        private int _maxTorque;
        private float _power;
        private float _integral;
        private float _derivative;
        private int _targetTime;
        private int _startTime;
        private float _integralTorque;
        private bool _on;
        private bool _debug;

        public Servo(Motor motor, int zero, bool debug = false)
        {
            _recentBuffer = new RecentBuffer(5);
            _ema = new Ema(10);

            this.Motor = motor;
            _zero = zero;
            _debug = debug;
        }

        public Motor Motor { get; }
        public int Angle { get; private set; }

        public void SetTarget(bool direction, int targetAngle, int time, int maxTorque, float p, float i, float d)
        {
            if (time <= 0) throw new ArgumentException();
            if (p < 0) throw new ArgumentException();
            if (i < 0) throw new ArgumentException();
            //if (d < 0) throw new ArgumentException();
            if (targetAngle < 0 || targetAngle >= Circle.Limit) throw new ArgumentException();
            if (maxTorque < 0 || maxTorque > 255) throw new ArgumentException();

            _direction = direction;
            _startAngle = this.Angle;
            _targetAngle = targetAngle;
            _maxTorque = maxTorque;
            _power = p;
            _integral = i;
            _derivative = d;
            _startTime = Environment.TickCount;
            _targetTime = _startTime + time;
            _integralTorque = 0;

            _on = true;
        }
        public void Off()
        {
            _on = false;
        }

        public void Tick()
        {
            // track angle

            int a = this.Motor.Angle - _zero;
            if (a - this.Angle < -Circle.Limit / 2) a += Circle.Limit;
            if (a - this.Angle > Circle.Limit / 2) a -= Circle.Limit;
            this.Angle = a;

            //

            _recentBuffer.Add(this.Angle);

            if (!_on)
            {
                this.Motor.Torque = 0;
                return;
            }

            int now = Environment.TickCount;
            float fraction = (float)(now - _startTime) / (_targetTime - _startTime);
            if (fraction < 0) fraction = 0;
            if (fraction > 1) fraction = 1;
            var desiredAngle = Circle.Fraction(_startAngle, _targetAngle/*, _direction*/, fraction);

            var error = Circle.Distance2(this.Angle, desiredAngle);
            //error = (int)_ema.Calc(error);

            // proportional

            var proportionalTorque = error * _power;

            // integral

            var maxError = (int)((_maxTorque - proportionalTorque) / _integral);
            _integralTorque += (/*Sqrt(error)*/ error * _integral);
            if (_integralTorque + proportionalTorque > _maxTorque) _integralTorque = _maxTorque - proportionalTorque;
            if (_integralTorque + proportionalTorque < -_maxTorque) _integralTorque = -_maxTorque + proportionalTorque;

            // derivative

            var ago = _recentBuffer.Get(3);
            var d = (float)(this.Angle - ago.Angle) / (now - ago.TickCount);
            var derivativeTorque = d * _derivative;

            _integralTorque += derivativeTorque;

            //

            if (_debug) Debug.WriteLine("a={0}, da={1} | P={2}, I={3}, D={4} | err={5}, int-err={6}", this.Angle, desiredAngle,  proportionalTorque, _integralTorque, derivativeTorque, error, _integralTorque);
            var torque = (int)(proportionalTorque + _integralTorque);

            if (torque < -_maxTorque) torque = -_maxTorque;
            if (torque > _maxTorque) torque = _maxTorque;

            this.Motor.Torque = torque;
        }
        private float Sqrt(float arg)
        {
            if (arg == 0) return 0;
            if (arg > 0) return (float)Math.Sqrt(arg);
            else return -(float)Math.Sqrt(-arg);
        }
    }
}
