using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using DllFile;
using System.Diagnostics;

namespace ExeFile
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] text = File.ReadAllLines("C:\\Users\\NickFrol\\Desktop\\War.fb2", Encoding.GetEncoding(1251));
            Console.OutputEncoding = Encoding.UTF8;

            //ВЫЗОВ ПУБЛИЧНОГО МЕТОДА
            var sw = Stopwatch.StartNew();
            var Itog2 = Class1.PublicFindWords(text) as Dictionary<string, int>;
            File.WriteAllLines("Public_result.txt", Itog2.Select(kvp => string.Format("{0,-20} {1,5:}", kvp.Key, kvp.Value)));
            Console.WriteLine("Время выполнения публичного метода = {0} seconds\n", sw.Elapsed.TotalSeconds);


            //ВЫЗОВ ПРИВАТНОГО МЕТОДА
            sw = Stopwatch.StartNew();
            Class1 c = new Class1();
            MethodInfo Method = c.GetType().GetMethod("PrivateFindWords", BindingFlags.NonPublic | BindingFlags.Instance);
            object Value = Method.Invoke(c, new object[] { text });
            var Itog = Value as Dictionary<string,int>;
            File.WriteAllLines("Privat_result.txt", Itog.Select(kvp => string.Format("{0,-20} {1,5:}", kvp.Key, kvp.Value)));
            Console.WriteLine("Время выполнения приватного метода = {0} seconds\n", sw.Elapsed.TotalSeconds);

            Console.WriteLine("Готово");
            Console.ReadLine();
        }
    }
}
