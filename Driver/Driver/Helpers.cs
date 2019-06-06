using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Driver
{
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

    static class MathExt
    {
        public static int Min(params int[] values)
        {
            return values.Min();
        }
    }
}
