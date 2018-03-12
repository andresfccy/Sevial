using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using Sevial.API.Entity;

namespace Sevial.API.Controllers
{
    public class SEG_TB001_UsuarioController : ApiController
    {
        private APPSEVIALEntities db = new APPSEVIALEntities();

        // GET: api/SEG_TB001_Usuario
        public IQueryable<SEG_TB001_Usuario> GetSEG_TB001_Usuario()
        {
            return db.SEG_TB001_Usuario;
        }

        // GET: api/SEG_TB001_Usuario/5
        [ResponseType(typeof(SEG_TB001_Usuario))]
        public IHttpActionResult GetSEG_TB001_Usuario(int id)
        {
            SEG_TB001_Usuario sEG_TB001_Usuario = db.SEG_TB001_Usuario.Find(id);
            if (sEG_TB001_Usuario == null)
            {
                return NotFound();
            }

            return Ok(sEG_TB001_Usuario);
        }

        // PUT: api/SEG_TB001_Usuario/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutSEG_TB001_Usuario(int id, SEG_TB001_Usuario sEG_TB001_Usuario)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != sEG_TB001_Usuario.A001_codigo)
            {
                return BadRequest();
            }

            db.Entry(sEG_TB001_Usuario).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SEG_TB001_UsuarioExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/SEG_TB001_Usuario
        [ResponseType(typeof(SEG_TB001_Usuario))]
        public IHttpActionResult PostSEG_TB001_Usuario(SEG_TB001_Usuario sEG_TB001_Usuario)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SEG_TB001_Usuario.Add(sEG_TB001_Usuario);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = sEG_TB001_Usuario.A001_codigo }, sEG_TB001_Usuario);
        }

        // DELETE: api/SEG_TB001_Usuario/5
        [ResponseType(typeof(SEG_TB001_Usuario))]
        public IHttpActionResult DeleteSEG_TB001_Usuario(int id)
        {
            SEG_TB001_Usuario sEG_TB001_Usuario = db.SEG_TB001_Usuario.Find(id);
            if (sEG_TB001_Usuario == null)
            {
                return NotFound();
            }

            db.SEG_TB001_Usuario.Remove(sEG_TB001_Usuario);
            db.SaveChanges();

            return Ok(sEG_TB001_Usuario);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SEG_TB001_UsuarioExists(int id)
        {
            return db.SEG_TB001_Usuario.Count(e => e.A001_codigo == id) > 0;
        }
    }
}