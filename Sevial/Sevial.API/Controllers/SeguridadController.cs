using Sevial.API.Entity;
using Sevial.API.Models.ObjetoEntrada.Seguridad;
using Sevial.API.Models.ObjetoSalida;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;

namespace Sevial.API.Controllers
{
    public class SeguridadController : ApiController
    {
        private APPSEVIALEntities db = new APPSEVIALEntities();

        // POST: api/Seguridad/AutenticarUsuario
        [Route("api/Seguridad/AutenticarUsuario")]
        [ResponseType(typeof(RespuestaLista<SEG_TB001_Usuario>))]
        public IHttpActionResult PostAutenticarUsuario(OE_AutenticarUsuario oe)
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