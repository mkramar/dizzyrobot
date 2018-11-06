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
        const double SwitchFreq = 300*1000; // 250kHz in example
        const double Ripple = 0.3;          // 0.2 to 0.4
        const double Vin_min = 9;
        const double Vin_startup = 9;
        const double Vin_typ = 15;          // input voltage
        const double Vin_max = 24;
        const double Vout = 40;
        const double Wout = 500;            // output power
        const double CurrentSenseMargin = 0.2;

        // low-side MOSFET
        const double Rdson_low = 0.005;         
        const double Traise_low = 25e-9;
        const double Tfall_low = 25e-9;

        // high-side MOSFET
        const double Rdson_high = 0.005;
        const double Traise_high = 24e-9;
        const double Tfall_high = 14e-9;
        const double Qrecov_high = 58e-9; // recovery charge

        const double Iin_typ = Wout / Vin_typ;
        const double Iin_max = Wout / Vin_startup;
        const double Iout = Wout / Vout;
        const double Rload = Vout / Iout;

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

            //8.2.2.4 Current Sense Resistor Rs

            var Rs = 0.075 / Ipeak / 1.2;
            Console.WriteLine("Current Sense Resistor, mOhm = " + Rs * 1000);

            // 8.2.2.6 Slope Compensation Resistor Rslope

            var Rslope = Lin * 6e9 / (1 * Vout - Vin_min) / Rs / 10;
            Rslope = Math.Max(Rslope, 8e9 / SwitchFreq);
            Console.WriteLine("Slope Compensation Resistor, kOhm = " + Rslope / 1000);

            // 8.2.2.7 Output Capacitor Cout

            var Cout = 200e-6;
            var Iripple = Iout / (2 * Vin_min / Vout);
            Console.WriteLine($"Output Capacitor hardcoded {Cout*1e6}uF");
            Console.WriteLine("Output Capacitor Ripple Current, A = " + Iripple);

            // 8.2.2.10 Bootstrap Capacitor Cbst

            Console.WriteLine("Boost Capacitor hardcoded 0.1uF");

            // 8.2.2.11 VCC Capacitor C

            Console.WriteLine("Vcc Capacitor hardcoded 1uF");

            // 8.2.2.12 Output Voltage Divider

            var Rfb1 = 1000.0;
            var Rfb2 = (Vout / 1.2 - 1) * Rfb1;
            Console.WriteLine("Output Voltage Divider, kOhm = " + Rfb1 + " / " + Rfb2);

            // 8.2.2.13 Soft-Start Capacitor Css

            var Css = 1e-6;
            var Tss = Css * 1.2 / 10e-6 * (1 - Vin_startup / Vout);
            Console.WriteLine("Soft-Start capacitor and time = " + Tss * 1000 + " msec @ " + Css * 1e6 + "uF");

            // 8.2.2.14 Restart Capacitor Cres

            var Cresmin = 30e-6 * Tss / 1.2;
            Console.WriteLine("Restart Capacitor min, uF = " + Cresmin * 1e6);

            // 8.2.2.15 Low-Side Power Switch QL

            Console.WriteLine();
            var Pcond = (1 - Vin_typ / Vout) * Math.Pow(Iout * Vout / Vin_typ, 2) * Rdson_low * 1.3;
            Console.WriteLine($"Low-side switch power resistive {Pcond}W @ {Rdson_low * 1000}mOhm");

            var Pswitch = 0.5 * Vout * Iin_typ * (Traise_low + Tfall_low) * SwitchFreq;
            Console.WriteLine($"Low-side switch power switching {Pswitch}W @ {Traise_low * 1e9}ns, {Tfall_low * 1e9}ns");

            //8.2.2.16 High-Side Power Switch QH

            Console.WriteLine();
            Pcond = Vin_typ / Vout * Math.Pow(Iout * Vout / Vin_typ, 2) * Rdson_low * 1.3;
            Console.WriteLine($"High-side switch power resistive {Pcond}W @ {Rdson_low * 1000}mOhm");

            var Pdead = Iin_typ * Iin_typ * Rdson_high * (Traise_high + Tfall_high) * 2 * SwitchFreq;
            Console.WriteLine($"High-side switch power dead-time {Pdead}W @ {Traise_high * 1e9}ns, {Tfall_high * 1e9}ns");

            var Precov = Vout * Qrecov_high * SwitchFreq;
            Console.WriteLine($"High-side switch power reverse recovery {Precov}W @ {Qrecov_high * 1e9}nc");

            // 8.2.2.20 Loop Compensation Components

            Console.WriteLine();
            var Fcross1 = Rload * Math.Pow(Vin_min / Vout, 2) / 4 / 2 / Math.PI / Lin;
            var Fcross2 = SwitchFreq / 10;
            var Fcross = Math.Min(Fcross1, Fcross2);
            Console.WriteLine($"Crossover Frequency = {Fcross / 1000} kHz ");

            var Rcomp = Fcross * Math.PI * Rs * Rfb2 * 10 * Cout * Vout / Vin_min;
            Console.WriteLine($"Compensation Resistor {Rcomp / 1000} kOhm ");

            var Ccomp = Rload * Cout / 4 / Rcomp;
            Console.WriteLine($"Compensation Capacitor {Ccomp*1e6} uF ");

            //

            Console.ReadLine();
        }
    }
}
