using System;
using System.Reflection;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using DllFile;

namespace ExeFile
{
    class Program
    {
        static void Main(string[] args)
        {
            string[] text = File.ReadAllLines("C:\\Users\\NickFrol\\Desktop\\War2.fb2", Encoding.GetEncoding(1251)); //СЧИТЫВАЕМ ФАЙЛ

            //ПРОНИКАЕМ В private МЕТОД
            Class1 c = new Class1();
            MethodInfo Method = c.GetType().GetMethod("FindWords", BindingFlags.NonPublic | BindingFlags.Instance);
            object Value = Method.Invoke(c, new object[] { text });
            var Itog = Value as Dictionary<string,int>;

            //ВЫВОД РЕЗУЛЬТАТА В ФАЙЛ
            File.WriteAllLines("result_new.txt", Itog.Select(kvp => string.Format("{0,-20} {1,5:}", kvp.Key, kvp.Value)));
            Console.WriteLine("Готово");
            Console.ReadLine();
        }
    }
}
