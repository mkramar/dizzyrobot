using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Logger : IDisposable
    {
        private Servos _servos;
        private Stream _fileStream;
        private StreamWriter _writer;

        public Logger(Servos servos)
        {
            _servos = servos;
            _servos.MotorsUpdated += Log;

            if (!Directory.Exists("Logs")) Directory.CreateDirectory("Logs");

            var now = DateTime.Now;
            _fileStream = File.Open($"Logs/{now:yyyy-MM-dd_HH.mm}.txt", FileMode.Create, FileAccess.Write, FileShare.Read);
            _writer = new StreamWriter(_fileStream);
        }

        private void Log(object sender, EventArgs e)
        {
            int now = Environment.TickCount;
            _writer.Write($"{now}\t");

            _writer.Write($"LFK: {_servos.LeftFrontKnee.Angle,6} {_servos.LeftFrontKnee.Torque,4}\t");
            _writer.Write($"LFS: {_servos.LeftFrontShoulder.Angle,6} {_servos.LeftFrontShoulder.Torque,4}\t");
            _writer.Write($"LFB: {_servos.LeftFrontBody.Angle,6} {_servos.LeftFrontBody.Torque,4}\t");

            _writer.Write($"RFK: {_servos.RightFrontKnee.Angle,6} {_servos.RightFrontKnee.Torque,4}\t");
            _writer.Write($"RFS: {_servos.RightFrontShoulder.Angle,6} {_servos.RightFrontShoulder.Torque,4}\t");
            _writer.Write($"RFB: {_servos.RightFrontBody.Angle,6} {_servos.RightFrontBody.Torque,4}\t");

            _writer.Write($"LBK: {_servos.LeftBackKnee.Angle,6} {_servos.LeftBackKnee.Torque,4}\t");
            _writer.Write($"LBS: {_servos.LeftBackShoulder.Angle,6} {_servos.LeftBackShoulder.Torque,4}\t");
            _writer.Write($"LBB: {_servos.LeftBackBody.Angle,6} {_servos.LeftBackBody.Torque,4}\t");

            _writer.Write($"RBK: {_servos.RightBackKnee.Angle,6} {_servos.RightBackKnee.Torque,4}\t");
            _writer.Write($"RBS: {_servos.RightBackShoulder.Angle,6} {_servos.RightBackShoulder.Torque,4}\t");
            _writer.Write($"RBB: {_servos.RightBackBody.Angle,6} {_servos.RightBackBody.Torque,4}\t");

            _writer.WriteLine();
            _writer.Flush();
            _fileStream.Flush();
        }

        public void Dispose()
        {
            if (_writer != null) _writer.Dispose();
            _writer = null;

            if (_fileStream != null) _fileStream.Dispose();
            _fileStream = null;
        }
    }
}
