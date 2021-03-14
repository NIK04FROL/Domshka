using System;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace DllFile
{
    public class Class1
    { 
        //ПУБЛИЧНЫЙ МЕТОД
        public static Dictionary<string, int> PublicFindWords(string[] text)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Regex Filter = new Regex("[A-Za-zА-Яа-я'ЁёЙйé-]+", RegexOptions.Compiled);
            Dictionary<string, int> Itog = new Dictionary<string, int>();
            object locker = new object();

            //ПОИСК УНИКАЛЬНЫХ СЛОВ
            Parallel.ForEach(text, line => //распараллеливание цикла
            {
                foreach (Match m in Filter.Matches(line))
                {
                    string word = m.Value;
                    word = word.ToLower();

                    lock (locker)
                    {
                        if (!Itog.ContainsKey(word))
                        {
                            Itog.Add(word, 1);
                        }

                        else
                        {
                                Itog.TryGetValue(word, out int value);
                                Itog[word] = value + 1;
                        }
                    }
                    
                }
            });

            //СОРТИРОВКА ПО УБЫВАНИЮ
            Itog = Itog.OrderByDescending(pair => pair.Value).ToDictionary(pair => pair.Key, pair => pair.Value);

            return Itog;
        }
    }
}
