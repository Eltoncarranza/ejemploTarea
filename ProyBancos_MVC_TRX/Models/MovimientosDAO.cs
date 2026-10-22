using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

namespace ProyBancos_MVC_TRX.Models
{
    public class MovimientosDAO
    {
        // recuperar la cadena de conexión desde el web.config
        string cad_cnx =
            ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;

        public List<Movimientos> PA_MOVIMIENTOS_CUENTA(string num_cta)
        { 
            var lista = new List<Movimientos>();
            //
            using (SqlConnection cnx = new SqlConnection(cad_cnx))
            {
                cnx.Open();
                //
                using (SqlCommand cmd = new SqlCommand("PA_MOVIMIENTOS_CUENTA", cnx))
                { 
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@num_cta", num_cta);
                    //
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read()) {
                        lista.Add(
                            new Movimientos() 
                            {
                                num_mov = dr.GetInt32(0),
                                num_cta = dr.GetString(1),
                                fecha = dr.GetDateTime(2),
                                tip_mov = dr.GetString(3),
                                saldo_ant = dr.GetDecimal(4),
                                monto = dr.GetDecimal(5),
                                saldo_nue = dr.GetDecimal(6)
                            });
                    }
                    dr.Close();
                }
            }
            //
            return lista;
        }

        public void PA_REG_MOVIMIENTOS(string numero, string tipo, decimal monto)
        {
            using (SqlConnection cnx = new SqlConnection(cad_cnx))
            {
                cnx.Open();
                // Cereamos un objeto SqlTransaction asociada al SqlConnection
                SqlTransaction trx = cnx.BeginTransaction();
                //
                try
                {
                    using (SqlCommand cmd = 
                                new SqlCommand("PA_REG_MOVIMIENTOS", cnx, trx))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@num_cta", SqlDbType.Char, 12).Value = numero;
                        cmd.Parameters.Add("@tip_mov", SqlDbType.Char, 1).Value = tipo;
                        cmd.Parameters.Add("@monto", SqlDbType.Decimal).Value = monto;
                        //
                        cmd.ExecuteNonQuery();
                        // si hasta aquí no se ha producido ningún error, entonces
                        // confirmamos la transacción
                        trx.Commit();
                    }
                }
                catch (Exception ex)
                {
                    // si se produjera un error, entonces debemos cancelar la trasacción
                    trx.Rollback();
                    throw new Exception("Error: " + ex.Message);
                }
            }
        }

        public void PA_REG_MOVIMIENTOS2(Movimientos obj)
        {
            using (SqlConnection cnx = new SqlConnection(cad_cnx))
            {
                cnx.Open();
                //
                using (SqlCommand cmd = new SqlCommand("PA_REG_MOVIMIENTOS", cnx))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@num_cta", SqlDbType.Char, 12).Value = obj.num_cta;
                    cmd.Parameters.Add("@tip_mov", SqlDbType.Char, 1).Value = obj.tip_mov;
                    cmd.Parameters.Add("@monto", SqlDbType.Decimal).Value = obj.monto;
                    //
                    cmd.ExecuteNonQuery();
                }
            }
        }

        //***************** LISTAR CUENTAS *******************//
        public List<PA_LISTA_CUENTAS> PA_LISTA_CUENTAS()
        {
            var lista = new List<PA_LISTA_CUENTAS>();
            //
            using (SqlConnection cnx = new SqlConnection(cad_cnx))
            {
                cnx.Open();
                using (SqlCommand cmd = new SqlCommand("PA_LISTA_CUENTAS", cnx))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    //
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        lista.Add(
                            new PA_LISTA_CUENTAS() 
                            {
                                num_cta = dr.GetString(0),
                                cli_cta = dr.GetString(1)
                            });
                    }
                    dr.Close();
                }
            }
            //
            return lista;
        }


    } // final del class
} // final del namespace