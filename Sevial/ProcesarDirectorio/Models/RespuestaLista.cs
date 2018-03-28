using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProcesarDirectorio.Models.ObjetoSalida
{
    public class RespuestaLista<T> : Respuesta
    {
        public List<T> Lista { get; set; }
    }
}