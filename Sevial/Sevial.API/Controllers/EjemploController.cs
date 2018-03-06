using Sevial.API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sevial.API.Controllers
{
    public class EjemploController : ApiController
    {
        // GET /Ejemplo
        public RespuestaLista<string> Get()
        {
            string mensaje = "Mensaje de prueba (título de los mensajes)";
            string descripcion = "Descripción del mensaje (cuerpo de los mensajes)";
            bool estado = true;
            string[] lista = new string[] { "Esto puede ser...", "...una lista de cualquier tipo de objetos" };

            return new RespuestaLista<string>()
            {
                Mensaje = mensaje,
                Descripcion = descripcion,
                Estado = estado,
                Lista = lista.ToList()
            };
        }

        // GET /Ejemplo/5
        public RespuestaEntidad<string> Get(int id)
        {
            string mensaje = "Mensaje de prueba (título de los mensajes)";
            string descripcion = "Descripción del mensaje (cuerpo de los mensajes)";
            bool estado = true;


            return new RespuestaEntidad<string>()
            {
                Mensaje = mensaje,
                Descripcion = descripcion,
                Estado = estado,
                Entidad = "Esto puede contener todo tipo de datos, según se parametrice"
            };
        }

        // POST /Ejemplo
        public Respuesta Post([FromBody]string value)
        {
            string mensaje = "Mensaje de prueba (título de los mensajes)";
            string descripcion = "Descripción del mensaje (cuerpo de los mensajes)";
            bool estado = true;

            return new Respuesta()
            {
                Mensaje = mensaje,
                Descripcion = descripcion,
                Estado = estado
            };
        }

        // PUT /Ejemplo/5
        public Respuesta Put(int id, [FromBody]string value)
        {
            string mensaje = "Mensaje de prueba (título de los mensajes)";
            string descripcion = "Descripción del mensaje (cuerpo de los mensajes)";
            bool estado = true;

            return new Respuesta()
            {
                Mensaje = mensaje,
                Descripcion = descripcion,
                Estado = estado
            };
        }

        // DELETE /Ejemplo/5
        public Respuesta Delete(int id)
        {
            string mensaje = "Mensaje de prueba (título de los mensajes)";
            string descripcion = "Descripción del mensaje (cuerpo de los mensajes)";
            bool estado = true;

            return new Respuesta()
            {
                Mensaje = mensaje,
                Descripcion = descripcion,
                Estado = estado
            };
        }
    }
}