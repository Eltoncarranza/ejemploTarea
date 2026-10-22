using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using ProyBancos_MVC_TRX.Models;

namespace ProyBancos_MVC_TRX.Controllers
{
    public class MovimientosController : Controller
    {
        // definimos una variable de MovimientosDAO para utilizar
        // sus métodos
        MovimientosDAO dao_movi = new MovimientosDAO();

        // GET: Movimientos
        public ActionResult ListarMovimientosCuenta(string num_cta="") // List
        {
            ViewBag.cuentas = new SelectList(
                dao_movi.PA_LISTA_CUENTAS(), "num_cta", "cli_cta");
            //
            var listado = dao_movi.PA_MOVIMIENTOS_CUENTA(num_cta);
            ViewBag.contador = listado.Count;
            ViewBag.num_cta = num_cta;
            //
            return View(listado);
        }


        // GET: Movimientos/Create
        public ActionResult RegistrarNuevoMovimiento(string num_cta="")
        {
            ViewBag.cuentas = new SelectList(
                dao_movi.PA_LISTA_CUENTAS(), "num_cta", "cli_cta"); //, num_cta);
            //
            ViewBag.num_cta = num_cta;
            //
            return View(new Movimientos());
        }

        // POST: Movimientos/Create
        [HttpPost]
        public ActionResult RegistrarNuevoMovimiento(Movimientos obj)
        {
            ViewBag.cuentas = new SelectList(
                dao_movi.PA_LISTA_CUENTAS(), "num_cta", "cli_cta");
            //
            try
            {
                if (ModelState.IsValid)
                {
                    dao_movi.PA_REG_MOVIMIENTOS(obj.num_cta, obj.tip_mov, obj.monto);
                    //
                    TempData["mensaje"] = 
                        $"Se registró correctamente el Movimiento Bancario de la cuenta: {obj.num_cta}";
                    //
                    return RedirectToAction("ListarMovimientosCuenta", 
                                             new { num_cta = obj.num_cta });
                }
            }
            catch(Exception ex)
            {
                ViewBag.mensaje = ex.Message;
            }
            return View(obj);
        }

        
    } // final del class
} // final del namespace
