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
        private const string Url = "http://192.168.2.3/spibridge";
        private StringBuilder _commandBuilder = new StringBuilder();
        private HttpClient _client = new HttpClient();

        public async void Process(Frame frame)
        {
            while (true)
            {
                var command = FrameToCommand(frame);
                var content = new StringContent(command);
                content.Headers.ContentLength = command.Length;
                try
                {
                    using (var result = await _client.PostAsync(Url, content))
                    {
                        var body = await result.Content.ReadAsStringAsync();
                        ResponseToFrame(body, frame);
                    }
                }
                catch (WebException) { }
                catch (HttpRequestException) { }
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
                if (frame.Motors[i].Torque == null)
                {
                    // request angle
                    _commandBuilder.AppendFormat("{0:X2}a", i+ 1);
                }
                else
                {
                    _commandBuilder.AppendFormat("{0:X2}T", i + 1);

                    if (frame.Motors[i].Torque > 0) _commandBuilder.Append("+");
                    else _commandBuilder.Append("-");

                    _commandBuilder.AppendFormat("{0:X2}", frame.Motors[i].Torque);
                }
                _commandBuilder.AppendLine();
            }

            _commandBuilder.AppendLine("0Fa"); // todo: remove this

            return _commandBuilder.ToString();
        }
    }
}
