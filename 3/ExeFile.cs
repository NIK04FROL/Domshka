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

            //ВЫЗОВ МЕТОДА ЧЕРЕЗ СЕРВИС
            var client = new MyService.Service1Client();
            var Itog3 = client.PublicFindWordsService(text);
            File.WriteAllLines("Public_result_service.txt", Itog3.Select(kvp => string.Format("{0,-20} {1,5:}", kvp.Key, kvp.Value)));

            Console.WriteLine("Готово");
            Console.ReadLine();
        }
    }
}
