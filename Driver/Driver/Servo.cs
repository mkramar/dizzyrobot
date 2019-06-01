using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Servo
    {
        class MotorTarget
        {
            private bool _direction;
            private int _startAngle;
            private int _targetAngle;
            private int _power;
            private int _integral;
            private int _derivative;
            private int _targetTime;
            private int _startTime;
            private int _integralError;

            public MotorTarget(Motor motor)
            {
                this.Motor = motor;
            }

            public Motor Motor { get; }

            public void SetTarget(bool direction, int targetAngle, int time, int p, int i, int d)
            {
                _direction = direction;
                _startAngle = this.Motor.Angle;
                _targetAngle = targetAngle;
                _power = p;
                _integral = i;
                _derivative = d;
                _startTime = Environment.TickCount;
                _targetTime = _startTime + time;
                _integralError = 0;
            }

            public void Tick()
            {
                int now = Environment.TickCount;
                float fraction = (float)(now - _startTime) / (_targetTime - _startTime);
                var desiredAngle = Circle.Fraction(_startTime, _targetAngle, _direction, fraction);
                var error = Circle.Distance(this.Motor.Angle, desiredAngle, _direction);
                _integralError += error;

                var torque = error * _power + _integralError * _integral;
                if (torque < -255) torque = -255;
                if (torque > 255) torque = 255;

                this.Motor.Torque = torque;
            }
        }

        private List<MotorTarget> _targets;
        private Worker _worker;

        public Servo(Worker worker)
        {
            _worker = worker;
            _targets = new List<MotorTarget>();

            foreach (var motor in _worker.CurrentFrame.Motors)
            {
                var mt = new MotorTarget(motor);
                _targets.Add(mt);
            }

            _worker.FrameDone += (o, e) => UpdateMotors(e);
       }

        private void UpdateMotors(Frame frame)
        {
            foreach (var t in _targets)
                t.Tick();
        }
    }
}
