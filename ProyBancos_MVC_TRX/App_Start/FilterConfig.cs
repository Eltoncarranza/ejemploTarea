using System.Web;
using System.Web.Mvc;

namespace ProyBancos_MVC_TRX
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
