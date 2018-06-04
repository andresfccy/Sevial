using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Deuda
{
    public class ConsultarEstadoProcDeuda : EntradaGeneral
    {
        public string FechaProceso { get; set; }
        public string CondicionProceso { get; set; }
    }
}