using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Driver
{
    class Bridge
    {
        private const string Url = "http://192.168.2.2/spibridge";
        private StringBuilder _commandBuilder = new StringBuilder();
        private HttpClient _client = new HttpClient();

        public void Process(Frame frame)
        {
            var command = FrameToCommand(frame);

            var request = (HttpWebRequest)WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentLength = command.Length;

            using (var stream = request.GetRequestStream())
            {
                using (var writer = new StreamWriter(stream))
                    writer.Write(command);
            }

            using (var response = request.GetResponse())
            {
                using (var stream = response.GetResponseStream())
                {
                    using (var reader = new StreamReader(stream))
                    {
                        var body = reader.ReadToEnd();
                        ResponseToFrame(body, frame);
                    }
                }
            }
        }

        private void ResponseToFrame(string response, Frame frame)
        {
            foreach (var motor in frame.Motors)
                motor.Success = false;

            using (var reader = new StringReader(response))
            {
                while (true)
                {
                    var line = reader.ReadLine();
                    if (line == null) break;

                    if (line.Length == 8 && line.StartsWith("000"))
                    {
                        string idStr = line.Substring(0, 4);
                        if (Int32.TryParse(idStr, NumberStyles.HexNumber, null, out var id) && id >= 1 && id <= 12)
                        {
                            string angleStr = line.Substring(4);

                            if (Int32.TryParse(angleStr, NumberStyles.HexNumber, null, out var angle))
                            {
                                frame.Motors[id - 1].Angle = angle;
                                frame.Motors[id - 1].Success = true;
                            }
                        }
                    }
                }
            }
        }
        private string FrameToCommand(Frame frame)
        {
            _commandBuilder.Clear();

            _commandBuilder.AppendLine("0Fa"); // todo: remove this

            for (int i = 0; i < 12; i++)
            {
                var t = frame.Motors[i].Torque;

                if (t == null)
                {
                    // request angle
                    _commandBuilder.AppendFormat("{0:X2}a", i + 1);
                }
                else
                {
                    _commandBuilder.AppendFormat("{0:X2}T", i + 1);

                    if (t > 0) _commandBuilder.Append("+");
                    else _commandBuilder.Append("-");

                    _commandBuilder.AppendFormat("{0:X2}a", t > 0 ? t : -t);
                }
                _commandBuilder.AppendLine();
            }

            _commandBuilder.AppendLine("0Fa"); // todo: remove this

            return _commandBuilder.ToString();
        }
    }
}
