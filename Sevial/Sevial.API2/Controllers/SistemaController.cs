using Sevial.API2.Entity.Sistema;
using Sevial.API2.Models.ObjetoSalida;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;

namespace Sevial.API2.Controllers
{
    public class SistemaController : ApiController
    {
        private APPSEVIALEntities1 db = new APPSEVIALEntities1();

        [Route("api/sistema/probarConexion")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult GetProbarConexion()
        {

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP998_ProbarConexion(codigoRpta, mensajeRpta);
            //var dataSet = result.ToList();

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }
    }
}
