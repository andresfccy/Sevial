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

        [Route("api/seguridad/darModuloUsuario")]
        [ResponseType(typeof(RespuestaLista<SP002_DarModuloUsuario_Result>))]
        public IHttpActionResult PostDarModuloUSuario(DarModuloUsuario oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP002_DarModuloUsuario(oe.AliasUsuario, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP002_DarModuloUsuario_Result> os = new RespuestaLista<SP002_DarModuloUsuario_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/seguridad/darOpcionModuloUsuario")]
        [ResponseType(typeof(RespuestaLista<SP003_DarOpcionModuloUsuario_Result>))]
        public IHttpActionResult PostDarOpcionModuloUsuario(DarOpcionModuloUsuario oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP003_DarOpcionModuloUsuario(oe.AliasUsuario, oe.IdModulo, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP003_DarOpcionModuloUsuario_Result> os = new RespuestaLista<SP003_DarOpcionModuloUsuario_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/seguridad/validarUrlIngreso")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostValidarUrlIngreso(ValidarUrlIngreso oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP004_ValidarUrlIngreso(oe.AliasUsuario, oe.Url, codigoRpta, mensajeRpta);
         
            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);
        }
    }
}
