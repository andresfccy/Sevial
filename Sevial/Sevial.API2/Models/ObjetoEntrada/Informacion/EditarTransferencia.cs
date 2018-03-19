using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Informacion
{
    public class EditarTransferencia: EntradaGeneral
    {

        public int IdRegistro { get; set; }
        public int IdEstadoGestion { get; set; }
        public int IdMunicipio { get; set; }
        public decimal VlrPagado { get; set; }
        public int IdCuantia { get; set; }
        public decimal VlrTrf45 { get; set; }
        public decimal VlrTrf10 { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }
        public string Vigencia { get; set; }
        public string FechaTrf { get; set; }
        public string FechaCorte { get; set; }
        public int IdTipoTrf { get; set; }
        public string Observacion { get; set; }
        public int BancoCuenta { get; set; }
        public int IdAutoridadImposicion { get; set; }
  
    }
}