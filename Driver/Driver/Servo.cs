using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Servo
    {
        private int _zero;

        private bool _direction;
        private int _startAngle;
        private int _targetAngle;
        private int _maxTorque;
        private float _power;
        private float _integral;
        private float _derivative;
        private int _targetTime;
        private int _startTime;
        private int _integralError;
        private int _maxIntegralError;

        public Servo(Motor motor, int zero)
        {
            this.Motor = motor;
            _zero = zero;
        }

        public Motor Motor { get; }
        public int Angle => Circle.Angle(this.Motor.Angle - _zero);

        public void SetTarget(bool direction, int targetAngle, int time, int maxTorque, float p, float i, float d)
        {
            if (time <= 0) throw new ArgumentException();
            if (p < 0) throw new ArgumentException();
            if (i < 0) throw new ArgumentException();
            if (d < 0) throw new ArgumentException();
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
            _integralError = 0;
            _maxIntegralError = (int)(maxTorque / i);
        }

        public void Tick()
        {
            if (_startTime == 0) return;

            int now = Environment.TickCount;
            float fraction = (float)(now - _startTime) / (_targetTime - _startTime);
            if (fraction < 0) fraction = 0;
            if (fraction > 1) fraction = 1;
            var desiredAngle = Circle.Fraction(_startAngle, _targetAngle, _direction, fraction);

            var error = Circle.Distance2(this.Angle, desiredAngle);
            //var d1 = Circle.Distance(_startAngle, this.Angle, _direction);
            //var d2 = Circle.Distance(_startAngle, _targetAngle, _direction);

            //if (d1 > d2)
            //    error *= -1;

            _integralError += error;
            if (_integralError > _maxIntegralError) _integralError = _maxIntegralError;
            if (_integralError < -_maxIntegralError) _integralError = -_maxIntegralError;

            var torque = (int)(error * _power + _integralError * _integral);
            if (torque < -100) torque = -100;
            if (torque > 100) torque = 100;

            this.Motor.Torque = torque;
        }
    }
}
