using Sevial.API2.Entity.Deuda;
using Sevial.API2.Models.ObjetoEntrada.Deuda;
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
    public class DeudaController : ApiController
    {
        private APPSEVIALDeuda db = new APPSEVIALDeuda();

        [Route("api/deuda/darFechasControl")]
        [System.Web.Http.Description.ResponseType(typeof(RespuestaLista<SP022_DarFechasControl_Result>))]
        public IHttpActionResult PostDarFechasControl(DarFechasControl oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP022_DarFechasControl(oe.AliasUsuario, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP022_DarFechasControl_Result> os = new RespuestaLista<SP022_DarFechasControl_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }

        [Route("api/deuda/enviarProcesoDeuda")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEnviarProcesoDeuda(EnviarProcesoDeuda oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));


            var result = db.SP023_EnviarProcesoDeuda(oe.AliasUsuario, oe.FechaProceso, oe.CondicionProceso, codigoRpta, mensajeRpta);

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }

        [Route("api/deuda/consultarEstadoProcDeuda")]
        [System.Web.Http.Description.ResponseType(typeof(RespuestaLista<SP024_ConsultarEstadoProcDeuda_Result>))]
        public IHttpActionResult PostConsultarEstadoProcDeuda(ConsultarEstadoProcDeuda oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP024_ConsultarEstadoProcDeuda(oe.AliasUsuario, oe.FechaProceso, oe.CondicionProceso,codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP024_ConsultarEstadoProcDeuda_Result> os = new RespuestaLista<SP024_ConsultarEstadoProcDeuda_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }

        [Route("api/deuda/listarEntregaCartera")]
        [System.Web.Http.Description.ResponseType(typeof(RespuestaLista<SP024_ConsultarEstadoProcDeuda_Result>))]
        public IHttpActionResult PostListarEntregaCartera(ListarEntregaCartera oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP025_ListarEntregaCartera(oe.AliasUsuario, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP025_ListarEntregaCartera_Result> os = new RespuestaLista<SP025_ListarEntregaCartera_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }

        [Route("api/deuda/editarEntregaCartera")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEditarEntregaCartera(EditarEntregaCartera oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));


            var result = db.SP026_EditarEntregaCartera(oe.AliasUsuario, oe.IdRegistro, oe.FechaInicial, oe.FechaFinal, codigoRpta, mensajeRpta);

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }

        [Route("api/deuda/borrarEntregaCartera")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostBorrarEntregaCartera(BorrarEntregaCartera oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));


            var result = db.SP027_BorrarEntregaCartera(oe.AliasUsuario, oe.IdRegistro, codigoRpta, mensajeRpta);

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }

        [Route("api/deuda/listarDetalleEntregaCartera")]
        [System.Web.Http.Description.ResponseType(typeof(RespuestaLista<SP028_ListarDetalleEntregaCartera_Result>))]
        public IHttpActionResult PostListarDetalleEntregaCartera(ListarDetalleentregaCartera oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP028_ListarDetalleEntregaCartera(oe.AliasUsuario, oe.IdRegistro, oe.Filtro, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP028_ListarDetalleEntregaCartera_Result> os = new RespuestaLista<SP028_ListarDetalleEntregaCartera_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);


        }


        [Route("api/deuda/editarDetalleEntregaCartera")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEditarDetalleEntregaCartera(EditarDetalleEntregaCartera oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));


            var result = db.SP029_EditarDetalleEntregaCartera(oe.AliasUsuario, oe.IdRegistro, oe.FechaInicial, oe.FechaFinal, oe.EstadoMunicipio, oe.Observacion, codigoRpta, mensajeRpta);

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);


        }
    }
}
