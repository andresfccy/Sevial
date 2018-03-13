using Sevial.API2.Entity.Parametro;
using Sevial.API2.Models.ObjetoEntrada.Parametro;
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
    public class ParametroController : ApiController
    {
        private APPSEVIALEntities2 db = new APPSEVIALEntities2();

        [Route("api/parametro/darListaCategoria")]
        [ResponseType(typeof(RespuestaLista<SP005_DarListaCategoria_Result>))]
        public IHttpActionResult PostAutenticarUsuario(DarListaCategoria oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP005_DarListaCategoria(oe.AliasUsuario,oe.NomCategoria, oe.Filtro, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP005_DarListaCategoria_Result> os = new RespuestaLista<SP005_DarListaCategoria_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }
    }
}
