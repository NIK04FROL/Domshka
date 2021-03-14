using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using DllFile;

namespace WcfService1
{
    public class Service1 : IService1
    {
        public Dictionary<string, int> PublicFindWordsService(string[] text)
        {
            var Itog = Class1.PublicFindWords(text) as Dictionary<string, int>;
            return Itog;
        }
    }
}
