using Sevial.API2.Entity.Informacion;
using Sevial.API2.Models.ObjetoEntrada.Informacion;
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
    public class InformacionController : ApiController
    {

        private APPSEVIALInformacion db = new APPSEVIALInformacion();

        [Route("api/informacion/darTransferencias")]
        [ResponseType(typeof(RespuestaLista<SP008_DarTransferencias_Result>))]
        public IHttpActionResult PostDarTransferencias(DarTransferencias oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP008_DarTransferencias(oe.AliasUsuario, oe.Filtro, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP008_DarTransferencias_Result> os = new RespuestaLista<SP008_DarTransferencias_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }
    }
}
