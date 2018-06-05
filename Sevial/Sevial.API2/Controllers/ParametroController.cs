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
        public IHttpActionResult PostListaCategoria(DarListaCategoria oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP005_DarListaCategoria(oe.AliasUsuario, oe.NomCategoria, oe.Filtro, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP005_DarListaCategoria_Result> os = new RespuestaLista<SP005_DarListaCategoria_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/parametro/listarDepartamentales")]
        [ResponseType(typeof(RespuestaLista<SP030_ListarDepartamentales_Result>))]
        public IHttpActionResult PostListarDepartamentales(ListarDepartamentales oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP030_ListarDepartamentales(oe.AliasUsuario, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP030_ListarDepartamentales_Result> os = new RespuestaLista<SP030_ListarDepartamentales_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/parametro/listarMunDisponiblesDptal")]
        [ResponseType(typeof(RespuestaLista<SP031_ListarMunDisponiblesDptal_Result>))]
        public IHttpActionResult PostListarMunDisponiblesDptal(ListarMunDisponiblesDptal oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP031_ListarMunDisponiblesDptal(oe.AliasUsuario, oe.Departamental, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP031_ListarMunDisponiblesDptal_Result> os = new RespuestaLista<SP031_ListarMunDisponiblesDptal_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/parametro/listarMunicipiosDptal")]
        [ResponseType(typeof(RespuestaLista<SP032_ListarMunicipiosDptal_Result>))]
        public IHttpActionResult PostListarMunicipiosDptal(ListarMunDisponiblesDptal oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP032_ListarMunicipiosDptal(oe.AliasUsuario, oe.Departamental, codigoRpta, mensajeRpta);
            var dataSet = result.ToList();

            RespuestaLista<SP032_ListarMunicipiosDptal_Result> os = new RespuestaLista<SP032_ListarMunicipiosDptal_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return Ok(os);
        }

        [Route("api/parametro/editarDptal")]
        [ResponseType(typeof(Respuesta))]
        public IHttpActionResult PostEditarDptal(EditarDptal oe)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP033_EditarDptal(oe.AliasUsuario, oe.Departamental, oe.Nombre, oe.Divipola, oe.ListaMunicipios, codigoRpta, mensajeRpta);

            Respuesta os = new Respuesta();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();

            return Ok(os);
        }

    }
}
