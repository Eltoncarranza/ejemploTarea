using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyBancos_MVC_TRX.Models
{
    public class Movimientos
    {
        public int num_mov { get; set; }
        public string num_cta { get; set; }
        public DateTime fecha { get; set; }
        public string tip_mov { get; set; }
        public decimal saldo_ant { get; set; }
        public decimal monto { get; set; }
        public decimal saldo_nue { get; set; }

        public Movimientos()
        {
            fecha = DateTime.Now;
        }
    }
}