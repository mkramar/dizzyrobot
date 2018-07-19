using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ComTest
{
    public partial class frmMain : Form
    {
        private const int Motors = 3;
        private const int ReadTimeout = 100;

        private SerialPort _port;

        private TextBox[] _texts;
        private Label[] _labels;
        private AutoResetEvent _startSequence = new AutoResetEvent(false);

        public frmMain()
        {
            InitializeComponent();

            string[] ports = SerialPort.GetPortNames();
            _port = new SerialPort("COM3", 115200);
            _port.ReadTimeout = ReadTimeout;
            _port.Open();

            _texts = new[] { txt1, txt2, txt3 };
            _labels = new[] { lbl1, lbl2, lbl3 };

            new Thread(WorkThread) { IsBackground = true }.Start();
        }

        private void MotorTransaction(int motor)
        {
            int torque = 0;
            int.TryParse(_texts[motor].Text, out torque);

            bool neg = (torque < 0);
            if (neg) torque = -torque;
            if (torque > 127) torque = 127;
            if (neg) torque |= 0x80;

            var command = string.Format("{0:X2}01{1:X2}\r\n", motor + 1, torque);
            var sendData = Encoding.ASCII.GetBytes(command);

            _port.Write(sendData, 0, sendData.Length);

            var state = new TransactionState(motor);
            var ar = ScheduleRead(state);

            if (!state.Done.WaitOne(ReadTimeout))
            {
                state.Canceled = true;
                this.PerformSafely(() => _labels[state.Motor].Text = "timeout");
            }
        }

        private IAsyncResult ScheduleRead(TransactionState state)
        {
            return _port.BaseStream.BeginRead(state.Buffer, state.Read, state.Buffer.Length - state.Read, HandleResponse, state);
        }
        private void HandleResponse(IAsyncResult ar)
        {
            try
            {
                var state = (TransactionState)ar.AsyncState;

                state.Read += _port.BaseStream.EndRead(ar);
                Log(state);

                if (state.Canceled) return;

                for (int i = 0; i < state.Read; i++)
                {
                    if (state.Buffer[i] == '\r' || state.Buffer[i] == '\n')
                    {
                        this.PerformSafely(() => _labels[state.Motor].Text = Encoding.ASCII.GetString(state.Buffer, 0, i));
                        state.Done.Set();

                        //if (state.Motor < Motors - 1)
                        //    MotorTransaction(state.Motor + 1);

                        return;
                    }
                }

                ScheduleRead(state);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void WorkThread()
        {
            while (true)
            {
                _startSequence.WaitOne();

                for (int i = 0; i < Motors; i++)
                {
                    MotorTransaction(i);
                }

                this.PerformSafely(() => btnSend.Enabled = true);
            }
        }
        private void Log(TransactionState state)
        {
            Debug.Write("log:");

            for (int i = 0; i < state.Read; i++)
                Debug.Write((char)state.Buffer[i]);

            Debug.WriteLine("");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            foreach (var label in _labels)
                label.Text = "";

            btnSend.Enabled = false;

            _startSequence.Set();
        }
    }

    class TransactionState
    {
        public TransactionState(int motor)
        {
            this.Motor = motor;
        }

        public int Motor { get; set; }
        public byte[] Buffer { get; set; } = new byte[50];
        public int Read { get; set; }
        public ManualResetEvent Done { get; set; } = new ManualResetEvent(false);
        public bool Canceled { get; set; }
    }
}
