using Sevial.API2.Entity.Seguridad;
using Sevial.API2.Models.ObjetoEntrada.Seguridad;
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
    public class SeguridadController : ApiController
    {
        private APPSEVIALEntities db = new APPSEVIALEntities();


        [Route("api/seguridad/autenticarUsuario")]
        [ResponseType(typeof(RespuestaLista<SP001_AutenticarUsuario_Result>))]
        public IHttpActionResult PostAutenticarUsuario(AutenticarUsuario oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP001_AutenticarUsuario(oe.AliasUsuario, oe.Clave, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP001_AutenticarUsuario_Result> os = new RespuestaLista<SP001_AutenticarUsuario_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }
    }
}
