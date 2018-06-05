using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Deuda
{
    public class EditarDetalleEntregaCartera : EntradaGeneral
    {
        public int IdRegistro { get; set; }
        public string FechaInicial { get; set; }
        public string FechaFinal { get; set; }
        public string EstadoMunicipio { get; set; }
        public string Observacion { get; set; }
    }
}
