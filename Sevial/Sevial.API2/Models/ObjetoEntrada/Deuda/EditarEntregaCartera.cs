using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Deuda
{
    public class EditarEntregaCartera : EntradaGeneral
    {
        public int  IdRegistro { get; set; }
        public string FechaInicial { get; set; }
        public string FechaFinal { get; set; }
    }
}