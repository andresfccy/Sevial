using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API.Models.ObjetoSalida
{
    public class RespuestaLista<T> : Respuesta
    {
        public List<T> Lista { get; set; }
    }
}