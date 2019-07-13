using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Servos
    {
        public event EventHandler MotorsUpdated;

        private List<Servo> _servos;
        private Worker _worker;

        public Servo LeftFrontKnee { get; }
        public Servo LeftFrontShoulder { get; }
        public Servo LeftFrontBody { get; }

        public Servo RightFrontKnee { get; }
        public Servo RightFrontShoulder { get; }
        public Servo RightFrontBody { get; }

        public Servo LeftBackKnee { get; }
        public Servo LeftBackShoulder { get; }
        public Servo LeftBackBody { get; }

        public Servo RightBackKnee { get; }
        public Servo RightBackShoulder { get; }
        public Servo RightBackBody { get; }

        public Servos(Worker worker)
        {
            _worker = worker;
            _servos = new List<Servo>();

            var m = _worker.CurrentFrame.Motors;

            //

            this.LeftFrontKnee = new Servo(m[4], 21573);
            this.LeftFrontShoulder = new Servo(m[6], 28196, true);
            this.LeftFrontBody = new Servo(m[3], 18576);

            this.RightFrontKnee = new Servo(m[10], 27105);
            this.RightFrontShoulder = new Servo(m[7], 10254);
            this.RightFrontBody = new Servo(m[0], 9700);

            this.LeftBackKnee = new Servo(m[5], 26394);
            this.LeftBackShoulder = new Servo(m[9], 13000);
            this.LeftBackBody = new Servo(m[2], 7155);

            this.RightBackKnee = new Servo(m[11], 26218);
            this.RightBackShoulder = new Servo(m[8], 22396);
            this.RightBackBody = new Servo(m[1], 3988);

            //

            _servos.Add(LeftFrontKnee);
            _servos.Add(LeftFrontShoulder);
            _servos.Add(LeftFrontBody);

            _servos.Add(RightFrontKnee);
            _servos.Add(RightFrontShoulder);
            _servos.Add(RightFrontBody);

            _servos.Add(LeftBackKnee);
            _servos.Add(LeftBackShoulder);
            _servos.Add(LeftBackBody);

            _servos.Add(RightBackKnee);
            _servos.Add(RightBackShoulder);
            _servos.Add(RightBackBody);

            //

            _worker.FrameDone += (o, e) => UpdateMotors(e);
        }

        private void UpdateMotors(Frame frame)
        {
            foreach (var t in _servos)
                t.Tick();

            if (this.MotorsUpdated != null) MotorsUpdated(this, null);
        }
    }
}
