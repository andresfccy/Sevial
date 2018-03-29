using Sevial.API2.Entity.CargueInformacion;
using Sevial.API2.Models.ObjetoEntrada.CargueInformacion;
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
    public class CargueInformacionController : ApiController
    {

        private APPSEVIALCargueInformacion db = new APPSEVIALCargueInformacion();

        [Route("api/cargueInformacion/darArchivosCargue")]
        [ResponseType(typeof(RespuestaLista<SP006_DarArchivosCargue_Result>))]
        public IHttpActionResult PostDarArchivosCargue(DarArchivosCargue oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP006_DarArchivosCargue(oe.AliasUsuario, oe.IdTipoCargue, oe.IdEstadoCargue, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP006_DarArchivosCargue_Result> os = new RespuestaLista<SP006_DarArchivosCargue_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }

        [Route("api/cargueInformacion/procesarArchivo")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostProcesarArchivo(ProcesarArchivo oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP007_ProcesarArchivo(oe.AliasUsuario, oe.ListaProcesar, codigoRpta, mensajeRpta);
         
            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            string[] listaTipoArchivo = oe.ListaProcesar.Split(';');
            foreach (string tipoArchivo in listaTipoArchivo)
            {
                string[] listaArchivo = tipoArchivo.Split(',');

                ObjectParameter codigoRptaArc = new ObjectParameter("CodigoRpta", typeof(Int32));
                ObjectParameter mensajeRptaArc = new ObjectParameter("MensajeRpta", typeof(String));

                var resultAr = db.SP013_IniciarProceso(oe.AliasUsuario,Convert.ToInt32(listaArchivo[0]), Convert.ToInt32(listaArchivo[1]), codigoRpta, mensajeRpta);

            }


            return Ok(os);


        }
    }
}
