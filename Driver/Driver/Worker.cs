using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Driver
{
    class Worker
    {
        private Bridge _bridge = new Bridge();
        public readonly Frame CurrentFrame;

        public EventHandler<Frame> FrameDone;

        public Worker(Frame frame)
        {
            this.CurrentFrame = frame;
        }

        public void Run()
        {
            new Thread(WorkerThread).Start();
        }

        //

        private void WorkerThread()
        {
            while (true)
            {
                _bridge.Process(this.CurrentFrame);
                this.FrameDone?.Invoke(this, this.CurrentFrame);
            }
        }
    }
}
