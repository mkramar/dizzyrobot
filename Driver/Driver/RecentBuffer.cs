using System;
using System.Collections.Generic;

namespace Driver
{
    class RecentBuffer
    {
        public class Item
        {
            public int Angle;
            public int TickCount;
        }

        private List<Item> _buffer;
        private int _pos = 0;

        public RecentBuffer(int length)
        {
            _buffer = new List<Item>(length);

            for (int i = 0; i < length; i++)
            {
                _buffer.Add(new Item());
            }
        }

        public void Add(int angle)
        {
            _buffer[_pos].Angle = angle;
            _buffer[_pos].TickCount = Environment.TickCount;

            _pos++;
            _pos %= _buffer.Count;
        }

        public Item Get(int ago)
        {
            if (ago < 0) throw new ArgumentException();
            if (ago >= _buffer.Count) throw new ArgumentException();

            int p = _pos - ago;
            if (p < 0) p += _buffer.Count;

            return _buffer[p];
        }
    }
}
