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
        private bool _on;
        private bool _debug;

        public Servo(Motor motor, int zero, bool debug = false)
        {
            _recentBuffer = new RecentBuffer(5);
            this.Motor = motor;
            _zero = zero;
            _debug = debug;
        }

        public Motor Motor { get; }
        public int Angle => Circle.Angle(this.Motor.Angle - _zero);

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
            _integralError = 0;

            _on = true;
        }
        public void Off()
        {
            _on = false;
        }

        public void Tick()
        {
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
            var desiredAngle = Circle.Fraction(_startAngle, _targetAngle, _direction, fraction);

            var error = Circle.Distance2(this.Angle, desiredAngle);

            // proportional

            var proportionalTorque = error * _power;

            // integral

            var maxError = (int)((_maxTorque - proportionalTorque) / _integral);
            _integralError += error;
            if (_integralError > maxError) _integralError = maxError;
            if (_integralError < -maxError) _integralError = -maxError;
            var integralTorque = _integralError * _integral;

            // derivative

            var ago = _recentBuffer.Get(2);
            var d = (float)(this.Angle - ago.Angle) / (now - ago.TickCount);
            var derivativeTorque = d * _derivative;

            //

            if (_debug) Debug.WriteLine("prop={0}, int={1}, der={2} | err={3}, int-err={4}", proportionalTorque, integralTorque, derivativeTorque, error, _integralError);
            var torque = (int)(proportionalTorque + integralTorque + derivativeTorque);

            if (torque < -_maxTorque) torque = -_maxTorque;
            if (torque > _maxTorque) torque = _maxTorque;

            this.Motor.Torque = torque;
        }
    }
}
