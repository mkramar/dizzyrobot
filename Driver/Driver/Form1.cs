using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Driver
{
    public partial class MainForm : Form
    {
        private Worker _worker;

        public MainForm()
        {
            InitializeComponent();
            _worker = new Worker();
        }

        private void MainForm_Load(object sender, EventArgs args)
        {
            _worker.FrameDone += (o, e) => OnFrameDone();
            _worker.Run();
        }

        private void OnFrameDone()
        {
            this.InvokeIfRequired(() => {
                var frame = _worker.CurrentFrame;

                if (frame.Motors[0].Success) this.lbl1.Text = frame.Motors[0].Angle.ToString();
                else this.lbl1.Text = "error";

                if (frame.Motors[1].Success) this.lbl2.Text = frame.Motors[1].Angle.ToString();
                else this.lbl2.Text = "error";

                if (frame.Motors[2].Success) this.lbl3.Text = frame.Motors[2].Angle.ToString();
                else this.lbl3.Text = "error";

                if (frame.Motors[3].Success) this.lbl4.Text = frame.Motors[3].Angle.ToString();
                else this.lbl4.Text = "error";

                if (frame.Motors[4].Success) this.lbl5.Text = frame.Motors[4].Angle.ToString();
                else this.lbl5.Text = "error";

                if (frame.Motors[5].Success) this.lbl6.Text = frame.Motors[5].Angle.ToString();
                else this.lbl6.Text = "error";

                if (frame.Motors[6].Success) this.lbl7.Text = frame.Motors[6].Angle.ToString();
                else this.lbl7.Text = "error";

                if (frame.Motors[7].Success) this.lbl8.Text = frame.Motors[7].Angle.ToString();
                else this.lbl8.Text = "error";

                if (frame.Motors[8].Success) this.lbl9.Text = frame.Motors[8].Angle.ToString();
                else this.lbl9.Text = "error";

                if (frame.Motors[9].Success) this.lbl10.Text = frame.Motors[9].Angle.ToString();
                else this.lbl10.Text = "error";

                if (frame.Motors[10].Success) this.lbl11.Text = frame.Motors[10].Angle.ToString();
                else this.lbl11.Text = "error";

                if (frame.Motors[11].Success) this.lbl12.Text = frame.Motors[11].Angle.ToString();
                else this.lbl12.Text = "error";
            });
        }
    }

    static class InvokeHelper
    {
        public static void InvokeIfRequired(this Control control, MethodInvoker action)
        {
            if (control.InvokeRequired)
            {
                control.Invoke(action);
            }
            else
            {
                action();
            }
        }
    }
}
