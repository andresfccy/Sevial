using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoSalida
{
    public class RespuestaEntidad<T> : Respuesta
    {
        public T Entidad { get; set; }
    }

}