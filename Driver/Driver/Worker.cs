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
        public readonly Frame CurrentFrame = new Frame();
        //public AutoResetEvent FrameDone = new AutoResetEvent(false);

        public EventHandler FrameDone;

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
                //this.FrameDone.Set();

                this.FrameDone?.Invoke(this, null);
            }
        }
    }
}
