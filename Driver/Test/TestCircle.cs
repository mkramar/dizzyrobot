using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Driver;

namespace Test
{
    [TestClass]
    public class TestCircle
    {
        [TestMethod]
        public void TestFraction()
        {
            var result = Circle.Fraction(20000, 5000, true, 0.1f);
            Assert.AreEqual(21776, result);

            result = Circle.Fraction(20000, 5000, true, 0.9f);
            Assert.AreEqual(3223, result);

            result = Circle.Fraction(5000, 10000, true, 0.1f);
            Assert.AreEqual(5500, result);

            result = Circle.Fraction(10000, 5000, true, 0.1f);
            Assert.AreEqual(12776, result);

            result = Circle.Fraction(10000, 5000, false, 0.1f);
            Assert.AreEqual(9500, result);

            result = Circle.Fraction(5000, 10000, false, 0.1f);
            Assert.AreEqual(2224, result);

            result = Circle.Fraction(5000, 10000, false, 0.2f);
            Assert.AreEqual(32215, result);
        }

        [TestMethod]
        public void TestDistance()
        {
            var result = Circle.Distance(32000, 10, true);
            Assert.AreEqual(778, result);

            result = Circle.Distance(32000, 10, false);
            Assert.AreEqual(-31990, result);

            result = Circle.Distance(1000, 30000, true);
            Assert.AreEqual(29000, result);

            result = Circle.Distance(1000, 30000, false);
            Assert.AreEqual(-3768, result);
        }

        [TestMethod]
        public void TestDistance2()
        {
            var result = Circle.Distance2(Circle.Limit - 1, 1);
            Assert.AreEqual(2, result);

            result = Circle.Distance2(Circle.Limit - 1, 1);
            Assert.AreEqual(-2, result);
        }
    }
}
