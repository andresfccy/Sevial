using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Deuda
{
    public class ListarDetalleentregaCartera : EntradaGeneral
    {
        public int IdRegistro { get; set; }
        public string Filtro { get; set; }
    }
}