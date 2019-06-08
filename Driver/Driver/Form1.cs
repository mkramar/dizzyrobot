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
        private Servos _servos;

        private List<MotorRow> _table;

        public MainForm()
        {
            InitializeComponent();
            _frame = new Frame();
            _worker = new Worker(_frame);
            _servos = new Servos(_worker);

            CreateLabels();
        }

        private void CreateLabels()
        {
            _table = new List<MotorRow>();

            for (int i = 0; i < _frame.Motors.Length; i++)
            {
                var row = new MotorRow(this, _frame.Motors[i], i * 25 + 25, i + 1);
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
            this.InvokeIfRequired(() =>
            {
                for (int i = 0; i < frame.Motors.Length; i++)
                {
                    if (frame.Motors[i].Success) _table[i].Error.Text = "";
                    else _table[i].Error.Text = "error";

                    _table[i].Angle.Text = frame.Motors[i].Angle.ToString();
                }
            });
        }

        private void btnStand_Click(object sender, EventArgs e)
        {
            Stand1();
            //Stand2();
        }

        private void btnOff_Click(object sender, EventArgs e)
        {
            _servos.RightFrontKnee.Off();
            _servos.RightFrontBody.Off();
            _servos.RightFrontShoulder.Off();

            _servos.RightBackKnee.Off();
            _servos.RightBackBody.Off();
            _servos.RightBackShoulder.Off();

            _servos.LeftFrontKnee.Off();
            _servos.LeftFrontBody.Off();
            _servos.LeftFrontShoulder.Off();

            _servos.LeftBackKnee.Off();
            _servos.LeftBackBody.Off();
            _servos.LeftBackShoulder.Off();
        }

        private void btnLeftFrontUp_Click(object sender, EventArgs e)
        {
            //_servos.LeftFrontShoulder.SetTarget(true, Circle.Limit/4, 1000, 255, 0.06f, 0.003f, -1f);
            //_servos.LeftFrontShoulder.SetTarget(true, Circle.Limit / 4, 1000, 255, 0.06f, 0.002f, -4f);
            _servos.LeftFrontShoulder.SetTarget(true, Circle.Limit / 4, 1000, 255, 0.06f, 0.004f, -10f);
        }

        private void btnRightFrontUp_Click(object sender, EventArgs e)
        {
            _servos.RightFrontBody.SetTarget(false, Circle.Angle(-Circle.Limit / 2), 1000, 255, 0.08f, 0.008f, -8f); // aggressive
            //_servos.RightFrontBody.SetTarget(false, Circle.Angle(-Circle.Limit / 2), 1000, 255, 0.06f, 0.004f, -4f);
        }

        private void btnTest_Click(object sender, EventArgs e)
        {
            int speed = 3000;
            int kneeTorque = 150;
            int shoulderTorque = 255;

            float sp = 0.2f;
            float si = 0.02f;
            float sd = -2f;

            float kp = 0.01f;
            float ki = 0.002f;
            float kd = -0.4f;

            int a = 0;
            int knee = Circle.Limit * 4 / 10;
            int body = Circle.Limit * 4 / 5;

            // left front

            a = Circle.Angle(0 - knee);
            _servos.LeftFrontKnee.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = Circle.Angle(0 - body);
            _servos.LeftFrontBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.LeftFrontShoulder.SetTarget(true, a, 500, shoulderTorque, sp, si, sd);
        }

        //

        private void Stand1()
        {
            int speed = 3000;
            int kneeTorque = 100;
            int shoulderTorque = 155;

            //float sp = 0.06f;
            //float si = 0.001f;
            //float sd = 0f;

            float sp = 0.03f;
            float si = 0.01f;
            float sd = -3f;

            float kp = 0.06f;
            float ki = 0.002f;
            float kd = -1f;

            int a = 0;
            int knee = 0;// Circle.Limit * 1 / 10;
            int body = Circle.Limit * 1 / 10;

            // left front

            a = Circle.Angle(0 - knee);
            _servos.LeftFrontKnee.SetTarget(false, a, speed, 0, kp, ki, kd);

            a = Circle.Angle(0 - body);
            _servos.LeftFrontBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.LeftFrontShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // left back

            //a = Circle.Angle(0 - knee);
            //_servos.LeftBackKnee.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            //a = Circle.Angle(0 - body);
            //_servos.LeftBackBody.SetTarget(true, a, speed, kneeTorque, kp, ki, kd);

            //a = 0;
            //_servos.LeftBackShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // right front

            a = Circle.Angle(0 + knee);
            _servos.RightFrontKnee.SetTarget(true, a, speed, 0, kp, ki, kd);

            a = Circle.Angle(0 + body);
            _servos.RightFrontBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.RightFrontShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // right back

            //a = Circle.Angle(0 + knee);
            //_servos.RightBackKnee.SetTarget(true, a, speed, kneeTorque, kp, ki, kd);

            //a = Circle.Angle(0 + body);
            //_servos.RightBackBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            //a = 0;
            //_servos.RightBackShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);
        }
        private void Stand2()
        {
            int speed = 3000;
            int kneeTorque = 150;
            int shoulderTorque = 255;

            //float sp = 0.06f;
            //float si = 0.001f;
            //float sd = 0f;

            float sp = 0.3f;
            float si = 0.1f;
            float sd = 0f;

            float kp = 0.06f;
            float ki = 0.002f;
            float kd = -4f;

            int a = 0;
            int knee = Circle.Limit * 4 / 10;
            int body = Circle.Limit * 4 / 5;

            // left front

            a = Circle.Angle(0 - knee);
            _servos.LeftFrontKnee.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = Circle.Angle(0 - body);
            _servos.LeftFrontBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.LeftFrontShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // left back

            a = Circle.Angle(0 - knee);
            _servos.LeftBackKnee.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = Circle.Angle(0 - body);
            _servos.LeftBackBody.SetTarget(true, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.LeftBackShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // right front

            a = Circle.Angle(0 + knee);
            _servos.RightFrontKnee.SetTarget(true, a, speed, kneeTorque, kp, ki, kd);

            a = Circle.Angle(0 + body);
            _servos.RightFrontBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.RightFrontShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);

            // right back

            a = Circle.Angle(0 + knee);
            _servos.RightBackKnee.SetTarget(true, a, speed, kneeTorque, kp, ki, kd);

            a = Circle.Angle(0 + body);
            _servos.RightBackBody.SetTarget(false, a, speed, kneeTorque, kp, ki, kd);

            a = 0;
            _servos.RightBackShoulder.SetTarget(true, a, speed, shoulderTorque, sp, si, sd);
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
