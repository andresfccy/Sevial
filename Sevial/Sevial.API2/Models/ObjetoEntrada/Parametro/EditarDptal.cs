using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sevial.API2.Models.ObjetoEntrada.Parametro
{
    public class EditarDptal : EntradaGeneral
    {
        public int Departamental { get; set; }
        public string Nombre { get; set; }
        public string Divipola { get; set; }
        public string ListaMunicipios{ get; set; }


    }
}