using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Parametro
{
    public class DarListaCategoria : EntradaGeneral
    {
        public string NomCategoria { get; set; }
        public string Filtro { get; set; }
    }
}