using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoostCalc
{
    ///  http://www.ti.com/lit/ds/symlink/lm5121.pdf
    class Program
    {
        const double SwitchFreq = 400*1000; // 250kHz in example
        const double Ripple = 0.3;          // 0.2 to 0.4
        const double Vin_startup = 9;
        const double Vin_typ = 15;          // input voltage
        const double Vin_max = 24;
        const double Vout = 40;
        const double Wout = 500;            // output power

        const double Iin_typ = Wout / Vin_typ;
        const double Iin_max = Wout / Vin_startup;

        static void Main(string[] args)
        {
            // 8.2.2.1 Timing Resistor Rt

            var Rt = 9 * 1e9 / SwitchFreq;
            Console.WriteLine("Timing Resistor Rt, KOhm = " + Rt/1000);

            // 8.2.2.3 Input Inductor Lin

            var Lin = (Vin_typ / Iin_typ / Ripple) * (1 / SwitchFreq) * (1 - Vin_typ / Vout);
            Console.WriteLine("Input Inductor Lin, uH = " + Lin * 1000000);

            var Ipeak = Iin_max + 0.5 * (Vin_startup / Lin / SwitchFreq) * (1 - Vin_startup / Vout);
            Console.WriteLine("Inductor Saturation current, A = " + Ipeak);

            //

            Console.ReadLine();
        }
    }
}
