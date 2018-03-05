using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API.Models
{
    /// <summary>
    /// Clase que modela la respuesta a una solicitud al API
    /// </summary>
    public class Respuesta
    {
        public bool Estado { get; set; }
        public string Mensaje { get; set; }
        public string Descripcion { get; set; }
    }
}