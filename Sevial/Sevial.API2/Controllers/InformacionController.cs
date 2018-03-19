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


        [Route("api/informacion/eliminarTransferencia")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEliminarTransferencias(EliminarTransferencia oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP009_EliminarTransferencia(oe.AliasUsuario, oe.IdRegistro, codigoRpta, mensajeRpta);
            
            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
          
            return Ok(os);


        }

        [Route("api/informacion/editarTransferencia")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEditarTransferencias(EditarTransferencia oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));


            var result = db.SP010_EditarTransferencia(oe.AliasUsuario, oe.IdRegistro, oe.IdEstadoGestion, oe.IdMunicipio, oe.VlrPagado, oe.IdCuantia, oe.VlrTrf45, oe.VlrTrf10, oe.FechaInicio, oe.FechaFin, oe.Vigencia, oe.FechaTrf, oe.FechaCorte, oe.IdTipoTrf, oe.Observacion, oe.BancoCuenta, oe.IdAutoridadImposicion, codigoRpta, mensajeRpta);
            
            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }
    }
}
