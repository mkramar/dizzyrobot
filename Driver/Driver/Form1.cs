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
        private Frame _frame;
        private List<MotorRow> _table;

        public MainForm()
        {
            InitializeComponent();
            _frame = new Frame();
            _worker = new Worker(_frame);

            CreateLabels();
        }

        private void CreateLabels()
        {
            _table = new List<MotorRow>();

            for (int i = 0; i < _frame.Motors.Length; i++)
            {
                var row = new MotorRow(this, _frame.Motors[i], i * 25 + 25,i + 1);
                _table.Add(row);
            }
        }

        private void MainForm_Load(object sender, EventArgs args)
        {
            _worker.FrameDone += (o, e) => UpdateControls(e);
            _worker.Run();
        }

        private void UpdateControls(Frame frame)
        {
            this.InvokeIfRequired(() => {
                for (int i = 0; i < frame.Motors.Length; i++)
                {
                    if (frame.Motors[i].Success) _table[i].Error.Text = "";
                    else _table[i].Error.Text = "error";

                    _table[i].Angle.Text = frame.Motors[i].Angle.ToString();
                }
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

    class MotorRow
    {
        public MotorRow(Form parent, Motor motor, int top, int index)
        {
            this.Motor = motor;
            this.Id = new Label();
            this.Error = new Label();
            this.Angle = new Label();

            this.Id.Text = index.ToString();
            this.Id.Location = new Point(20, top);
            this.Id.Size = new Size(40, 20);
            this.Id.Font = new Font(this.Id.Font, FontStyle.Bold);

            this.Error.Location = new Point(60, top);
            this.Error.Size = new Size(40, 20);
            this.Error.ForeColor = Color.Red;

            this.Angle.Location = new Point(100, top);
            this.Angle.Size = new Size(150, 20);
            this.Angle.Font = new Font(this.Angle.Font, FontStyle.Bold);

            parent.Controls.Add(this.Id);
            parent.Controls.Add(this.Error);
            parent.Controls.Add(this.Angle);
        }

        public Motor Motor { get; set; }
        public Label Id { get; set; }
        public Label Error { get; set; }
        public Label Angle { get; set; }
    }
}
